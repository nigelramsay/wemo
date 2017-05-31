defmodule Wemo.Switch do

  import SweetXml
  alias Nerves.SSDPClient

  def find_by_name(name) do
    SSDPClient.discover(target: "urn:Belkin:device:controllee:1")
    |> Enum.map(&extract_url/1)
    # |> Enum.reject(&is_nil/1)
    |> Enum.map(&interrogate/1)
    |> Enum.map(&extract_friendly_name/1)
    # |> Enum.find(fn(_switch) -> name == "cheese" end)

    # inspect(urls) |> IO.puts
  end

  defp extract_url({_, %{location: location}}) do
    location
  end

  # use httpotion to call the URL
  defp interrogate(url) do
    %{status_code: 200, body: body} = response = HTTPotion.get(url)
    body
  end

  # use sweet_xml to parse and extract the response
  defp extract_friendly_name(xml) do
    xpath(xml, ~x"//root/device/friendlyName/text()")
  end
end
