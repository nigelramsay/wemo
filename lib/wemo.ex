defmodule Wemo do
  use Application

  def start(_type, _args) do
    Wemo.Supervisor.start_link(name: Wemo.Supervisor)
  end
end
