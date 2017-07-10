defmodule Wemo.Switch.DiscoveryTest do
  use ExUnit.Case

  alias Wemo.Switch.Discovery

  describe "Wemo.all/0" do
    test "returns expected metadata" do
      results = Wemo.Switch.Discovery.all()

      [result] = results

      assert result == %Wemo.Switch.Metadata{
        base_url: "http://192.168.1.100:1234",
        device_type: 'urn:Belkin:device:controllee:1',
        friendly_name: 'WeMo Switch',
        manufacturer: 'Belkin International Inc.',
        manufacturer_url: 'http://www.belkin.com',
        model_description: 'Belkin Plugin Socket 1.0',
        model_name: 'Socket',
        model_number: '1.0',
        model_url: 'http://www.belkin.com/plugin/',
        serial_number: '123553K1100033',
        udn: 'uuid:Socket-1_0-123553K1100033',
        upc: '123456789'
      }
    end
  end
end
