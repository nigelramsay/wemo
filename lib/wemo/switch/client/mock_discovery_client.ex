defmodule Wemo.Switch.Client.MockDiscoveryClient do
  @root_dir       File.cwd!
  @xml_dir        Path.join(~w(#{@root_dir} test fixtures xml))

  def discover(target: _target) do
    ["http://192.168.1.100:1234"]
  end

  def query_metadata(url) do
    {:ok, body} = Path.join(@xml_dir, "wemo_setup.xml")
    |> File.read

    {url, body}
  end
end
