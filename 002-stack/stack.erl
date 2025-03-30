-module(stack).
-export([push/2, pop/1, iter/1]).

push(Value, []) ->
    [Value];

push(Value, T) ->
    [Value] ++ T.

pop([]) ->
    [];

pop([Head | Tail]) ->
    {Head, Tail}.

iter([]) ->
    io:format("Finish!\n");

iter([Head | Tail]) ->
    io:format(Head ++ "\n"),
    iter(Tail).
