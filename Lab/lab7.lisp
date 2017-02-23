Lab 7 Problem Set.

Like HW07, we will look at a number of diverse problems from the material
discussed in this class so far.

===========================================================================
======= 1. Propositional logic: fun with truth tables
===========================================================================

Garry suggests a new Boolean connective, denoted *, and has defined its
meaning using a truth table. Unfortunately, coffee stains have smudged the
table to the extent that some entries are unreadable. These are marked
below with ? .

  a  b  a * b
  =============
  T  T    ?
  T  F    T
  F  T    ?
  F  F    F

Garry still remembers that he was able to simplify the formula

  a /\ b => (a * b)

to T, i.e. the formula is valid. He also remembers that * is different from
/\, \/, =>, <>, and = . That is, a * b is not equivalent to a /\ b , and
similarly for the other connectives listed.

(a) Show that there is a way to replace the ugly coffee stains in the table
with truth values such that both above constraints are satisfied (existence
of a solution).

T, F

(b) Explain (!) that your solution is unique: there is no other. Think
about whether you had any choice in finding your answer in (a).

* can not be any connectives listed before, so the truth table can not be the same as others'. Also it has to fulfill the requirement
of the proof, so the solution is only and unique.

(c) Is this connective really new? How can you simplify a * b ?

a or (a and b) = a and (a or b) = a which is not a binary connective

===========================================================================
======= 2. Propositional logic: even more fun with truth tables
===========================================================================

How many binary Boolean functions f(x,y) are there such that both
x /\ y => f(x,y) and f(x,y) => x \/ y are valid? You do not have
to explicitly write down these functions. If there is none, explain why.

Hint: truth table.

2
  t f
  f t

===========================================================================
======= 3. Propositional logic: solving puzzles
===========================================================================

You are given three labeled boxes: two are empty, one contains money; but
you don't know which one. The labels on boxes 1 and 2 read, "This box is
empty"; the label on box 3 reads "The money is in box 2". The problem is
that one label tells the truth, the other two lie. The question is: where
is the money?

Formalize the puzzle as a satisfiability problem, and solve it, as follows.

(a) Define propositional variables to represent relevant atomic facts
(whose truth we currently do not know).

Hint: relevant facts may include whether a particular label tells the
truth, and whether a particular box contains the money.

t1, t2, t3 = the statement of the label t is true
m1, m2, m3 = the money is in box 1 2 3 respectively

(b) Using these variables, formulate the knowledge given in the problem as
propositional formulas. Be careful with the statement that exactly one
label tells the truth: it means that one tells the truth (we don't know
which one) and the other two "lie".

((m1 /\ ~m2 /\ ~m3) \/   money is in b1
 (~m1 /\ m2 /\ ~m3) \/   money is in b2
 (~m1 /\ ~m2 /\ m3))     money is in b3

((~m1 /\ m2 /\ ~m3) \/   label 1 is true
 (m1 /\ ~m2 /\ ~m3) \/   label 2 is true
 (~m1 /\ ~m2 /\ m3))     label 3 is true


(c) Show that the formula you have found in (b) is satisfiable. State where
the money is, and which label tells the truth, according to the satisfying
assignment. You may use simplifications, or truth tables.



(d) Someone objects: "What if there are several solutions? Then we still
don't know where the money is!" You have to admit that the person is right.
Think about how we could figure out, using propositional logic, whether the
solution we found is unique, and apply your idea to this problem. What do
you find?




===========================================================================
======= 4. Equational Reasoning
===========================================================================

Consider the following standard definition:

(defunc len (x)
  :input-contract (listp x)
  :output-contract (natp (len x))
  (if (endp x)
    0
    (+ 1 (len (rest x)))))

and this function:

(defunc ziplists (x y)
  :input-contract (and (listp x) (listp y) (equal (len x) (len y)))
  :output-contract (listp (ziplists x y))
  (if (endp x)
    nil
    (cons (list (first x) (first y))
          (ziplists (rest x) (rest y)))))

Now prove:

(and (implies (endp x)
              (equal (len (ziplists x y))
                     (len x)))
     (implies (equal (len (ziplists x y))
                     (len x))
              (equal (len (ziplists (cons a x) (cons b y)))
                     (len (cons a x)))))

Remember that, before proving anything, you must perform
Con... Con... Che... (you fill in the dots). Do this carefully!

need to fulfill the contract requirements 
add (endp x) (listp x) (listp y) (equal (len x) (len y))


Case 1 
C1.(endp x)
C2.(listp x) 
C3.(listp y) 
C4.(equal (len x) (len y))
----
C5. x = nil (C1 C2)

(len (ziplists x y))
= {
(len nil)
= {
(len x)


Case 2
