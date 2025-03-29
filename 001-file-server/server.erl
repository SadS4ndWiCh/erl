-module(server).
-export([start/1, loop/1]).

start(Path) -> spawn(server, loop, [Path]).

loop(Path) ->
    receive
        {Client, list_dir} ->
            Client ! {self(), file:list_dir(Path)};
        {Client, {read_file, File}} ->
            FullPath = filename:join(Path, File),
            Client ! {self(), file:read_file(FullPath)}
    end,
    
    loop(Path).
