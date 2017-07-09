defmodule Wemo.Switch.Control do
  @path "upnp/control/basicevent1"
  @urn "urn:Belkin:service:basicevent:1"

  def set_state(state, %Wemo.Switch.Metadata{}=switch) do
    state
    |> build_state_change_request
    |> submit_request(switch)
    |> parse_state_change_response
  end

  def build_state_change_request(state) do
    """
    <?xml version="1.0" encoding="utf-8"?>
    <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
    <s:Body>
    <u:SetBinaryState xmlns:u="#{@urn}">
    <BinaryState>#{if(state, do: "1", else: "0")}</BinaryState>
    </u:SetBinaryState>
    </s:Body>
    </s:Envelope>
    """
  end

  def submit_request(xml, switch) do
    uri = "#{switch.base_url}/#{@path}"
    IO.puts uri
    response = HTTPotion.post(uri, [
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
    response_body
  end
end
