defmodule Wemo.Switch.DiscoveryServer do
  use GenServer

  ##############
  # Client API #
  ##############

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def all do
    GenServer.call(__MODULE__, {:all})
  end

  def refresh do
    GenServer.cast(__MODULE__, {:refresh})
  end

  ####################
  # Server Callbacks #
  ####################

  def init(:ok) do
    Wemo.Switch.DiscoveryServer.refresh

    {:ok, %{}}
  end

  def handle_call({:all}, _from, state) do
    {:reply, state[:devices], state}
  end

  def handle_cast({:refresh}, state) do
    devices = Wemo.Switch.Discovery.all    

    newState = Map.put(state, :devices, devices)

    {:noreply, newState}
  end

  def handle_info(msg, state) do
    IO.puts "DiscoveryServer: ${msg}"
    {:noreply, state}
  end
end
