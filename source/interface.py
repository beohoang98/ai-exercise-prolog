import sys, copy, re, shlex

from Term import Term, isVariable, isConstant
from Goal import Goal
from Rule import Rule

rules    = []
indent   = ""

# A Goal is a rule in at a certain point in its computation. 
# env contains definitions (so far), inx indexes the current term
# being satisfied, parent is another Goal which spawned this one
# and which we will unify back to when this Goal is complete.
#

def unify (src, srcEnv, dest, destEnv) :
    "update dest env from src. return true if unification succeeds"
    global indent
    indent = indent+"  "
    if src.pred == '_' or dest.pred == '_' : return sts(1,"Wildcard")

    if isVariable(src) :
        srcVal = eval(src, srcEnv)
        if not srcVal : return sts(1,"Src unset")
        else : return sts(unify(srcVal,srcEnv,dest,destEnv), "Unify to Src Value")

    if isVariable(dest) :
        destVal = eval(dest, destEnv)           # evaluate destination
        if destVal : return sts(unify(src,srcEnv,destVal,destEnv),"Unify to Dest value")
        else :
            destEnv[dest.pred] = eval(src,srcEnv)
            return sts(1,"Dest updated 1")      # unifies. destination updated

    elif src.pred      != dest.pred      : return sts(0,"Diff predicates")
    elif len(src.args) != len(dest.args) : return sts(0,"Diff # args")
    else :
        dde = copy.deepcopy(destEnv)
        for i in range(len(src.args)) :
            if not unify(src.args[i],srcEnv,dest.args[i],dde) :
                return sts(0,"Arg doesn't unify")
        destEnv.update(dde)
        return sts(1,"All args unify")

def sts(ok, why) :
    global indent
    indent = indent[:-2]
    return ok

def search (term) :
    # pop will take item from end, insert(0,val) will push item onto queue
    goal = Goal(Rule("all(done):-x(y)"))      # Anything- just get a rule object
    goal.rule.goals = [term]                  # target is the single goal
    queue = [goal]                            # Start our search
    while queue :
        c = queue.pop()                       # Next goal to consider
        if c.inx >= len(c.rule.goals) :       # Is this one finished?
            if c.parent == None :            # Yes. Our original goal?
                if c.env : print  c.env         # Yes. tell user we
                else     : print "Yes"          # have a solution
                continue
            parent = copy.deepcopy(c.parent)  # Otherwise resume parent goal
            unify (c.rule.head,    c.env,
                   parent.rule.goals[parent.inx],parent.env)
            parent.inx = parent.inx+1         # advance to next goal in body
            queue.insert(0,parent)            # let it wait its turn
            continue

        # No. more to do with this goal.
        term = c.rule.goals[c.inx]            # What we want to solve

        pred = term.pred                    # Special term?
        if pred in ['*is*', 'cut','fail','<','=='] :
            if pred == '*is*' :
                ques = eval(term.args[0],c.env)
                ans  = eval(term.args[1],c.env)
                if ques == None :
                    c.env[term.args[0].pred] = ans  # Set variable
                elif ques.pred != ans.pred :
                    continue                # Mismatch, fail
            elif pred == 'cut' : queue = [] # Zap the competition
            elif pred == 'fail': continue   # Dont succeed
            elif not eval(term,c.env) : continue # Fail if not true
            c.inx = c.inx + 1               # Succeed. resume self.
            queue.insert(0,c)
            continue

        for rule in rules :                   # Not special. Walk rule database
            if rule.head.pred      != term.pred      : continue
            if len(rule.head.args) != len(term.args) : continue
            child = Goal(rule, c)               # A possible subgoal
            ans = unify (term, c.env, rule.head, child.env)
            if ans :                    # if unifies, queue it up
                queue.insert(0,child)

def eval (term, env) :      # eval all variables within a term to constants
    # special = operators.get(term.pred)
    # if special :
        # return special(eval(term.args[0],env),eval(term.args[1],env))
    if isConstant(term) : return term
    if isVariable(term) :
        ans = env.get(term.pred)
        if not ans : return None
        else       : return eval(ans,env)
    args = []
    for arg in term.args : 
        a = eval(arg,env)
        if not a : return None
        args.append(a)
    return Term(term.pred, args)

def read_sentences(f):
    sens = []
    sen = ''
    while 1:
        line = f.readline()
        if (line == ""): break # EOF

        line = re.sub("[\\r\\n]+", "", line)
        line = re.sub("%.*","",line) # split comment and \n

        # print(line)
        # stringInLine = re.findall(R"(')(?:(?=(\\?))\2.)*?\1", line) # https://stackoverflow.com/a/171499/8699894
        # for string in stringInLine:
        #     stringFmted = re.sub("'", "", string)
        #     stringFmted = "_" + stringFmted.title()
        #     line = re.sub(string, stringFmted) 

        line = "".join(re.split(" ", line))
        # print(line)

        if (line == ""): continue
        sen += line

        if (sen[-1] == '.'):
            sens.append(sen[:-1]) # bo dau .
            sen = ''

    # print sens
    return sens