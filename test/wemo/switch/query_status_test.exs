defmodule Wemo.Switch.QueryStatusTest do
  use ExUnit.Case, async: true

  alias Wemo.Switch.QueryStatus

  describe "QueryStatusTest.status/1" do
    test "when in the off state" do
      switch_that_is_off = %Wemo.Switch.Metadata{
        base_url: "http://192.168.1.100",
        friendly_name: "Lounge"
      }

      assert QueryStatus.status(switch_that_is_off) == 0
    end

    test "when in the on state" do
      switch_that_is_on = %Wemo.Switch.Metadata{
        base_url: "http://192.168.1.101",
        friendly_name: "Lounge"
      }

      assert QueryStatus.status(switch_that_is_on) == 1
    end
  end
end
