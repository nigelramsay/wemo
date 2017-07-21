defmodule Wemo.SwitchTest do
  use ExUnit.Case

  alias Wemo.Switch

  describe "Switch.find_by_name/1" do
    test "for an unknown switch" do
      assert Switch.find_by_name("none") == nil
    end

    test "for a known switch" do
      result = Switch.find_by_name("WeMo Switch")

      assert result.friendly_name == 'WeMo Switch'
    end
  end

  test "Switch.all/0" do
    results = Switch.all

    assert length(results) == 1

    [first|_] = results

    assert first.friendly_name == 'WeMo Switch'
  end

  describe "Switch.on/1" do
    test "for a switch that is off" do
      switch = %Wemo.Switch.Metadata{
        friendly_name: "WeMo Switch",
        base_url: "http://192.168.1.101"
      }

      assert Switch.on(switch) == {:ok, 1}
    end

    test "for a switch that is on" do
      switch = %Wemo.Switch.Metadata{
        friendly_name: "WeMo Switch",
        base_url: "http://192.168.1.110"
      }

      assert Switch.on(switch) == {:no_change, 1}
    end
  end

  describe "Switch.off/1" do
    test "for a switch that is off" do
      switch = %Wemo.Switch.Metadata{
        friendly_name: "WeMo Switch",
        base_url: "http://192.168.1.100"
      }

      assert Switch.off(switch) == {:ok, 0}
    end

    test "for a switch that is on" do
      switch = %Wemo.Switch.Metadata{
        friendly_name: "WeMo Switch",
        base_url: "http://192.168.1.110"
      }

      assert Switch.off(switch) == {:no_change, 0}
    end
  end
end
