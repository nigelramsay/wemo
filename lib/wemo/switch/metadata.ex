defmodule Wemo.Switch.Metadata do
  @moduledoc """
    Metadata of a Wemo Switch
  """

  @doc """
    Defines the Wemo switch metadata struct.
    * `:device_type` - the device type
    * `:friendly_name` - the user-supplied name of the device
    * `:manufacturer` - the manufacturer's name
    * `:manufacturer_url` - the URL of the manufacturer's website
    * `:model_description` - the description of the switch model
    * `:model_name` - the name of the model
    * `:model_number` - the version number of the model
    * `:model_url` - the URL to the manufacturer's model page
    * `:serial_number` - the unique serial number of this switch
    * `:udn` - the UDN (another unique identifier)
    * `:upc` - the UPC
    * `:base_url` - the base URL of this device (used for issueing further commands)
  """
  defstruct [:device_type, :friendly_name, :manufacturer, :manufacturer_url,
             :model_description, :model_name, :model_number, :model_url,
             :serial_number, :udn, :upc, :base_url]
end
