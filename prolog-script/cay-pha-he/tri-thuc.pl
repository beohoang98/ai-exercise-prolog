%Married
married('Queen Elizabeth II', 'Prince Phillip').
married('Prince Phillip', 'Queen Elizabeth II').

married('Prince Charles', 'Camilla Parker Bowles').
married('Camilla Parker Bowles', 'Prince Charles').

married('Princess Anne', 'Timothy Laurence').
married('Timothy Laurence', 'Princess Anne').

married('Sophie Rhys-jones', 'Prince Edward').
married('Prince Edward', 'Sophie Rhys-jones').

married('Prince William', 'Kate Middleton').
married('Kate Middleton', 'Prince William').

married('Autumn Kelly', 'Peter Phillips').
married('Peter Phillips', 'Autumn Kelly').

married('Zara Phillips', 'Mike Tindall').
married('Mike Tindall', 'Zara Phillips').

%Divorced
divorced('Princess Diana', 'Prince Charles').
divorced('Prince Charles', 'Princess Diana').

divorced('Captain Mark Phillips', 'Princess Anne').
divorced('Princess Anne', 'Captain Mark Phillips').

divorced('Sarah Ferguson', 'Prince Andrew').
divorced('Prince Andrew', 'Sarah Ferguson').

%Parent
parent('Queen Elizabeth II', 'Prince Charles').
parent('Queen Elizabeth II', 'Princess Anne').
parent('Queen Elizabeth II', 'Prince Andrew').
parent('Queen Elizabeth II', 'Prince Edward').
parent('Prince Phillip', 'Prince Charles').
parent('Prince Phillip', 'Princess Anne').
parent('Prince Phillip', 'Prince Andrew').
parent('Prince Phillip', 'Prince Edward').


parent('Princess Diana', 'Prince William').
parent('Princess Diana', 'Prince Harry').
parent('Prince Charles', 'Prince William').
parent('Prince Charles', 'Prince Harry').

parent('Captain Mark Phillips', 'Peter Phillips').
parent('Captain Mark Phillips', 'Zara Phillips').
parent('Princess Anne', 'Peter Phillips').
parent('Princess Anne', 'Zara Phillips').

parent('Sarah Ferguson', 'Princess Beatrice').
parent('Sarah Ferguson', 'Princess Beatrice').
parent('Prince Andrew', 'Princess Eugenie').
parent('Prince Andrew', 'Princess Eugenie').

parent('Sophie Rhys-jones', 'James Viscount Severn').
parent('Sophie Rhys-jones', 'Lady Louise Mountbatten-Windsor').
parent('Prince Edward', 'James Viscount Severn').
parent('Prince Edward', 'Lady Louise Mountbatten-Windsor').

parent('Prince William', 'Prince George').
parent('Prince William', 'Princess Charlotte').
parent('Kate Middleton', 'Prince George').
parent('Kate Middleton', 'Princess Charlotte').

parent('Autumn Kelly', 'Savannah Phillips').
parent('Autumn Kelly', 'Isla Phillips').
parent('Peter Phillips', 'Savannah Phillips').
parent('Peter Phillips', 'Isla Phillips').

parent('Zara Phillips', 'Mia Grace Tindall').
parent('Mike Tindall', 'Mia Grace Tindall').

%male
male('Prince Phillip').
male('Prince Charles').
male('Captain Mark Phillips').
male('Timothy Laurence').
male('Prince Andrew').
male('Prince Edward').
male('Prince William').
male('Prince Harry').
male('Peter Phillips').
male('Mike Tindall').
male('James Viscount Severn').
male('Prince George').

%female
female('Queen Elizabeth II').
female('Prince Diana').
female('Camilla Parker Bowles').
female('Princess Anne').
female('Sarah Ferguson').
female('Sophie Rhys-jones').
female('Kate Middleton').
female('Autumn Kelly').
female('Zara Phillips').
female('Princess Beatrice').
female('Princess Eugenie').
female('Lady Louise Mountbatten-Windsor').
female('Princess Charlotte').
female('Savannah Phillips').
female('Isla Phillips').
female('Mia Grace Tindall').


% ========== MOI QUAN HE =======
child(X, Y):- parent(Y, X).

son(X, Y)       :- parent(Y, X), male(X).
daughter(X, Y)  :- parent(Y, X), female(X).

mother(X, Y):- parent(X, Y), female(X).
father(X, Y):- parent(X, Y), male(X).

husband(X, Y)   :- male(X), female(Y), married(X, Y), not(divorced(X, Y)).
wife(X, Y)      :- female(X), male(Y), married(X, Y), not(divorced(X, Y)).

grandparent(X,Z) :- parent(X,Y), parent(Y, Z).

grandfather(X,Z) :- grandparent(X,Z),male(X).
grandmother(X,Z) :- grandparent(X,Z),female(X).

grandson(X,Z) :- grandchild(X,Z), male(X).
granddaughter(X,Z) :- grandchild(X,Z), female(X).

grandchild(X,Z) :- grandparent(Z,X).

sibling(X,Y) :- 
    mother(Z,X), mother(Z,Y),
    father(M,X), father(M,Y),
    X \= Y.

brother(X,Y) :- sibling(X,Y), male(X).
sister(X,Y) :- sibling(X,Y), female(X).

aunt(X,Y) :-parent(Z,Y),sibling(Z,X),female(X).
uncle(X,Y) :-parent(Z,Y),sibling(Z,X),male(X).

niece(X,Y) :-
    aunt(Y, X), female(X);
    uncle(Y, X), female(X).

nephew(X,Y) :-
    aunt(Y, X), male(X);
    uncle(Y, X), male(X).
