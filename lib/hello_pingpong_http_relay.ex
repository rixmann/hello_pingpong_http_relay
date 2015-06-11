defmodule HelloPingpongHttpRelay do
  use Application
  @decoder :hello_json
  @hello_pingpong_server_url 'zmq-tcp://127.0.0.1:26000'
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, HelloPingpongHttpRelay.Router, [], port: 8080)
    ]
    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloPingpongHttpRelay.Supervisor]
    :hello_client.start({:local, __MODULE__}, @hello_pingpong_server_url, [], [decoder: @decoder], [])
    Supervisor.start_link(children, opts)
  end

  def client() do
    :hello_client.call(__MODULE__, {"Server.ping", [], []})
  end

end
