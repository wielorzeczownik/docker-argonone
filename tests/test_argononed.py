import importlib.util
from pathlib import Path

import pytest

_spec = importlib.util.spec_from_file_location(
    "argononed", Path(__file__).parent.parent / "patches" / "argononed.py"
)
_mod = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(_mod)

get_fanspeed = _mod.get_fanspeed
load_config = _mod.load_config


class TestGetFanspeed:
    """
    Patch 1: remove 25% floor in get_fanspeed().
    Patch 2: remove forced 100% spin-up before applying speed.
    Both mean the configured duty cycle must be returned exactly.
    """

    CONFIG = [" 65.0=100", " 60.0=55", " 55.0=30"]

    def test_above_highest_threshold(self):
        assert get_fanspeed(70, self.CONFIG) == 100

    def test_at_highest_threshold(self):
        assert get_fanspeed(65, self.CONFIG) == 100

    def test_between_thresholds(self):
        assert get_fanspeed(62, self.CONFIG) == 55

    def test_at_lowest_threshold(self):
        assert get_fanspeed(55, self.CONFIG) == 30

    def test_below_all_thresholds_returns_0(self):
        assert get_fanspeed(40, self.CONFIG) == 0

    def test_empty_config_returns_0(self):
        assert get_fanspeed(80, []) == 0

    @pytest.mark.parametrize("speed", [1, 5, 10, 20, 24])
    def test_low_duty_cycle_returned_as_is(self, speed):
        """Speeds below the old 25% floor must not be raised to 100%."""
        config = [f" 50.0={speed}"]
        assert get_fanspeed(55, config) == speed

    def test_speed_0_turns_fan_off(self):
        config = [" 50.0=0"]
        assert get_fanspeed(55, config) == 0

    def test_speed_25_returned_as_is(self):
        config = [" 50.0=25"]
        assert get_fanspeed(55, config) == 25


class TestLoadConfig:
    def test_valid_entries_parsed_and_sorted_descending(self, tmp_path):
        cfg = tmp_path / "fan.conf"
        cfg.write_text("55=30\n65=100\n60=55\n")
        result = load_config(str(cfg))
        temps = [float(r.split("=")[0]) for r in result]
        assert temps == sorted(temps, reverse=True)
        assert len(result) == 3

    def test_comment_lines_skipped(self, tmp_path):
        cfg = tmp_path / "fan.conf"
        cfg.write_text("# this is a comment\n65=100\n")
        assert len(load_config(str(cfg))) == 1

    def test_empty_lines_skipped(self, tmp_path):
        cfg = tmp_path / "fan.conf"
        cfg.write_text("\n65=100\n\n60=55\n")
        assert len(load_config(str(cfg))) == 2

    def test_invalid_pair_skipped(self, tmp_path):
        cfg = tmp_path / "fan.conf"
        cfg.write_text("notapair\n65=100\n")
        assert len(load_config(str(cfg))) == 1

    def test_temperature_above_100_skipped(self, tmp_path):
        cfg = tmp_path / "fan.conf"
        cfg.write_text("101=100\n65=100\n")
        assert len(load_config(str(cfg))) == 1

    def test_temperature_below_0_skipped(self, tmp_path):
        cfg = tmp_path / "fan.conf"
        cfg.write_text("-1=50\n65=100\n")
        assert len(load_config(str(cfg))) == 1

    def test_fan_speed_above_100_skipped(self, tmp_path):
        cfg = tmp_path / "fan.conf"
        cfg.write_text("65=101\n60=55\n")
        assert len(load_config(str(cfg))) == 1

    def test_fan_speed_below_0_skipped(self, tmp_path):
        cfg = tmp_path / "fan.conf"
        cfg.write_text("65=-1\n60=55\n")
        assert len(load_config(str(cfg))) == 1

    def test_missing_file_returns_empty(self):
        assert load_config("/nonexistent/fan.conf") == []

    def test_low_fan_speed_0_accepted(self, tmp_path):
        """Load config must accept speed 0 — the patched daemon honours it."""
        cfg = tmp_path / "fan.conf"
        cfg.write_text("55=0\n")
        assert len(load_config(str(cfg))) == 1

    def test_low_fan_speed_10_accepted(self, tmp_path):
        """Load config must accept speeds below the old 30% floor."""
        cfg = tmp_path / "fan.conf"
        cfg.write_text("55=10\n")
        assert len(load_config(str(cfg))) == 1
