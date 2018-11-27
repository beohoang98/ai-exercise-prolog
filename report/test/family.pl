% family.pl

male('An').
male('Khang').
male('Dang').
female('Linh').
female('Chau').

parent('Linh', 'An').
parent('Khang', 'An').

friendOf('An', 'Dang').
friendOf('Chau', 'Dang').
friendOf('An', 'Chau').

friend(A, B):- friendOf(A, B); friendOf(B, A).
father(F, C):- parent(F, C), male(F).
mother(M, C):- parent(M, C), female(M).
