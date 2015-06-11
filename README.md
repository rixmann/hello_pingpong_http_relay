HelloPingpongHttpRelay
======================

HTTP server.
Sends ping requests to HelloPingpong for testing round trip time.

usage example:
--------------

starting:
  iex -S mix

issueing a http request to the relay:
  curl -X GET http://127.0.0.1:8080/ping

config options for env:
'''
[port: 8080,
 pingpong_api: 'zmq-tcp://127.0.0.1:26000']
'''