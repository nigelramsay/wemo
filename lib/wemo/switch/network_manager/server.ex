defmodule Wemo.Switch.NetworkManager.Server do
  use GenServer
  alias Wemo.Switch.NetworkManager.Impl

  def start_link(opts) do
    {:ok, pid} = GenServer.start_link(__MODULE__, :ok, opts)
    GenServer.cast(pid, {:refresh})
    {:ok, pid}
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:all}, _from, state) do
    result = Impl.all(state)
    {:reply, result, state}
  end

  def handle_call({:find_by_name, name}, _from, state) do
    result = Impl.find_by_name(name, state)
    {:reply, result, state}
  end

  def handle_cast({:refresh}, state) do
    {:noreply, Impl.refresh(state)}
  end
end
