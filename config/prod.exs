use Mix.Config

config :wemo, discovery_client: Wemo.Switch.Client.DiscoveryClient,
              soap_client: Wemo.Switch.Client.SoapClient
