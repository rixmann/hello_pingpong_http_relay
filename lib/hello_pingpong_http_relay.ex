defmodule HelloPingpongHttpRelay do
  use Application
  @decoder :hello_json
  def start(_type, _args) do
    {:ok, url} = :application.get_env(:hello_pingpong_http_relay, :pingpong_api)
    {:ok, port} = :application.get_env(:hello_pingpong_http_relay, :port)
    :hello_client.start({:local, __MODULE__}, url, [], [decoder: @decoder], [])

    import Supervisor.Spec, warn: false
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, HelloPingpongHttpRelay.Router, [], port: port)
    ]
    opts = [strategy: :one_for_one, name: HelloPingpongHttpRelay.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def ping() do
    :hello_client.call(__MODULE__, {"Server.ping", [], []})
  end
end
