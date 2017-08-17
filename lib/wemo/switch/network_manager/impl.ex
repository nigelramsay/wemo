defmodule Wemo.Switch.NetworkManager.Impl do
  # def new do
  #   %{}
  # end

  def all(state) do
    state[:switches]
  end

  def refresh(state) do
    switches_urls = Wemo.Switch.Discovery2.all

    managed_switches = Enum.map(switches_urls, &manage_switch/1)

    Map.put(state, :switches, managed_switches)
  end

  def find_by_name(name, state) do
    Enum.find(state[:switches], fn(sw) -> name == Wemo.Switch.SwitchManager.friendly_name(sw) end)
  end

  defp manage_switch(base_url) do
    {:ok, pid} = Wemo.Switch.SwitchManager.start_link(base_url)

    pid
  end
end
