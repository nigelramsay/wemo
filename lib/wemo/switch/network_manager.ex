defmodule Wemo.Switch.NetworkManager do
  def new do
    GenServer.start_link(Wemo.Switch.NetworkManager.Server, :ok)
  end

  def refresh do
    GenServer.cast(Wemo.Switch.NetworkManager.Server, {:refresh})
  end

  def all do
    GenServer.call(Wemo.Switch.NetworkManager.Server, {:all})
  end

  def find_by_name(name) do
    GenServer.call(Wemo.Switch.NetworkManager.Server, {:find_by_name, name})    
  end
end
