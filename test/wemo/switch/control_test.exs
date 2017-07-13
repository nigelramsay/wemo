defmodule Wemo.Switch.ControlTest do
  use ExUnit.Case

  describe "ControlTest.set_state/2" do
    test "switching on (when in the off state)" do
      disabled_switch = %Wemo.Switch.Metadata{
        base_url: "http://192.168.1.100",
        friendly_name: "Lounge"
      }

      assert Wemo.Switch.Control.set_state(1, disabled_switch) == {:ok, 1}
    end

    test "switching off (when in the on state)" do
      enabled_switch = %Wemo.Switch.Metadata{
        base_url: "http://192.168.1.101",
        friendly_name: "Lounge"
      }

      assert Wemo.Switch.Control.set_state(0, enabled_switch) == {:ok, 0}
    end

    test "switching off (when in the off state)" do
      error_switch = %Wemo.Switch.Metadata{
        base_url: "http://192.168.1.102",
        friendly_name: "Lounge"
      }

      assert Wemo.Switch.Control.set_state(0, error_switch) == {:no_change, 0}
    end
  end
end
