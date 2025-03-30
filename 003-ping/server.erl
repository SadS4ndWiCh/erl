-module(server).
-export([init/0, loop/0]).

init() -> spawn(server, loop, []).

loop() ->
    receive
        { From, ping, M } ->
            io:format("[SERVER] Client pinged!~n"),
            From ! { self(), pong, M + 1 };
        { From, ok } ->
            io:format("[SERVER] Client connected~n");
        { From, dis } ->
            io:format("[SERVER] Client disconnected~n")
    end,

    loop().
