-module(client).
-export([ping/1, handshake/2, handshake/3]).

handshake(Server, syn) ->
    M = rand:uniform(10000),
    Server ! { self(), syn, M },
    io:format("[CLIENT] Sent SYN.~n"),

    Want = M + 1,
    receive
        { HS, syn_ack, Want, N } ->
            io:format("[CLIENT] Receive SYN ACK.~n"),
            handshake(HS, ack, N);
        { _, _, _, _ } ->
            io:format("[CLIENT] Fail SYN ACK.~n"),
            { Server, err }
    end.

handshake(HS, ack, N) ->
    HS ! { self(), ack, N + 1 },
    io:format("[CLIENT] Sent ACK.~n"),

    receive
        { Conn, ack_ack } ->
            io:format("[CLIENT] Receive ACK ACK.~n"),
            { Conn, ok };
        { _, _ } -> 
            io:format("[CLIENT] Fail ACK ACK.~n"),
            { HS, err }
    end.

ping(Server) when is_pid(Server) ->  
    ping(handshake(Server, syn));

ping({ _, err }) ->
    io:format("[CLIENT] Server failed to handshake.~n");

ping({ Conn, ok }) ->
    Conn ! { self(), ping },
    receive
        { Conn, pong } ->
            io:format("[CLIENT] Server pong.~n");
        { Conn, _ } ->
            io:format("[CLIENT] Server wasnt pong :c.~n")
    end.
