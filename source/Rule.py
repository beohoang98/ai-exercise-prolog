from Term import Term, split

class Rule :
    def __init__ (self, s) :   # expect "term:-term,term,..."
        flds = s.split(":-")
        self.head = Term(flds[0])
        self.goals = []
        if len(flds) == 2 :
            flds = split(flds[1],",")
            for fld in flds : self.goals.append(Term(fld))

    def __repr__ (self) :
        rep = str(self.head)
        sep = " :- "
        for goal in self.goals :
            rep += sep + str(goal)
            sep = ","
        return rep
