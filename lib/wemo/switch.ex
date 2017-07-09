defmodule Wemo.Switch do
  def find_by_name(name) do
    Wemo.Switch.Discovery.all()
    |> Enum.find(fn(switch) -> name == to_string(switch.friendly_name) end)
  end

  def all do
    Wemo.Switch.Discovery.all
  end
end
