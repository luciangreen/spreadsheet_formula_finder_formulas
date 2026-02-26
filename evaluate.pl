% Define the operator predicates

% Base case: if the expression is a number, return the number as the result
evaluate([Number], Number,V1,V2) :-
    number1(Number),append(V1,[Number],V2),!.
evaluate(Number, Number,V1,V2) :-
    number(Number),append(V1,[Number],V2),!.

% Recursive case: if the expression is a list, evaluate its elements
evaluate([A,Op,B], Result,V1,V4) :-
	(number(A)->(AR=A,V1=V3);evaluate(A,AR,V1,V3)),
	(number(B)->(BR=B,V3=V4);evaluate(B,BR,V3,V4)),
	operators1(Ops1),%"+-/*^").
	string_strings(Ops1,Ops2),
    member(Op,Ops2), !,
    apply_operator([AR,Op,BR],Result),!.
    %evaluate([A,Op,B], %Accumulator, 
    %Result),
    %apply_operator(Term, Result),!.

% Define the predicate to apply an operator to the accumulator and the next number
apply_operator([A,"^",B], Result) :-
    Result is A^B.
apply_operator([A,"*",B], Result) :-
    Result is A*B.
apply_operator([A,"/",B], Result) :-
	B =\= 0,
    Result is A/B.
apply_operator([A,"+",B], Result) :-
    Result is A+B.
apply_operator([A,"-",B], Result) :-
    Result is A-B.

% Example usage:
% ?- evaluate([[1,"+",1,"+",["1",+,"1"],+"1"],+,"1"], Result).
% Result = 6.
