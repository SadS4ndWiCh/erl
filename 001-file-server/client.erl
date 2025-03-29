-module(client).
-export([ls/1, read/2]).

ls(Server) ->
    Server ! {self(), list_dir},
    receive
        {Server, Files} ->
            Files
    end.

read(Server, File) ->
    Server ! {self(), {read_file, File}},
    receive
        {Server, Content} ->
            Content
    end.
