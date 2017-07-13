defmodule Wemo.Switch.Client.MockSoapClient do
  @root_dir       File.cwd!
  @xml_dir        Path.join(~w(#{@root_dir} test fixtures xml))

  def post_request(_xml, url, _soap_action) do
    filename = case url do
      "http://192.168.1.100" <> _remaining ->
        "state_change_to_off_response.xml"
      "http://192.168.1.101" <> _remaining ->
        "state_change_to_on_response.xml"
      _ ->
        "state_change_error_response.xml"
    end

    {:ok, body} = Path.join(@xml_dir, filename)
    |> File.read

    body
  end
end
