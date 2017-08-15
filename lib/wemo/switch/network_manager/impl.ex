defmodule Wemo.Switch.NetworkManager.Impl do
  def new do
    %{}
  end

  def all(state) do
    state[:devices]
  end

  def refresh(state) do
    devices = Wemo.Switch.Discovery.all

    Map.put(state, :devices, devices)
  end
end
