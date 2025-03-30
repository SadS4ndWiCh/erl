-module(client).
-export([ping/1]).

ping(Server) ->
    M = rand:uniform(100),
    Server ! { self(), ping, M },

    Want = M + 1,

    receive
        { _, _, Want } = { From, pong, _ } ->
            io:format("[CLIENT] Server ponged!~n"),
            From ! { self(), ok };
        { From, _, _ } ->
            io:format("[CLIENT] Server replyed with wrong seq number~n"),
            From ! { self(), dis }
    end.

