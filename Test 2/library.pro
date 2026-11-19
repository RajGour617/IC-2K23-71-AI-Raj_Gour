
/*
========================================================
INTELLIGENT LIBRARY RECOMMENDATION SYSTEM
GNU Prolog 1.5.0
========================================================
*/

% ======================================================
% 1. LIBRARY KNOWLEDGE BASE
% book(Name, Category, Subject, Difficulty).
% ======================================================

book(introduction_to_ai, technology, artificial_intelligence, intermediate).

book(machine_learning_fundamentals, technology, artificial_intelligence, intermediate).

book(python_basics, programming, python, beginner).

book(advanced_python_programming, programming, python, advanced).

book(data_structures_in_java, programming, java, intermediate).

book(deep_learning_essentials, technology, artificial_intelligence, advanced).

book(web_development_basics, programming, web_development, beginner).

book(database_management, technology, database, intermediate).

book(computer_networks, technology, networking, intermediate).

book(artificial_intelligence_with_python, technology, artificial_intelligence, advanced).

book(object_oriented_programming, programming, java, beginner).

book(data_science_fundamentals, technology, data_science, intermediate).


% ======================================================
% 2. INTERACTIVE INPUT
% ======================================================

read_value(Message, Value) :-
	write(Message),
	read(Value),
	nl.

read_three(Message, [A, B, C]) :-
	read_value(Message, A),
	read_value(Message, B),
	read_value(Message, C).

read_student(Interests, Subjects, Level, ReadBooks) :-
	nl,
	write('======================================'),
	nl,
	write(' INTELLIGENT LIBRARY SYSTEM'),
	nl,
	write('======================================'),
	nl,
	nl,
	write('ENTER YOUR THREE INTERESTS'),
	nl,
	read_three('First interest: ', Interests),
	nl,
	write('ENTER YOUR THREE PREFERRED SUBJECTS'),
	nl,
	read_three('First preferred subject: ', Subjects),
	nl,
	write('ENTER YOUR READING LEVEL'),
	nl,
	read_value('Reading level (beginner/intermediate/advanced): ', Level),
	nl,
	write('ENTER BOOKS ALREADY READ'),
	nl,
	write('(Enter none if you have not read a book)'),
	nl,
	read_three('First book: ', [R1, R2, R3]),
	normalize_read(R1, L1),
	normalize_read(R2, L2),
	normalize_read(R3, L3),
	append(L1, L2, Temp),
	append(Temp, L3, ReadBooks).


% ======================================================
% 3. NORMALIZE READING HISTORY
% ======================================================

normalize_read(none, []) :-
	!.

normalize_read(Book, [Book]).


% ======================================================
% 4. INTEREST MATCHING
% ======================================================

interest_match(Category, Subject, Interests) :-
	(member(Category, Interests);
member(Subject, Interests)).


% ======================================================
% 5. SUBJECT MATCHING
% ======================================================

subject_match(Subject, Subjects) :-
	member(Subject, Subjects).


% ======================================================
% 6. BOOK ELIGIBILITY
% ======================================================

eligible(Category, Subject, Interests, Subjects) :-
	( interest_match(Category, Subject, Interests);
subject_match(Subject, Subjects)).


% ======================================================
% 7. EXCLUDE ALREADY READ BOOKS
% ======================================================

unread(Book, ReadBooks) :-
	\+ member(Book, ReadBooks).


% ======================================================
% 8. PRIORITY SCORING
% ======================================================

calculate_score(Category, Subject, Difficulty, Interests, Subjects, Level, Score) :-
		interest_points(Category, Subject, Interests, IP),
	subject_points(Subject, Subjects, SP),
	level_points(Difficulty, Level, LP),
	Score is IP + SP + LP.


interest_points(Category, Subject, Interests, 3) :-
		interest_match(Category, Subject, Interests),
	!.

interest_points(_, _, _, 0).


subject_points(Subject, Subjects, 3) :-
	subject_match(Subject, Subjects),
	!.

subject_points(_, _, 0).


level_points(Level, Level, 2) :-
	!.

level_points(_, _, 0).


% ======================================================
% 9. FIND EXACT LEVEL RECOMMENDATIONS
% ======================================================

find_exact(Interests, Subjects, Level, ReadBooks, Candidates) :-
	findall(NegScore - book(B, C, S, L),
		(book(B, C, S, L),
			unread(B, ReadBooks),
			L = Level,
			eligible(C, S, Interests, Subjects),
			calculate_score(C, S, L, Interests, Subjects, Level, Score),
			NegScore is  - Score),
		RawCandidates),
		remove_duplicate_books(RawCandidates, [], UniqueCandidates),
	keysort(UniqueCandidates, Candidates).

% ======================================================
% 10. FIND ALTERNATIVE LEVEL RECOMMENDATIONS
% ======================================================

find_alternative(Interests, Subjects, Level, ReadBooks, Candidates) :-
	findall(NegScore - book(B, C, S, L),
		(book(B, C, S, L),
			unread(B, ReadBooks),
			eligible(C, S, Interests, Subjects),
			calculate_score(C, S, L, Interests, Subjects, Level, Score),
			NegScore is  - Score),
		RawCandidates),
		remove_duplicate_books(RawCandidates, [], UniqueCandidates),
	keysort(UniqueCandidates, Candidates).


% ======================================================
% 11. RECOMMENDATION ENGINE
% ======================================================

main :-
	read_student(Interests, Subjects, Level, ReadBooks),
	nl,
	write('ALREADY READ BOOKS: '),
	write(ReadBooks),
	nl,
	find_exact(Interests, Subjects, Level, ReadBooks, Exact),
	(Exact \= [] ->
	Selected = Exact,
		Mode = exact;
	write('No exact-level matches found.'),
		nl,
		write('Searching alternative difficulty levels...'),
		nl,
		find_alternative(Interests, Subjects, Level, ReadBooks, Selected),
		Mode = alternative),
	nl,
	write('======================================'),
	nl,
	write('     LIBRARY RECOMMENDATIONS'),
	nl,
	write('======================================'),
	nl,
	(Selected = [] ->
	write('No suitable books found.'),
		nl;
	keysort(Selected, Sorted),
		write('Top recommended books:'),
		nl,
		nl,
		print_top_three(Sorted, Mode, Interests, Subjects, Level, 0)),
	nl,
	write('======================================'),
	nl,
	write('Recommendation process completed.'),
	nl.


% ======================================================
% 12. DISPLAY MAXIMUM THREE RECOMMENDATIONS
% ======================================================

print_top_three(_, _, _, _, _, N) :-
	N >= 3,
	!.


print_top_three([], _, _, _, _, _) :-
	!.


print_top_three([NegScore-book(B, C, S, L)|Rest], Mode, Interests, Subjects, Level, N) :-
	Score is  - NegScore,
	N1 is N + 1,
	write(N1),
	write('. '),
	write(B),
	nl,
	write('   Score: '),
	write(Score),
	nl,
	show_reason(C, S, L, Interests, Subjects, Level, Mode),
	nl,
	print_top_three(Rest, Mode, Interests, Subjects, Level, N1).


% ======================================================
% 13. EXPLAIN EACH RECOMMENDATION
% ======================================================

show_reason(Category, Subject, Difficulty, Interests, Subjects, Level, Mode) :-
	write('   Category: '),
	write(Category),
	nl,
	write('   Subject: '),
	write(Subject),
	nl,
	write('   Difficulty: '),
	write(Difficulty),
	nl,
	write('   Reason: '),
	( interest_match(Category, Subject, Interests),
		subject_match(Subject, Subjects) ->
	write('Matches your interest and preferred subject'); interest_match(Category, Subject, Interests) ->
	write('Matches your interest');
	subject_match(Subject, Subjects) ->
	write('Matches your preferred subject')),
	show_level_reason(Difficulty, Level, Mode).


show_level_reason(Difficulty, Level, Mode) :-
	(Difficulty = Level ->
	write(' and reading level');
	Mode = alternative ->
	write(' (alternative reading level)')).


remove_duplicate_books([], _, []).

remove_duplicate_books([Score-Book|Rest], Seen, Result) :-
	member(Book, Seen),
	!,
		remove_duplicate_books(Rest, Seen, Result).

remove_duplicate_books([Score-Book|Rest], Seen, [Score-Book|Result]) :-
		remove_duplicate_books(Rest, [Book|Seen], Result).