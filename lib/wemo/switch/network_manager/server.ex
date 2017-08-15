defmodule Wemo.Switch.NetworkManager.Server do
  use GenServer
  alias Wemo.Switch.NetworkManager.Impl

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    Wemo.Switch.NetworkManager.refresh

    {:ok, %{}}
  end

  def handle_call({:all}, _from, state) do
    result = Impl.all(state)
    {:reply, result, state}
  end

  def handle_cast({:refresh}, state) do
    {:noreply, Impl.refresh(state)}
  end
end
