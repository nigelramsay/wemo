defmodule Wemo.Switch.SwitchManager do
  use GenServer

  ##############
  # Client API #
  ##############

  def start_link(discovery_url) do
    {:ok, switch} = GenServer.start_link(__MODULE__, %{discovery_url: discovery_url})
    GenServer.cast(switch, {:initialise})
    {:ok, switch}
  end

  def on(switch) do
    GenServer.call(switch, {:change_status, 1})
  end

  def off(switch) do
    GenServer.call(switch, {:change_status, 0})
  end

  def status(switch, force \\ false) do
    GenServer.call(switch, {:status, force})
  end

  ####################
  # Server Callbacks #
  ####################

  def init(state) do
    {:ok, state}
  end

  def handle_call({:change_status, new_status}, _from, state) do
    {:ok, updated_status} = Wemo.Switch.ChangeStatus2.set_state(new_status, state[:base_url])

    state = Map.put(state, :status, updated_status)

    {:reply, {:ok, new_status}, state}
  end

  def handle_call({:status, true}, _from, state) do
    result = Wemo.Switch.QueryStatus2.status(state[:base_url])
    state = Map.put(state, :status, result)

    {:reply, {:ok, result}, state}
  end

  def handle_call({:status, false}, _from, state) do
    {:reply, {:ok, state[:status]}, state}
  end

  def handle_cast({:initialise}, state) do
    discovery_url = state[:discovery_url]
    base_url = extract_base_url(discovery_url)

    metadata = Wemo.Switch.Discovery2.query_device(discovery_url)
    status = Wemo.Switch.QueryStatus2.status(base_url)

    state = state
    |> Map.put(:metadata, metadata)
    |> Map.put(:base_url, base_url)
    |> Map.put(:status, status)

    {:noreply, state}
  end

  defp extract_base_url(full_url) do
    uri = URI.parse(full_url)

    "#{uri.scheme}://#{uri.host}:#{uri.port}"
  end
end
