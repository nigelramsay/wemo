defmodule Wemo.Switch.QueryStatus do
  import SweetXml

  @soap_client Application.get_env(:wemo, :soap_client, Wemo.Switch.Client.SoapClient)

  @spec status(Wemo.Switch.Metadata) :: 0|1
  def status(switch) do
    state = build_status_query_xml()
    |> post_status_query_request(switch)
    |> parse_status_query_response

    state
  end

  defp build_status_query_xml do
    """
    <?xml version="1.0" encoding="utf-8"?>
    <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
    <s:Body>
    <u:GetBinaryState xmlns:u="urn:Belkin:service:basicevent:1">
    </u:GetBinaryState>
    </s:Body>
    </s:Envelope>
    """
  end

  defp post_status_query_request(xml, switch) do
    @soap_client.post_request(
      xml,
      "#{switch.base_url}/upnp/control/basicevent1",
      "urn:Belkin:service:basicevent:1#GetBinaryState)"
    )
  end

  defp parse_status_query_response(response_body) do
    xpath(response_body, ~x"//s:Envelope/s:Body/u:GetBinaryStateResponse/BinaryState/text()"i)
  end
end
