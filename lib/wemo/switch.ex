defmodule Wemo.Switch do
  def find_by_name(name) do
    Wemo.Switch.Discovery.all()
    |> Enum.find(fn(switch) -> name == to_string(switch.friendly_name) end)
  end

  def all do
    Wemo.Switch.Discovery.all
  end

  def on(switch) do
    set_state(1, switch)
  end

  def off(switch) do
    set_state(0, switch)
  end

  def set_state(state, %Wemo.Switch.Metadata{}=switch) when state in [0, 1] do
    state |> Wemo.Switch.Control.set_state(switch)
  end
end
