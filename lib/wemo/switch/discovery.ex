defmodule Wemo.Switch.Discovery do
  import SweetXml

  @client Application.get_env(:wemo, :discovery_client)

  def all do
    @client.discover(target: "urn:Belkin:device:controllee:1")
    |> Enum.map(&query_device/1)
    |> Enum.map(&extract_metadata/1)
  end

  def query_device(url) do
    @client.query_metadata(url)
  end

  def extract_metadata({url, xml}) do
    %Wemo.Switch.Metadata{
      base_url: extract_base_url(url),
      device_type: xpath(xml, ~x"//root/device/deviceType/text()"),
      friendly_name: xpath(xml, ~x"//root/device/friendlyName/text()"),
      manufacturer: xpath(xml, ~x"//root/device/manufacturer/text()"),
      manufacturer_url: xpath(xml, ~x"//root/device/manufacturerURL/text()"),
      model_description: xpath(xml, ~x"//root/device/modelDescription/text()"),
      model_name: xpath(xml, ~x"//root/device/modelName/text()"),
      model_number: xpath(xml, ~x"//root/device/modelNumber/text()"),
      model_url: xpath(xml, ~x"//root/device/modelURL/text()"),
      serial_number: xpath(xml, ~x"//root/device/serialNumber/text()"),
      udn: xpath(xml, ~x"//root/device/UDN/text()"),
      upc: xpath(xml, ~x"//root/device/UPC/text()")
    }
  end

  def extract_base_url(full_url) do
    uri = URI.parse(full_url)

    "#{uri.scheme}://#{uri.host}:#{uri.port}"
  end
end
