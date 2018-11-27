% congty-test.pl

:- unload_file('congty').
:- consult('congty').

:- open('test-output.txt', write, Stream), set_output(Stream).

%Test:
%01.Ai la tong giam doc cua Kagat
:-
	write('01: '),
	companyPresident(X,'Kagat'),
	writeln(X).
%02.Ai la truong phong phong IT project manager:
:-
	write('02: '),
	managerDepartment(X, 'IT Project Manager'),
	writeln(X).
%03.Liet nhung nguoi thuoc phong IT Technologies
:-
	write('03: '),
	forall(
		memberDepartment(X,'IT Technologies'),
		writef('%w ,',[X])
	),
	writeln(' ').
	
%04.Liet nhung nguoi thuoc phong IT Project Manager
:-
	write('04: '),
	forall(
		memberDepartment(X,'IT Project Manager'),
		writef('%w ,',[X])
	),
	writeln(' ').
%05.Liet nhung nguoi thuoc phong Marketing
:-
	write('04: '),
	forall(
		memberDepartment(X,'Marketing'),
		writef('%w ,',[X])
	),
	writeln(' ').
%06.Ai la truong phong phong Marketing:
:-
	write('06: '),
	managerDepartment(X,'IT Marketing'),
	writeln(X).
%07.William co phai la truong phong marketing:
:-
	write('07: '),
	(managerDepartment('William','Marketing')
		->writeln(true);
		  writeln(false)
	).
%08.Cac cong ty hop tac voi Kagat;
:-
	write('08: '),
	forall(
		cooperation(X,'Kagat'),
		writef('%w ,',[X])
	),
	writeln(' ').
%09.Cong ty Mining va cong ty Vining co hop tac khong:
:-
	write('09: '),
	(cooperation('Mining','Vining')
		->writeln(true);
		  writeln(false)
	).
%10.Ai la pho tong cua cong ty Kagat:
:-
	write('10: '),
	companyVicePresident(X,'Kagat'),
	writeln(X).
%11.Liet ke tat ca nhan vien cua cong ty Kagat:
:-
	write('11: '),
	forall(
		companyMember(X,'Kagat'),
		writef('%w ,',[X])
	),
	writeln(' ').
%12.Liet ke tat ca phong ban cua cong ty Kagat
:-
	write('11: '),
	forall(
		departmentCompany(X,'Kagat'),
		writef('%w ,',[X])
	),
	writeln(' ').
%13.Jean co thuoc phong IT project manager:
:-
	write('13: '),
	(cooperation('Jean','IT Project Manager')
		->writeln(true);
		  writeln(false)
	).
%13.Chloe co thuoc phong IT project manager:
:-	
	write('13: '),
	(cooperation('Chloe','IT Project Manager')
		->writeln(true);
		  writeln(false)
	).
%14.Chloe co phai leader cua William:
:-
	write('14: '),
	(managerToEmployees('Chloe','William')
		->writeln(true);
		  writeln(false)
	).
%15.William co phai leader cua Chloe:
:-
	write('15: '),
	(managerToEmployees('William','Chloe')
		->writeln(true);
		  writeln(false)
	).
%16.Adam co phai la sep cua John:
:-
	write('16: '),
	(presidentToManager('Adam','John')
		->writeln(true);
		  writeln(false)
	).
%17.David co phai la sep cua Adam:
:-
	write('17: '),
	(vicePresidentToManager('Adam','John')
		->writeln(true);
		  writeln(false)
	).
%18.Nhung nguoi thuoc phong cua Arica:
:-
	write('18: '),
	forall(
		managerToEmployees('Arica',X),
		writef('%w ,',[X])
	),
	writeln(' ').
%19.Adam co thuoc phong Marketing khong:
:-
	write('19: '),
	(memberDepartment('Adam','Marketing')
		->writeln(true);
		  writeln(false)
	).
%20.

:- halt.