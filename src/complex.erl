%%%-------------------------------------------------------------------
%%% @author Julia
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. cze 2018 14:35
%%%-------------------------------------------------------------------
-module(complex).
-author("Julia").

%% API
-export([make_number/2, conjugate/1, add/2, multiply/2, modulus/1]).

-record(complex, {re,im}).

make_number(Re, Im) ->
  #complex{re = Re, im = Im}.

conjugate(Num) ->
  #complex{re = Num#complex.re, im = - Num#complex.im }.

add(A, B) ->
  #complex{re = A#complex.re + B#complex.re, im = A#complex.im + B#complex.im}.

multiply(A, B) ->
  #complex{re = (A#complex.re * B#complex.re - A#complex.im * B#complex.im), im = (A#complex.im * B#complex.re + A#complex.re * B#complex.im) }.


modulus(A) ->
  math:sqrt(A#complex.re * A#complex.re + A#complex.im * A#complex.im).