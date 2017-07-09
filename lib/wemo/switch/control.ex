defmodule Wemo.Switch.Control do
  import SweetXml

  @path "upnp/control/basicevent1"
  @urn "urn:Belkin:service:basicevent:1"

  def set_state(state, %Wemo.Switch.Metadata{}=switch) when state in [0, 1] do
    result = state
    |> build_state_change_request
    |> submit_request(switch)
    |> parse_state_change_response

    {result, state}
  end

  def build_state_change_request(state) do
    """
    <?xml version="1.0" encoding="utf-8"?>
    <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
    <s:Body>
    <u:SetBinaryState xmlns:u="#{@urn}">
    <BinaryState>#{state}</BinaryState>
    </u:SetBinaryState>
    </s:Body>
    </s:Envelope>
    """
  end

  def submit_request(xml, switch) do
    response = HTTPotion.post("#{switch.base_url}/#{@path}", [
      body: xml,
      headers: [
        "SOAPACTION": "\"#{@urn}#SetBinaryState\"",
        "Content-Type": "text/xml; charset=\"utf-8\""
      ]
    ])

    %{status_code: 200, body: body} = response

    body
  end

  def parse_state_change_response(response_body) do
    state = xpath(response_body, ~x"//s:Envelope/s:Body/u:SetBinaryStateResponse/BinaryState/text()")

    case state do
      '0' -> :ok
      '1' -> :ok
      'Error' -> :no_change
    end
  end
end
