defmodule Wemo.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {Wemo.Switch.NetworkManager.Server, name: Wemo.Switch.NetworkManager.Server},
      {Plug.Adapters.Cowboy, scheme: :http, plug: Wemo.Switch.HTTP.EventListener, options: [port: 4001]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
