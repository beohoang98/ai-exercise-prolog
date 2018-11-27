#!/usr/bin/python

from interface import search, rules, Term, Rule, read_sentences
import re, sys, getopt, os.path

def main (argv) :
    # xu ly cmd option va arguments
    source = ''
    question = ''

    try:
      opts, args = getopt.getopt(argv,"hs:q:",["source=","question="])
    except getopt.GetoptError:
      print 'main.py -s <source file> -q <question file>'
      sys.exit(2)

    for opt, arg in opts:
      if opt == '-h':
         print 'main.py -s <source file> -q <question file>'
         sys.exit()
      elif opt in ("-s", "--source"):
         source = arg
      elif opt in ("-q", "--question"):
         question = arg
    
    if (not(os.path.isfile(source)) or not(os.path.isfile(question))):
        print 'files are not exist'
        sys.exit()

    # doc va xuat output
    procFile(open(source, 'r'), open(question, 'r'))    # file on the command line

def procFile (source, question) :
    global rules

    rule_sent = read_sentences(source)
    for sent in rule_sent:
        rules.append(Rule(sent))

    rule_ques = read_sentences(question)
    ques_id = 0
    for ques in rule_ques:
        ques_id += 1
        print('\n{}. {}?'.format(ques_id, ques))
        search(Term(ques))

if __name__ == "__main__" : main(sys.argv[1:])
