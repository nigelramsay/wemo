defmodule Wemo.Switch.NetworkManager.Impl do
  # def new do
  #   %{}
  # end

  def all(state) do
    state[:switches]
  end

  def refresh(state) do
    switches = Wemo.Switch.Discovery2.all
    |> Enum.map(&manage_switch/1)

    Map.put(state, :switches, switches)
  end

  defp manage_switch(base_url) do
    {:ok, pid} = Wemo.Switch.SwitchManager.start_link(base_url)

    pid
  end
end
