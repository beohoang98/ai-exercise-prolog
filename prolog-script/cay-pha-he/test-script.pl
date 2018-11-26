:- unload_file('tri-thuc').
:- consult('tri-thuc').

:- open('test-output.txt', write, Stream), set_output(Stream).

% 01. Ai là mẹ của Prince Andrew? (mother)
:-
    write('01: '),
    mother(X, 'Prince Andrew'), 
    writeln(X).

% 02. Ai là vợ của Prince Charles? (wife)
:- 
    write('02: '),
    wife(X, 'Prince Charles'),
    writeln(X).

% 03. Camilla có phải là mẹ của Prince William không? (mother)
:-
    write('03: '),
    (mother('Camilla Parker Bowles', 'Prince William')
    ->  writeln(true);
        writeln(false)
    ).

% 04. Princess Diana có phải vợ của Prince Edward không? (wife)
:-
    write('04: '),
    (wife('Princess Diana', 'Prince Edward')
    ->  writeln(true);
        writeln(false)
    ).

% 05. Liệt kê cháu gái của Queen Elizabeth II? (granddaughter)
:-
    write('05: '),
    forall(
        granddaughter(X, 'Queen Elizabeth II'),
        writef('%w, ', [X])
    ),
    writeln('').

% 06. Liệt kê con trai của Prince Phillip? (son)
:-
    write('06: '),
    forall(
        son(X, 'Prince Phillip'),
        writef('%w, ', [X])
    ),
    writeln('').

% 07. Prince William có là anh em của Prince Harry không? (sibling)
:-
    write('07: '),
    (sibling('Prince William', 'Prince Harry')
    ->  writeln(true);
        writeln(false)
    ).

% 08. Prince Andrew có phải là cậu/bác của Peter Phillips? (uncle)
:-
    write('08: '),
    (uncle('Prince Andrew', 'Peter Phillips')
    ->  writeln(true);
        writeln(false)
    ).

% 09. Kate Middleton có phải là Dì của Isla Phillips? (aunt)
:-
    write('09: '),
    (aunt('Kate Middleton', 'Isla Phillips')
    ->  writeln(true);
        writeln(false)
    ).

% 10. Sarah Ferguson có đang là vợ của Prince Andrew? (wife)
:-
    write('10: '),
    (wife('Sarah Ferguson', 'Prince Andrew')
    ->  writeln(true);
        writeln(false)
    ).

% 11. Captain Mark Phillips có những đứa cháu là ai? (grandchild)
:-
    write('11: '),
    forall(
        grandchild(X, 'Captain Mark Phillips'),
        writef('%w, ', [X])
    ),
    writeln('').

% 12. Ai là ông nội của Savannah Phillips? (grandfather)
:-
    write('12: '),
    grandfather(X, 'Savannah Phillips'),
    writeln(X).

% 13. Cha của James Viscount Severn là ai? (father)
:-
    write('13: '),
    father(X, 'James Viscount Severn'),
    writeln(X).

% 14. Em gái/chị của Peter Phillips là ai? (sister)
:-
    write('14: '),
    forall(
        sister(X, 'Peter Phillips'),
        writef('%w, ', [X])
    ),
    writeln('').

% 15. Anh/em trai của Prince Andrew là ai? (brother)
:-
    write('15: '),
    forall(
        brother(X, 'Prince Andrew'),
        writef('%w, ', [X])
    ),
    writeln('').

% 16. Ông/bà của Princess Charlotee gồm những ai? (grandparent)
:-
    write('16: '),
    forall(
        grandparent(X, 'Princess Charlotte'),
        writef('%w, ', [X])
    ),
    writeln('').

% 17. Mia Grace Tindall có phải là con trai? (male)
:-
    write('17: '),
    (male('Mia Grace Tindall')
    ->  writeln(true);
        writeln(false)
    ).

% 18. Vợ hiện tại Prince Andrew là ai? (wife)
:-
    write('18: '),
    forall(
        wife(X, 'Prince Andrew'),
        writef('%w, ', [X])
    ),
    writeln('').

% 19. Ai chưa có gia đình? (not married)
:-
    write('19: '),
    forall(
        (
            (male(X);female(X)),
            not(married(X, _)),
            not(divorced(X, _))
        ),
        writef('%w, ', [X])
    ),
    writeln('').

% 20. Bà mẹ nào có đúng 2 con? (female, children).
:-
    write('20: '),
    forall(
        (
            female(X),
            aggregate_all(count, mother(X, _), Count),
            Count = 2
        ),
        writef('%w, ', [X])
    ),
    writeln('').

:- halt.