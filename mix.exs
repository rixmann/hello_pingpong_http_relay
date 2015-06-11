defmodule HelloPingpongHttpRelay.Mixfile do
  use Mix.Project

  def project do
    [app: :hello_pingpong_http_relay,
     version: "0.0.1",
     elixir: "~> 1.1-dev",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :cowboy, :plug, :hello],
     mod: {HelloPingpongHttpRelay, []},
     env: [pingpong_api: 'zmq-tcp://127.0.0.1:26000',
           port: 8080]]
  end

  defp deps do
    [{:lager, "~> 2.1.1", override: true},
     {:cowboy, "~> 1.0.0", override: true},
     {:plug, "~> 0.12"},
     {:hello, github: "travelping/hello", branch: "hello_v3"},
     {:jsx, github: "talentdeficit/jsx", branch: "develop", override: true}]
  end
end
