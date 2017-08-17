defmodule Wemo.Switch.SwitchManager do
  use GenServer
  require Logger

  ##############
  # Client API #
  ##############

  def start_link(discovery_url) do
    {:ok, switch} = GenServer.start_link(__MODULE__, %Wemo.Switch.SwitchState{discovery_url: discovery_url})
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

  def base_url(switch) do
    %{base_url: url} = GenServer.call(switch, {:metadata})
    url
  end

  def friendly_name(switch) do
    %{friendly_name: friendly_name} = GenServer.call(switch, {:metadata})
    friendly_name
  end

  ####################
  # Server Callbacks #
  ####################

  def init(state) do
    Logger.info "Starting SwitchManager for #{state.discovery_url}"
    {:ok, state}
  end

  def handle_call({:change_status, new_status}, _from, state) do
    {:ok, updated_status} = Wemo.Switch.ChangeStatus2.set_state(new_status, state.base_url)

    state = Map.put(state, :status, updated_status)

    {:reply, {:ok, new_status}, state}
  end

  def handle_call({:status, true}, _from, state) do
    result = Wemo.Switch.QueryStatus2.status(state.base_url)
    state = Map.put(state, :status, result)

    {:reply, {:ok, result}, state}
  end

  def handle_call({:status, false}, _from, state) do
    {:reply, {:ok, state.status}, state}
  end

  def handle_call({:metadata}, _from, state) do
    {:reply, state.metadata, state}
  end

  def handle_cast({:initialise}, state) do
    discovery_url = state.discovery_url
    base_url = extract_base_url(discovery_url)

    metadata = Wemo.Switch.Discovery2.query_device(discovery_url)
    status = Wemo.Switch.QueryStatus2.status(base_url)

    state = state
    |> Map.put(:metadata, metadata)
    |> Map.put(:base_url, base_url)
    |> Map.put(:status, status)

    Wemo.Switch.EventManager.monitor_switch(self)

    {:noreply, state}
  end

  defp extract_base_url(full_url) do
    uri = URI.parse(full_url)

    "#{uri.scheme}://#{uri.host}:#{uri.port}"
  end
end
