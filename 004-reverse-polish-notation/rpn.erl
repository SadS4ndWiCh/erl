-module(rpn).
-export([solve/1]).

solve(Expr) -> solve(Expr, []).

%% Base cases
solve([], []) -> { ok, 0 };
solve([],  S) -> { err, S }; %% Retuning the stack only for testing purpose
solve([N|[]], []) when is_number(N) -> { ok, N };
solve([O|_],  []) when is_atom(O)   -> { err, nil };
solve([O|_],  []) when is_atom(O)   -> { err, nil };

solve([N|T],   S) when is_number(N) -> solve(T, [N] ++ S);

%% Operators with two operands
solve([add|T],  [A|[B|S]]) -> solve([B+A] ++ T, S);
solve([sub|T],  [A|[B|S]]) -> solve([B-A] ++ T, S);
solve([mul|T],  [A|[B|S]]) -> solve([B*A] ++ T, S);
solve([tdiv|T], [A|[B|S]]) -> solve([B/A] ++ T, S);

solve([add|_],  [_|[]]) -> { err, nil };
solve([sub|_],  [_|[]]) -> { err, nil };
solve([mul|_],  [_|[]]) -> { err, nil };
solve([tdiv|_], [_|[]]) -> { err, nil };

%% Operators with one operand
solve([pow|T], [A|S]) -> solve([A * A] ++ T, S);

solve([pow|_], []) -> { err, nil }.
