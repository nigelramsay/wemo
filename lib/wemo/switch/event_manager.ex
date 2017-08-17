defmodule Wemo.Switch.EventManager do
  use GenServer
  require Logger

  ##############
  # Client API #
  ##############

  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  def monitor_switch(switch) do
    GenServer.cast(__MODULE__, {:monitor_switch, switch})
  end

  def callback(subscription_id, status) do

  end

  ####################
  # Server Callbacks #
  ####################

  def init(state) do
    Logger.info "Starting EventManager"
    {:ok, state}
  end

  def handle_cast({:monitor_switch, switch}, state) do
    base_url = Wemo.Switch.SwitchManager.base_url(switch)
    request_url = "#{base_url}/upnp/event/basicevent1"

    {:ok, subscription_id} = Wemo.Switch.Client.SoapClient.subscribe_request(request_url, "http://#{ip}:4001/callback")

    Logger.info "Subscription id: #{subscription_id}"

    state = Map.put(state, subscription_id, switch)

    {:noreply, state}
  end

  defp ip do
    {ok, [{ip_address, _broadcast, _netmask}|_]} = :inet.getif()

    ip_address |> Tuple.to_list |> Enum.join(".")
  end
end
