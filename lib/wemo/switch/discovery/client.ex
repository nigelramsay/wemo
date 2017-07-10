defmodule Wemo.Switch.Discovery.Client do
  alias Nerves.SSDPClient

  def discover(target: target) do
    SSDPClient.discover(target: target)
    |> Enum.map(fn({_, result}) -> result.location end)
  end

  def query_metadata(url) do
    %{status_code: 200, body: body} = HTTPotion.get(url)
    {url, body}
  end
end
