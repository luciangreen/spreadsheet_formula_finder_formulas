:-include('../Philosophy/expand_topic.pl').
:-include('term_to_html.pl').

question(Rest1,Question,Question_table) :-
	%reverse(Rest1,Rest2),
	findall_until_fail(A,member(A,Rest1),
	(trim_spaces_before(A,A1),
	SepandPad="&#@~%`$?+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
	split_string1b(A1,SepandPad,SepandPad,B1),
	not(((search(B1,["prepare","calculate"]))->true;
	(append([C],_,B1),
	string_strings("abcdefghijklmnopqrstuvwxyz",Alpha),
	member(C,Alpha))))),Question_table),
	(Question_table=[]->(writeln("Can't find question."),abort);true),
	%find_until(Rest1,D11)
	%trace,
	%reverse(D1,Question_table),
	%subtract(Rest1,D1,D2),
	%trace,
	%(D31=[D3|_]->
	%find_until(Rest1,D3,Question_table);Question_table=D1),
	append(Question_table,Question,Rest1),!.

% search_for_term_n("a b c",["a","b"],C).
% C = ["a", "b"].

search_for_term_n(Cell,Terms,Result) :-
	findall(What_is_found,(%[Where_searching,What_is_found],
member(What_is_found,Terms),search(Cell,What_is_found)),Result),!.

% find_first_term_n("a b c",["a","b"],C).
% C = "a".

find_first_term_n(A,Terms,What_is_found) :-
	find_first((%[Where_searching,What_is_found],
member(What_is_found,Terms),search(A,What_is_found))),!.

% search("a b","a").
% true

search(A,Terms) :-
	(is_list(A)->term_to_atom(A,A0);A=A0),
	(is_list(Terms)->Terms1=Terms;Terms1=[Terms]),
	downcase_atom(A0,A2),
		SepandPad="&#@~%`$?+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'",
	split_string1b(A2,SepandPad,SepandPad,B),
	findall(A3,(member(A3,Terms1),downcase_atom(A3,Terms12),	split_string1b(Terms12,SepandPad,SepandPad,Terms13)),A4),flatten(A4,A5),
	not(intersection(B,A5,[])),!.


% search_for_n_words_in_common("a b c", ["a", "b"], 2).
% N = 2.

search_for_n_words_in_common(A,Terms,N) :-
	(is_list(A)->term_to_atom(A,A0);A=A0),
	downcase_atom(A0,A2),
	(is_list(Terms)->term_to_atom(Terms,Terms1);Terms=Terms1),
	downcase_atom(Terms1,Terms2),
		SepandPad="&#@~%`$?+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'",
	split_string(A2,SepandPad,SepandPad,B1),
	split_string(Terms2,SepandPad,SepandPad,B2),
	%findall(A3,(member(A3,B2),%downcase_atom(A3,Terms12),
		%split_string(A3,SepandPad,SepandPad,Terms13)),A4),flatten(A4,A5),
		
	intersection(B1,B2,In),
	length(In,N),!.

% search_for_n_words_in_common_succ("a","cb",A).
% false

% search_for_n_words_in_common_succ("a b c d e", "b c d e f",A).
% A = 4

% search_for_n_words_in_common_succ("January", "February",A)
% true

% trace,                                                              search_for_n_words_in_common_succ("January", "March",A).
% false

% search_for_n_words_in_common_succ("a", "b", A).
% true

% search_for_n_words_in_common_succ("a", "c",A).
% true

% search_for_n_words_in_common_succ("2000", "2001",A).
% true

% search_for_n_words_in_common_succ("2000", "2002",A).
% false

months(["January","February","March","April","May","June","July","August","September","September","October","November","December"]).

search_for_n_words_in_common_succ(A,B, N) :-
	clean_input(A,A0),
	clean_input(B,B0),
	
	% Month wo sepandpad or like search_for_n_words_in_common, A,B, year
	((search_for_n_words_in_common(A,B,N),once(not(N=0)))->
	true;
	((months(Months1),
	findall(X2,(member(X1,Months1),downcase_atom(X1,X),
	%trace,
	atom_string(X,X2)),Months),
	next_item(A0,B0,Months))->true;
	((%trace,
	string_length(A0,1),string_length(B0,1),
	string_codes(A0,[A0C]),
	string_codes(B0,[B0C]),
	B0C is A0C+1)->true;
	((find_first_number(A0,N1),
	find_first_number(B0,N2),
	N2 is N1+1))))),!.

/*
succ1("January",A),succ1("A",B),succ1("14",C).
A = "February",
B = "B",
C = 15.
*/

succ1(A,B) :-
	clean_input(A,A0),
	%clean_input(B,B0),
	% Month wo sepandpad or like search_for_n_words_in_common, A,B, year
	% january $, Product Tiger, AB , project f g
	((find_first_number(A0,N1),
	%find_first_number(B0,N2),
	B is N1+1)->true;
	
	((%clean_input(A,A0),
	%clean_input(B,B0),
	(months(Months1),
	findall(X2,(member(X1,Months1),
	downcase_atom(X1,X),
	%trace,
	atom_string(X,X2)),Months),
	next_item(A0,B0,Months),
	upper_first(B0,B)
	)->true;
	
	((string_concat(_,A3,A),
	string_length(A3,1),
	%string_length(B0,1),
	string_codes(A3,[A3C]),
	B3C is A3C+1,
	string_codes(B,[B3C])))))),!.

upper_first(A,B) :-
	string_concat(C,E,A),
	string_length(C,1),
	upcase_atom(C,D),
	string_concat(D,E,B),!.
	
% next_item(a,N,[c,a,b,d]).
% N = b
	
next_item(A,B,L) :-
	append(_,C,L),
	append([A],[B|_],C),!.
	
clean_input(A,B0) :-
	(is_list(A)->term_to_atom(A,A0);A=A0),
	%term_to_atom(A0,A1),
	A0=A1,
	downcase_atom(A1,A2),
	SepandPad="&#@~%`$?+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'",
	split_string1b(A2,SepandPad,SepandPad,B1),
	findall([B2," "],member(B2,B1),B3),
	flatten(B3,B4),
	append(B5,[_],B4),
	foldr(string_concat,B5,B0),!.

% search_whole_string("abcd","BC").
% true.

% search_whole_string("abcd","BA").
% false.

search_whole_string(A,Term) :-
	downcase_atom(A,A2),
	downcase_atom(Term,Term2),
	sub_string(A2,_,_,_,Term2),!.

find(A,Terms,B) :-
	findall(T,(member(T,Terms),search(A,[T])),B),
	!.

% find_between("abc","a","c",F),find_between("bc","","c",G),find_between("cde","d","",H).
% F = G, G = ["b"],
% H = ["e"].

find_between(A,Before,After,B) :-
	(is_list(A)->(flatten(A,A1),findall([A2," "],member(A2,A1),A3),foldr(string_concat,A3,A0));A=A0),
	string_strings(A0,AL),
	string_strings(Before,Before_L),
	string_strings(After,After_L),
	((Before_L=[],After_L=[],
	B=A0)->true;
	
	((Before_L=[],
	reverse(AL,A01),
	reverse(After_L,After_L1),
	append(_A4,B4,A01),
	append(After_L1,C4,B4),
	reverse(C4,B))->true;
	
	((After_L=[],
	append(_A4,B4,AL),
	append(Before_L,B,B4))->true;
	
	((append(_A4,B4,AL),
	append(Before_L,C,B4),
	append(B,E,C),
	append(After_L,_F,E)))))),!.

% find_between_possibilities("aca b b", ["a", "c"], ["b"], C).
% C = "a ".
	
find_between_possibilities(A,Before1,After1,B) :-
	findall([L,B1],(member(Before,Before1),
	member(After,After1),
	find_between(A,Before,After,B1),
	length(B1,L)),B2),
	sort(B2,B3), % shortest poss, reverse for longest
	B3=[[_,B1]|_],
	foldr(string_concat,B1,B),!.
	
/*
                                                              answer_number("14. abc",A),answer_number("a. 123",B).
A = "14.",
B = "a.".
*/
	
answer_number(Question1,AN) :-
	trim_spaces_before(Question1,A1),
	SepandPad="&#@~%`$?+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'",
	split_on_substring117a(A1,SepandPad,B1),
	((append(C,E,B1),
	append([D],_%["."|_]
	,E)->
	%string_strings("abcdefghijklmnopqrstuvwxyz",Alpha),
	%string_strings("0123456789",Nums),
	%member(C,Alpha)->
	string_concat(D,".",AN))->true;
	AN=""),!.
	%(member(C,Nums)),!.

/*
find_number([[var,_,_,_,_,1,_,_,_,_,_]],A).
A = 1.

find_number([var,_,_,_,_,1,_,_,_,_,_],A).
A = 1.
*/
	
find_number(A,N) :-
	(sub_term_wa([var,_,_,_,_,_,_,_,_,_,_], A, B)->B=[[_, [var,_,_,_,_,N,_,_,_,_,_]]|_];A=N),%->true;
	%find_first(B,(member(B,A),number(B)),N)),
	%C=[N|_],
	!.

% number1(1,A),number1([var,_,_,_,_,1,_,_,_,_,_],B),number1("1",C).
% A = B, B = C, C = 1.
	
number1(XY1,XY12) :-
(number(XY1)->XY12=XY1;	((XY1=[var,_,_,_,_,XY11,_,_,_,_,_],number(XY11))->XY12=XY11;catch(number_string(XY12,XY1),_,false)))%->true;(number(XY1),XY1=XY11))
	,!.

number1(XY1) :- 
	(number1(XY1,_)->true;number(XY1)),!.

% find_first_number([[v,"1"],2],A).
% A = 1.

% find_first_number([[v,3,"1"],2],A).
% A = 3.
	
find_first_number(S,N) :-

	(is_list(S)->term_to_atom(S,A0);S=A0),
	downcase_atom(A0,A2),
		SepandPad="&#@~%`$?+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'",
	split_string1b(A2,SepandPad,SepandPad,B),
	findall([B2," "],member(B2,B),B3),
	flatten(B3,B4),
	append(B5,[_],B4),
	
	find_first((member(N1,B5),catch(number_string(N,N1),_,false)->true;false)),!.
