defmodule HelloPingpongHttpRelay.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/ping" do
    HelloPingpongHttpRelay.ping
    send_resp(conn, 200, "pong")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
