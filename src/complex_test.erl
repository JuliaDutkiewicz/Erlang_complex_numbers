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
-export([prop_square/0, prop_add/0, prop_sub/0, prop_multiply_args/0, prop_square_wrong/0, prop_square_fixed/0, prop_radius/0]).

%(mod(z))^2 = z* con(z)
% Checks if  z * con(z) = Re(z)^2 + Im(z)^2
prop_square() ->
  ?FORALL({R,I},{int(),int()},
    complex:multiply(complex:make_number(R,I), complex:conjugate(complex:make_number(R,I))) == complex:make_number(R*R+I*I,0)).

% Checks if (mod(z))^2 = z* con(z) using basic equality. May not always work because sqrt(x)^2 is not always x in the float arith!
prop_square_wrong() ->
  ?FORALL({R,I},{int(),int()},
    complex:multiply(complex:make_number(R,I), complex:conjugate(complex:make_number(R,I))) == complex:make_number(complex:modulus(complex:make_number(R,I)) * complex:modulus(complex:make_number(R,I)),0)).

% Checks if (mod(z))^2 = z* con(z) using approximated equality, defined in "complex" module.
prop_square_fixed() ->
  ?FORALL({R,I},{int(),int()},
    complex:equals(
      complex:multiply(complex:make_number(R,I), complex:conjugate(complex:make_number(R,I))),
      complex:make_number(complex:modulus(complex:make_number(R,I)) * complex:modulus(complex:make_number(R,I)),0)
  )).


% z + con(z) = 2 Re(z)
prop_add() ->
  ?FORALL({R,I},{int(),int()},
    complex:add(complex:make_number(R, I), complex:conjugate(complex:make_number(R,I))) == complex:make_number(2*R, 0)).

% z + con(z) = 2i Im(z)
prop_sub() ->
  ?FORALL({R,I},{int(),int()},
    complex:add(complex:make_number(R, I), complex:conjugate(complex:make_number(-R,-I))) == complex:make_number(0, 2*I)).

prop_multiply_args() ->
  ?FORALL({A,B,C,D},{int(),int(),int(),int()},
    complex:arg(complex:multiply(complex:make_number(A,B), complex:make_number(C,D))) == complex:arg(complex:make_number(A,B)) + complex:arg(complex:make_number(C,D))).


%z = r(sin(N) * i*cos(N))
%r = |z|
prop_radius() ->
  ?FORALL({N,R},{int(), int()},
    abs(complex:modulus(complex:make_number(abs(R)*math:sin(N),abs(R) * math:cos(N))) - abs(R))
      =<
      0.001 * min(abs(R), complex:make_number(abs(R)*math:sin(N),abs(R) * math:cos(N)))).
