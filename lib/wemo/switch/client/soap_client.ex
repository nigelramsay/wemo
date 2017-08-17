defmodule Wemo.Switch.Client.SoapClient do
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

  def subscribe_request(request_url, callback_url, timeout\\600) do
    response = HTTPotion.request(:subscribe, request_url, [
      headers: [
        "CALLBACK": "<#{callback_url}>",
        "NT": "upnp:event",
        "TIMEOUT": "Second-#{timeout}"
      ]
    ])

    %{status_code: 200, headers: %{hdrs: headers}} = response

    {:ok, headers["sid"]}
  end
end
