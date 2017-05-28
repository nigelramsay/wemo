defmodule Wemo.SwitchMetadata do
  defstruct [:device_type, :friendly_name, :manufacturer, :manufacturer_url,
             :model_description, :model_name, :model_number, :model_url,
             :serial_number, :udn, :upc]
end
