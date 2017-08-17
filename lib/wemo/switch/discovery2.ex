defmodule Wemo.Switch.Discovery2 do
  import SweetXml

  @discovery_client Application.get_env(:wemo, :discovery_client, Wemo.Switch.Client.DiscoveryClient)

  def all do
    @discovery_client.discover(target: "urn:Belkin:device:controllee:1")
    # |> Enum.map(&query_device/1)
    # |> Enum.map(&extract_metadata/1)
  end

  def query_device(url) do
    @discovery_client.query_metadata(url)
    |> extract_metadata
  end

  defp extract_metadata({url, xml}) do
    %Wemo.Switch.Metadata{
      base_url: extract_base_url(url),
      device_type: xpath(xml, ~x"//root/device/deviceType/text()"s),
      friendly_name: xpath(xml, ~x"//root/device/friendlyName/text()"s),
      manufacturer: xpath(xml, ~x"//root/device/manufacturer/text()"s),
      manufacturer_url: xpath(xml, ~x"//root/device/manufacturerURL/text()"s),
      model_description: xpath(xml, ~x"//root/device/modelDescription/text()"s),
      model_name: xpath(xml, ~x"//root/device/modelName/text()"s),
      model_number: xpath(xml, ~x"//root/device/modelNumber/text()"s),
      model_url: xpath(xml, ~x"//root/device/modelURL/text()"s),
      serial_number: xpath(xml, ~x"//root/device/serialNumber/text()"s),
      udn: xpath(xml, ~x"//root/device/UDN/text()"s),
      upc: xpath(xml, ~x"//root/device/UPC/text()"s)
    }
  end

  defp extract_base_url(full_url) do
    uri = URI.parse(full_url)

    "#{uri.scheme}://#{uri.host}:#{uri.port}"
  end
end
