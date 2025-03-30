-module(server).
-export([init/0, loop/0, handshake/4, connection/2]).

init() -> spawn(server, loop, []).

connection(Server, From) ->
    From ! { self(), ack_ack },

    receive
        { From, ping } ->
            From ! { self(), pong }
    end,

    connection(Server, From).

handshake(Server, From, syn, M) ->
    N = rand:uniform(1000),
    Want = N + 1,

    From ! { self(), syn_ack, M + 1, N },
    receive
        { From, ack, Want } ->
            spawn(server, connection, [Server, From]);
        { From, _, _ } ->
            From ! { self(), fin }
    end.

loop() ->
    receive
        { From, syn, M } ->
            spawn(server, handshake, [self(), From, syn, M])
    end,

    loop().
