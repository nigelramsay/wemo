defmodule Wemo.Switch.HTTP.EventListener do
  import SweetXml
  require Logger

  def init(default_opts) do
    IO.puts "starting up WemoListener..."
    default_opts
  end

  def call(conn, _opts) do
    route(conn.method, conn.request_path, conn)
  end

  defp route("GET", _, conn) do
    IO.puts "Saying hello WeMo"
    Plug.Conn.send_resp(conn, 200, "Hello WeMo!")
  end

  defp route("NOTIFY", "/callback", conn) do
    Logger.info "Incoming notification event"
    subscription_id = Plug.Conn.get_req_header(conn, "sid")
    {:ok, body, conn} = Plug.Conn.read_body(conn)
    Logger.info "Body: #{body}"
    new_state = parse_event_body(body)

    Logger.info "Subscription id: #{subscription_id}; new state: #{new_state}"

    conn = Plug.Conn.put_resp_header(conn, "agent", "Elixir Wemo")
    |> Plug.Conn.put_resp_content_type("text/plain")

    Plug.Conn.send_resp(conn, 200, "OK")
  end

  defp parse_event_body(xml) do
    xpath(xml, ~x"//e:propertyset/e:property/BinaryState/text()"i)
  end
end
