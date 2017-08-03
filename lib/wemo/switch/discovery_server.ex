defmodule Wemo.Switch.DiscoveryServer do
  use GenServer

  def init(:ok) do
    {:ok, %{}}
  end
end
