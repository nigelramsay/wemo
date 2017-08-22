# Wemo

Elixir package for discovering and controlling Belkin Wemo devices.

[![Build Status](https://travis-ci.org/nigelramsay/wemo.svg?branch=master)](https://travis-ci.org/nigelramsay/wemo)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `wemo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:wemo, "~> 0.1.0"}]
end
```

## Usage examples

Searching for a specific switch:

```elixir-lang
Wemo.Switch.find_by_name("Laundry") |> Switch.status
=> {:ok, 1}
```

Turning a switch on and off:

```elixir-lang
living_room = Wemo.Switch.find_by_name("Living Room")
Switch.on(living_room)
=> {:ok, 1}

Switch.off(living_room)
=> {:ok, 0}
```

Checking the status of a switch:

```elixir-lang
Wemo.Switch.on?(living_room)
=> true

Wemo.Switch.off?(living_room)
=> true

Wemo.Switch.status(living_room)
=> 1
```

Checking the current draw of a switch (for switches like WeMo Insight that support this functionality):

```elixir-lang
Wemo.Switch.current_draw(living_room)
=> 92170
```
