use Mix.Config

config :wemo, discovery_client: Wemo.Switch.Client.MockDiscoveryClient,
              soap_client: Wemo.Switch.Client.MockSoapClient
