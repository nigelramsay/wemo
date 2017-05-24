defmodule Wemo.Switch do

  alias Nerves.SSDPClient

  def find_by_name(name) do
    SSDPClient.discover(target: "urn:Belkin:device:controllee:1")
    |> Enum.map(&extract_url/1)
    # |> Enum.reject(&is_nil/1)
    |> Enum.map(&interrogate/1)
    # |> Enum.find(fn(_switch) -> name == "cheese" end)

    # inspect(urls) |> IO.puts
  end

  defp extract_url({_, %{location: location}}) do
    location
  end

  # use httpotion to call the URL
  defp interrogate(url) do
    inspect(url) |> IO.puts
  end

  # use sweet_xml to parse and extract the response
  defp extract_state(response) do

  end
end
