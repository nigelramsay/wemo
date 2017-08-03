defmodule Wemo.Switch.HTTP.EventListener do
  def init(default_opts) do
    IO.puts "starting up WemoListener..."
    default_opts
  end

  def call(conn, _opts) do
    route(conn.method, conn.request_path, conn)
  end

  def route("GET", "/hello", conn) do
    IO.puts "saying hello"
    Plug.Conn.send_resp(conn, 200, "Hello")
  end

  def route("GET", _, conn) do
    IO.puts "saying hello WeMo"
    Plug.Conn.send_resp(conn, 200, "Hello WeMo!")
  end

  def route("NOTIFY", "/", conn) do
    IO.puts "OK"
    Plug.Conn.send_resp(conn, 200, "OK")
  end
end
