%gender member:
male('Alex').
male('David').

male('John').
male('Mason').
male('Buck').
male('Caulder').
male('Burn').
male('Kane').
male('Mark').

male('William').
male('Todd').
male('Billy').
male('Jacob').
male('James').
male('Daniel').
male('Adam').
male('Riley').
male('Henry').
male('Max').
male('Edward').

female('Jean').
female('Jenny').
female('Grace').
female('Arica').
female('Chloe').
female('Victoria').
female('Camila').
female('Layla').
female('Mia').
female('Sofia').
female('Avery').
female('Amelia').

%company
company('Kagat').
company('Mining').
company('Vining').

%department
department('IT Technologies').
department('IT Project manager').
department('Marketing').

% CEO
president('Alex').
vicePresident('David').

% manager
manager('John').
manager('William').
manager('Arica').

% members:
member('John','IT Technologies').
member('Mason','IT Technologies').
member('Buck','IT Technologies').
member('Caulder','IT Technologies').
member('Burn','IT Technologies').
member('Kane','IT Technologies').
member('Mark','IT Technologies').
member('Jean','IT Technologies').
member('Jenny','IT Technologies').
member('Grace','IT Technologies').

member('William','IT Project manager').
member('Todd','IT Project manager').
member('Billy','IT Project manager').
member('Jacob','IT Project manager').
member('James','IT Project manager').
member('Daniel','IT Project manager').
member('Adam','IT Project manager').
member('Chloe','IT Project manager').
member('Sofia','IT Project manager').
member('Layla','IT Project manager').

member('Arica','Marketing').
member('Victoria','Marketing').
member('Camila','Marketing').
member('Mia','Marketing').
member('Avery','Marketing').
member('Amelia','Marketing').
member('Riley','Marketing').
member('Henry','Marketing').
member('Max','Marketing').
member('Edward','Marketing').

member('IT Technologies','John').
member('IT Technologies','Mason').
member('IT Technologies','Buck').
member('IT Technologies','Caulder').
member('IT Technologies','Burn').
member('IT Technologies','Kane').
member('IT Technologies','Mark').
member('IT Technologies','Jean').
member('IT Technologies','Jenny').
member('IT Technologies','Grace').

member('IT Project manager','William').
member('IT Project manager','Todd').
member('IT Project manager','Billy').
member('IT Project manager','Jacob').
member('IT Project manager','James').
member('IT Project manager','Daniel').
member('IT Project manager','Adam').
member('IT Project manager','Chloe').
member('IT Project manager','Sofia').
member('IT Project manager','Layla').

member('Marketing','Arica').
member('Marketing','Victoria').
member('Marketing','Camila').
member('Marketing','Mia').
member('Marketing','Avery').
member('Marketing','Amelia').
member('Marketing','Riley').
member('Marketing','Henry').
member('Marketing','Max').
member('Marketing','Edward').

presidentComp('Alex','Kagat').
presidentComp('Kagat','Alex').

vicePresidentComp('David','Kagat').
vicePresidentComp('Kagat','David').

%Company co-operation:
co_op('Kagat','Mining').
co_op('Mining','Kagat').

co_op('Kagat','Vining').
co_op('Vining','Kagat').

%Department of company
departmentOfCompany('Kagat','IT Project manager').
departmentOfCompany('Kagat','IT Technologies').
departmentOfCompany('Kagat','Marketing').

departmentOfCompany('IT Project manager','Kagat').
departmentOfCompany('IT Technologies','Kagat').
departmentOfCompany('Marketing','Kagat').

%Relationship:
memberCompany(X,Y) :- departmentOfCompany(X,Z),member(Y,Z).

companyMember(X,Y) :- departmentOfCompany(Y,Z),member(X,Z).

departmentCompany(X,Y) :- departmentCompany(X,Y).

memberDepartMent(X,Y) :- member(X,Y).

managerDepartment(X,Y) :- member(X,Y),manager(X).

managerToEmployees(X,Y) :- member(X,Z),member(Y,Z),manager(X).

presidentToEmployees(X,Y) :- presidentComp(X,Z),memberCompany(Y,Z),president(X).

vicePresidentToEmployees(X,Y) :- vicePresidentComp(X,Z),memberCompany(Y,Z),vicePresident(X).

presidentToManager(X,Y) :- presidentComp(X,Z),memberCompany(Y,Z),president(X),manager(Y).

vicePresidentToManager(X,Y) :- vicePresidentComp(X,Z),memberCompany(Y,Z),vicePresident(X),manager(Y).

cooperation(X,Y) :- co_op(X,Y).

companyPresident(X,Y) :- presidentComp(X,Y).

companyVicePresident(X,Y) :- vicePresidentComp(X,Y).
