defmodule Wemo.Switch.Client.MockSoapClient do
  @moduledoc false

  @root_dir       File.cwd!
  @xml_dir        Path.join(~w(#{@root_dir} test fixtures xml))

  def post_request(_xml, url, "urn:Belkin:service:basicevent:1#SetBinaryState)") do
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

  def post_request(_xml, url, "urn:Belkin:service:basicevent:1#GetBinaryState)") do
    filename = case url do
      "http://192.168.1.100" <> _remaining ->
        "status_check_off_response.xml"
      "http://192.168.1.101" <> _remaining ->
        "status_check_on_response.xml"
      _ ->
        "state_change_error_response.xml"
    end

    {:ok, body} = Path.join(@xml_dir, filename)
    |> File.read

    body
  end
end
