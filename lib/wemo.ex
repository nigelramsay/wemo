defmodule Wemo do
  @moduledoc """
  Documentation for Wemo.
  """

  alias Nerves.SSDPClient

  def switches do
    devices("controllee")
  end

  defp devices(device_type) do
    SSDPClient.discover(target: "urn:Belkin:device:#{device_type}:1")
  end
end
