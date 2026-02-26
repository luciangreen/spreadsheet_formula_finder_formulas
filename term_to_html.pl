% answers have a, b at start

/*

term_to_html([[[[[function,_,_,[[var,T1,R1,C1,IN1,1|_]],[[var,T1,R1,C1,IN1,1|_]]]]]]],A),writeln(A).

<html><head><style>
td.single_underline {
    border-bottom: 1px solid #333;
    padding: 1px 0;
}
td.double_underline {
    border-bottom: 4px double #333;
    padding: 4px 0;
}
</style></head><body><table><tr><td>1</td>
</tr>
</table>

</body></html>


term_to_html([[[["a",[function,_,_,[[var,T1,R1,C1,IN1,1,VN1,TP1,RP1,CP1,INP1],"+",[var,T1,R1,C1,IN1,1,VN1,TP1,RP1,CP1,INP1]],[[var,T1,R1,C1,IN1,1,VN1,TP1,RP1,CP1,INP1],"+",[var,T1,R1,C1,IN1,1,VN1,TP1,RP1,CP1,INP1]]]],[[calculate,[[function,_,_,[[var,T1,R1,C1,IN1,1,VN1,TP1,RP1,CP1,INP1],"+",[var,T1,R1,C1,IN1,1,VN1,TP1,RP1,CP1,INP1]],[[var,T1,R1,C1,IN1,1,VN1,TP1,RP1,CP1,INP1],"+",[var,T1,R1,C1,IN1,1,VN1,TP1,RP1,CP1,INP1]]]]]]]]],A),writeln(A).

<html><head><style>
td.single_underline {
    border-bottom: 1px solid #333;
    padding: 1px 0;
}
td.double_underline {
    border-bottom: 4px double #333;
    padding: 4px 0;
}
</style></head><body><table><tr><td>1+1</td>
</tr>
</table>

</body></html>

*/

term_to_html(Answers,HTML) :-
	findall([A8,"\n"],(member(A81,Answers),
	findall(["<table>",A6,"</table>\n"],
	(member(A5,A81),

	((findall(["<tr>",A4,"</tr>\n"],
	(member(A2,A5),
	findall([A31,"</td>\n"],
	(member(A3,A2),
	td_underline(A3,A31)),
	A4),not(A4=[])),A6),not(A6=[]))->true;
	
	((%member(A2,A5),
	findall([A31,"</td>\n"],
	(member(A3,A5),
	td_underline(A3,A31)),
	A51),not(A51=[]),
	A6=["<tr>",A51,"</tr>\n"])->true;
	
	(td_underline(A5,A51),
	A6=["<tr>",A51,"</td></tr>\n"]
	))))
	
	,A8)),A61),
flatten(["<html><head><style>","\n",
"td.single_underline {","\n","    border-bottom: 1px solid #333;","\n","    padding: 1px 0;","\n","}","\n",
"td.double_underline {","\n","    border-bottom: 4px double #333;","\n","    padding: 4px 0;","\n","}","\n","</style></head><body>",A61,"</body></html>"],A7),
	foldr(string_concat,A7,HTML),!.

% single values and rows

td_underline(String10,H) :-
	get_formula_value(String10,String1),
	atomic_list_concat(S2,'\n',String1),
	atomic_list_concat(S2,'<br>',String),
	((search_and_replace(String,"<single underline>","",R),
	string_concat("<td class=\"single_underline\">",R,H))->true;

	((search_and_replace(String,"<double underline>","",R),
	string_concat("<td class=\"double_underline\">",R,H))->true;
	
	(string_concat("<td>",String,H)))),!.

get_formula_value(String10,String1) :-
	(String10=[calculate,[function,_,_,_,String1,_]]->true;
	(String10=[function,_,_,_,Term,_]->
	(
	%trace,
sub_term_wa([var|_],Term,Instances1),
findall([Add,V],(member([Add,X1],Instances1),
X1=[var, _, _, _, _, V|_]),Instances1b),
foldr(put_sub_term_wa_ae,Instances1b,Term,Term2),
	flatten(Term2,Term1),foldr(string_concat,Term1,String1)->true;
	String10=String1))),!.
	
	%sub_term_wa([var|_],A,Instances1),
	%(number1(String10,String1)->true;String10=String1),


search_and_replace(String1,Search_string_or_list,Replacement,Result_string) :-
	search_whole_string(String1,Search_string_or_list),
	(is_list(Search_string_or_list)->
	Search_string_or_list1=Search_string_or_list;
	Search_string_or_list1=[Search_string_or_list]),
	foldr(replace1_fr([[],Replacement]),Search_string_or_list1,String1,Result_string).

replace1_fr([Options,Replacement],Search_string_or_list,String1,Result_string) :-
	replace1(Options,String1,Search_string_or_list,Replacement,Result_string).
