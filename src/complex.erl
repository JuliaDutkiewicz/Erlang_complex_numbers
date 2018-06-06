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
-export([make_number/2, conjugate/1, add/2, multiply/2, modulus/1, equals/2, arg_sin/1, arg_cos/1, arg/1]).

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

% Function that compares two complex nums and resolves if they are equal, based on "equality of their real and imaginary parts.
% ("Equality" means that one of them is not bigger than 0.1% of the smaller number)
equals(A, B) ->
  (abs(abs(A#complex.re) - abs(B#complex.re)) =<
    abs(0.001*(min(abs(A#complex.re), abs(B#complex.re)))))
    and ((abs(A#complex.im) - abs(B#complex.im)) =<
    abs(0.001*(min(abs(A#complex.im), abs(B#complex.im))))).

arg_sin(A) ->
  A#complex.re / conjugate(A).

arg_cos(A) ->
  A#complex.im / conjugate(A).

arg(A) ->
  math:asin(arg_sin(A)).