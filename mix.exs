defmodule Wemo.Mixfile do
  use Mix.Project

  def project do
    [app: :wemo,
     version: "0.1.4",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     name: "Wemo",
     source_url: "https://github.com/nigelramsay/wemo",
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:nerves_ssdp_client, "~> 0.1.0"},
      {:httpotion, "~> 3.0.2"},
      {:sweet_xml, "~> 0.6.5"},
      {:ex_guard, "~> 1.2", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  defp description do
    """
    An Elixir package for discovering and controlling Belkin Wemo devices.
    """
  end

  defp package do
    [
      name: :wemo,
      maintainers: ["Nigel Ramsay"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/nigelramsay/wemo"}
    ]
  end
end
