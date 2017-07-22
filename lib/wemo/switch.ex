defmodule Wemo.Switch do
  @moduledoc """
    Query and change the on/off status of Wemo Switches using the functions in this module.
  """

  alias Wemo.Switch.Discovery
  alias Wemo.Switch.QueryStatus
  alias Wemo.Switch.ChangeStatus
  alias Wemo.Switch.Metadata

  @doc """
    Search for a Wemo Switch with the assigned name.
  """
  def find_by_name(name) do
    Discovery.all()
    |> Enum.find(fn(switch) -> name == to_string(switch.friendly_name) end)
  end

  def all do
    Discovery.all
  end

  @doc """
    Switches on the supplied switch. For example:

    iex> Wemo.Switch.find_by_name("WeMo Switch") |> Wemo.Switch.on
    {:ok, 1}

    If the switch was already on, the returned value is {:no_change, 1}
  """
  def on(switch) do
    set_state(1, switch)
  end

  @doc """
    Switches off the supplied switch. For example:

    iex> Wemo.Switch.find_by_name("WeMo Switch") |> Wemo.Switch.off
    {:ok, 0}

    If the switch was already off, the returned value is {:no_change, 0}
  """
  def off(switch) do
    set_state(0, switch)
  end

  @doc """
    Checks and returns the status of the supplied switch. For example:

    iex> Wemo.Switch.find_by_name("WeMo Switch") |> Wemo.Switch.status
    0
  """
  def status(switch) do
    QueryStatus.status(switch)
  end

  defp set_state(state, %Metadata{}=switch) when state in [0, 1] do
    state |> ChangeStatus.set_state(switch)
  end
end
