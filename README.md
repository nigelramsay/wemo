# Wemo

Elixir package for discovering and controlling Belkin Wemo devices.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `wemo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:wemo, "~> 0.1.0"}]
end
```

## Usage examples

```elixir-lang

Wemo.Switch.find_by_name("Laundry") |> Switch.status
=> {:ok, 1}

living_room = Wemo.Switch.find_by_name("Living Room")
Switch.on!(living_room)
=> {:ok, 1}

Wemo.Switch.on?(living_room)
=> true
```
