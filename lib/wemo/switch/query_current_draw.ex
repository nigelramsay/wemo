defmodule Wemo.Switch.QueryCurrentDraw do
  import SweetXml

  @soap_client Application.get_env(:wemo, :soap_client,Wemo.Switch.Client.SoapClient)

  @spec current_draw(Wemo.Switch.Metadata) :: integer
  def current_draw(switch) do
    state = build_current_draw_query_xml()
    |> post_current_draw_query_request(switch)
    |> parse_current_draw_query_response

    state
  end

  defp build_current_draw_query_xml do
    """
    <?xml version="1.0" encoding="utf-8"?>
    <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
    <s:Body>
    <u:GetPower xmlns:u="urn:Belkin:service:insight:1"/>
    </s:Body>
    </s:Envelope>
    """
  end

  defp post_current_draw_query_request(xml, switch) do
    @soap_client.post_request(
      xml,
      "#{switch.base_url}/upnp/control/insight1",
      "urn:Belkin:service:insight:1#GetPower)"
    )
  end

  defp parse_current_draw_query_response(response_body) do
    xpath(response_body, ~x"//s:Envelope/s:Body/u:GetPowerResponse/InstantPower/text()"i)
  end
end
