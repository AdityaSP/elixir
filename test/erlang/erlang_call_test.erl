-module(erlang_call_test).
-export([match/0]).
-include_lib("eunit/include/eunit.hrl").

match() -> abs.

erlang_atoms_test() ->
  {abs, []} = elixir:eval("Erlang.abs").

erlang_tuple_test() ->
  {[erlang,1,2], []} = elixir:eval("{ :erlang, 1, 2 }.tuple_to_list").

erlang_local_test() ->
  {1, []} = elixir:eval(":abs.(-1)"),
  {1, []} = elixir:eval(".(:abs)(-1)").

erlang_call_test() ->
  {1, []}   = elixir:eval("Erlang.erlang.abs(-1)"),
  {_, []}   = elixir:eval("Erlang.dict.new"),
  {_, []}   = elixir:eval("Erlang.dict.new()"),
  {abs, []} = elixir:eval("Erlang.erlang_call_test.match()").

dynamic_atom_erlang_call_test() ->
  Date = erlang:date(),
  {Date, []} = elixir:eval(".(:erlang, :date)()"),
  {1, []} = elixir:eval(".(:erlang, :abs)(-1)").

dynamic_var_erlang_call_test() ->
  {1, _} = elixir:eval("foo = :erlang\nbar = :abs\n.(foo, bar)(-1)").

dynamic_other_erlang_call_test() ->
  {1, _} = elixir:eval("foo = :erlang\n.(foo, Erlang.erlang_call_test.match())(-1)").