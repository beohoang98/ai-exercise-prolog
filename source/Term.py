import sys

uppercase= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

def fatal (mesg) :
    sys.stdout.write ("Fatal: %s\n" % mesg)
    sys.exit(1)

def split (l, sep, All=1) :
    "Split l by sep but honoring () and []"
    nest = 0
    lsep = len(sep)
    if l == "" : return []
    for i in range(len(l)) :
        c = l[i]
        if nest <= 0 and l[i:i+lsep] == sep :
            if All : return [l[:i]]+split(l[i+lsep:],sep)
            else   : return [l[:i],l[i+lsep:]]
        if c in ['[','('] : nest = nest+1
        if c in [']',')'] : nest = nest-1
    return [l]

def isVariable(term) : return term.args == [] and     term.pred[0:1] in uppercase
def isConstant(term) : return term.args == [] and not term.pred[0:1] in uppercase

infixOps = ("*is*","==","<",">","+","-","*","/")
def splitInfix(s) :
    for op in infixOps :
        p = split(s,op,All=0)
        if len(p) > 1 : return (op,p)
    return None

class Term :
    def __init__ (self, s, args=None) :
        if not args : parts = splitInfix(s)
        if args :            # Predicate and args seperately
            self.pred = s
            self.args = args
        elif parts :
            self.args = map(Term,parts[1])
            self.pred = parts[0]
        elif s[-1] == ']' :  # Build list "term"
            flds = split(s[1:-1],",")
            fld2 = split(s[1:-1],"|")
            if len(fld2) > 1 :
                self.args = map(Term,fld2)
                self.pred = '.'
            else :
                flds.reverse()
                l = Term('.',[])
                for fld in flds : l = Term('.',[Term(fld),l])
                self.pred = l.pred; self.args = l.args
        elif s[-1] == ')' :               # Compile from "pred(a,b,c)" string
            flds = split(s,'(',All=0)
            if len(flds) != 2 : fatal("Syntax error in term: %s" % [s])
            self.args = map(Term,split(flds[1][:-1],','))
            self.pred = flds[0]
        else : 
            self.pred = s           # Simple constant or variable
            self.args = []

    def __repr__ (self) :
        if self.pred == '.' :
            if len(self.args) == 0 : return "[]"
            nxt = self.args[1]
            if nxt.pred == '.' and nxt.args == [] :
                return "[%s]" % str(self.args[0])
            elif nxt.pred == '.' :
                return "[%s,%s]" % (str(self.args[0]),str(self.args[1])[1:-1])
            else :
                return "[%s|%s]" % (str(self.args[0]),str(self.args[1]))
        elif self.args :
            return "%s(%s)" % (self.pred, ",".join(map(str,self.args)))
        else : return self.pred