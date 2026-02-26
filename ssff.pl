:-include('../listprologinterpreter/listprolog.pl').
:-include('../Philosophy/replace1.pl').
:-include('../Philosophy/sub_term_with_address.pl').
:-include('ssff_solve.pl').
:-include('term_to_html.pl').
:-include('group_consecutive_items.pl').
:-include('find_sums_in_term.pl').
:-include('transpose.pl').
:-include('evaluate.pl').
:-include('../Philosophy/debug_tools.pl').
:-include('convert_tokens_to_nested_list.pl').
:-include('../Philosophy/pretty_print_table.pl').

split1(%[]%
List
,L16,%N,N,
 A,A) :- L2 is L16*2,length(List,L3),L3=<L2,
 !.
split1(Q2,L16,%N1,N2,
 L20,L17) :-
	%get_items_summing_to_l(Q2,L16,N1,N3,[],L2),
	length(L18,L16),
	append(L18,L19,Q2),
	append(L20,[L18],L21),
	split1(L19,L16,L21,L17),!.

split11([]%
%List
,_L16,%N,N,
 A,A) :- %L2 is L16*2,length(List,L3),L3=<L2,
 !.
split11(Q2,L16,%N1,N2,
 L20,L17) :-
	%get_items_summing_to_l(Q2,L16,N1,N3,[],L2),
	length(L18,L16),
	append(L18,L19,Q2),
	append(L20,[L18],L21),
	split11(L19,L16,L21,L17),!.

/*
get_items_summing_to_l(_Q2,_,N,N,L,L) :- !.
get_items_summing_to_l(Q2,L16,N1,N2,L1,L2) :-
	Q2=[S-N|Q4],
	(L16=N->
	(N3 is N1+L16,N->a,
		N3 is N1-N)).
*/
	
find_a_or_n(Q2,L111) :-
	%SepandPad="&#@~%`$?+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'",
	operators1(Ops),
	extra_characters(EC),
	string_concat(Ops,EC,SepandPad),
	% SepandPad="&#@~%`$?+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'",
	findall(L14,(member(L2,Q2),
	split_on_substring(L2,SepandPad,L3),
	foldr(string_concat,L3,S3),
	atom_chars(S3,A3),
	%atom_string(S31,S3),
	%string_concat(L4,_,S3),
	%string_length(L4,1),
	%atom_string(L5,L4),
	%L3=[L31|_],
(A3=''->L13=[(*)];findall(L12,(member(A,A3)%atom_concat(S34,_,A3),((atom_length(S34,1)->((
,((char_type(A,alpha)->L12=a;(char_type(A,digit),L12=n))->true;L12=(*))),L13),(member(n,L13)->L14=n;(member(a,L13)->L14=a;L14=(*))))),L11),
findall(X,(member(X1,L11),(X1=(*)->X=n;X=X1)),L111),!.
	%findall(L12,((member(L31,L3),atom_string(S33,L31),((S33='')->L12=(*); (atom_concat(S34,_,S33),((atom_length(S34,1)->(((char_type(S34,alpha)->L12=a;(char_type(S34,digit),L12=n))->true;L12=(*)));fail%L1=(*)
%	)))))),L13),maplist(=(_), L1)),L11),!.
	%forall(member(S32,L3),(atom_string(S33,S32),atom_concat(S34,_,S33),atom_length(S34,1),char_type(S34,alpha)))->L1=a;(char_type(S34,digit)->L1=n;L1=(*))))),L11),!.
	

get_variable_n(N) :-
	variable_n(N),
	N1 is N+1,
	retractall(variable_n(_)),
	assertz(variable_n(N1)),!.

get_in(N) :-
	in(N),
	N1 is N+1,
	retractall(in(_)),
	assertz(in(N1)),!.

word_break(A,B,Mode) :-
	string_codes(A,Codes),
	%SepandPad=%"",%
	%"&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!0123456789", % 	
	SepandPad1=%"",%
	"&#@~%`$?-+*^,()|:;=_/[]<>{}\n\r\s\t\\\"!0123456789", % doesn't have "'." xx
	(Mode=full_stops->string_concat(SepandPad1,".",SepandPad);
	SepandPad1=SepandPad),
	%string_codes(String1,Codes),
	%string_to_list2(SepandPad,[],SepandPad1),
	string_codes(SepandPad,SepandPad2),
	%split_string2(String1,SepandPad1,File_list),
	split_on_substring117(Codes,SepandPad2,[],B),!.
	

replace_word_numbers(Q,Q1) :-
	(string(Q)->replace_word_numbers1(Q,Q1);
	(sub_term_types_wa([string],Q,Instances),
	findall([Add,X],(member([Add,Q01],Instances),
	replace_word_numbers1(Q01,X)),Q11),
	foldr(put_sub_term_wa_ae,Q11,Q,Q1))),!.

replace_word_numbers1(Q,Q1) :-
	word_break(Q,Q00,not_full_stops),
	replace_loop(
	[
	["zero","0"],
	["one","1"],
	["two","2"],
	["three","3"],
	["four","4"],
	["five","5"],
	["six","6"],
	["seven","7"],
	["eight","8"],
	["nine","9"],
	["ten","10"],
	
	["jan.","January"],
	["feb.","February"],
	["mar.","March"],
	["apr.","April"],
	["may.","May"],
	["jun.","June"],
	["jul.","July"],
	["aug.","August"],
	["sep.","September"],
	["sept.","September"],
	["oct.","October"],
	["nov.","November"],
	["dec.","December"]
	%["no","number of "]
	],
	Q00,[],Q0),
	foldr(string_concat,Q0,Q1),!.

replace_loop(_,[],T,T) :- !.
replace_loop(Rs%[[R1,R2]|Rs]
,Q,T1,T2) :-
	Q=[Q3|Q4],
	((downcase_atom(Q3,Q31),
	atom_string(Q31,Q32),
	member([Q32,Q5],Rs),
	append(T1,[Q5],T3))->true;
	append(T1,[Q3],T3)),
	%replace1([entire_word],Q,R1,R2,Q3),
	replace_loop(Rs,Q4,T3,T2),!.


replace_loop1(T,T,[]) :- !.
replace_loop1(T1,T2,[[R1,R2]|Rs]
%,Q,T1
) :-
	%T1=[T11|T12],
	%/*
	%((%downcase_atom(Q3,Q31),
	%atom_string(Q31,Q32),
	%member([T11,Q5],Rs),
	%append(T2,[Q5],T4))->true;
	%append(T2,[T11],T4)),
	%*/
	replace2(T1,R1,R2,T3),
	replace_loop1(T3,T2,Rs),!.
