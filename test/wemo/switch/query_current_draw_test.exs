defmodule Wemo.Switch.QueryCurrentDrawTest do
  use ExUnit.Case, async: true

  alias Wemo.Switch.QueryCurrentDraw

  describe "QueryCurrentDrawTest.current_draw/1" do
    test "returns the current draw" do
      switch = %Wemo.Switch.Metadata{
        base_url: "http://192.168.1.100",
        friendly_name: "Lounge"
      }

      assert QueryCurrentDraw.current_draw(switch) == 92170
    end
  end
end
