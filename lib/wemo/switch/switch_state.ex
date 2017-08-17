defmodule Wemo.Switch.SwitchState do
  @moduledoc """
    Status of a Wemo Switch
  """

  @doc """
    Defines the Wemo switch metadata struct.
    * `:metadata` - the metadata as returned from the device
    * `:enabled_status` - 0 or 1
    * `:subscription_id` - as returned from the switch
  """
  defstruct [:metadata, :status, :discovery_url, :base_url]
end
