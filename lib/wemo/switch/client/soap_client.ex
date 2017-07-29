defmodule Wemo.Switch.Client.SoapClient do
  @moduledoc false

  def post_request(xml, url, soap_action) do
    response = HTTPotion.post(url, [
      body: xml,
      headers: [
        "SOAPACTION": "\"#{soap_action}\"",
        "Content-Type": "text/xml; charset=\"utf-8\""
      ]
    ])

    %{status_code: 200, body: body} = response

    body
  end
end
