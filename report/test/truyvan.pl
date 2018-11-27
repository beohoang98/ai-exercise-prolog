% truyvan.pl
% BAT DAU SCRIPT
:- consult('family'). % load tri thức từ file family.pl

% nếu không có syntax :-, đoạn script sẽ xem như tri thức và không chạy
:-
    writeln('Ban cua An la ai?'),
    forall( % ham ho tro liet ke tat ca ket qua
        friend(X, 'An'),
        writeln(X)
    ).

:- halt.
% Nếu không có halt, chương trình SWI-Prolog sẽ chưa được thoát và trở lại giao diện tương tác.
