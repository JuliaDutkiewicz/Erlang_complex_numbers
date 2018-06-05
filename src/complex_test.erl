%%%-------------------------------------------------------------------
%%% @author Julia
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. cze 2018 15:09
%%%-------------------------------------------------------------------
-module(complex_test).
-author("Julia").
-include_lib("eqc/include/eqc.hrl").

%% API
-export([prop_square/0, prop_add/0]).

%(mod(z))^2 = z* con(z)
prop_square() ->
  ?FORALL({R,I},{int(),int()},
    complex:multiply(complex:make_number(R,I), complex:conjugate(complex:make_number(R,I))) == complex:make_number(R*R+I*I,0)).

prop_add() ->
  ?FORALL({R,I},{int(),int()},
    complex:add(complex:make_number(R, I), complex:conjugate(complex:make_number(R,I))) == complex:make_number(2*R, 0)).



