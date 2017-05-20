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
  "Laundry" |> Wemo.Switch.by_name |> Wemo.Switch.status
  => {:ok, 1}

  "Living Room" |> Wemo.Switch.by_name |> Wemo.Switch.on
  => {:ok, _}
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/wemo](https://hexdocs.pm/wemo).
