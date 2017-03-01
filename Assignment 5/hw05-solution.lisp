#|
CS 2800 Homework 5 - Spring 2017

;; <<@PREAMBLE>>
This homework is to be done in a group of 2-3 students. 

If your group does not already exist:

 * One group member will create a group in BlackBoard
 
 * Other group members then join the group
 
 Submitting:
 
 * Homework is submitted by one group member. Therefore make sure the person
   submitting actually does so. In previous terms when everyone needed
   to submit we regularly had one person forget but the other submissions
   meant the team did not get a zero. Now if you forget, your team gets 0.
   - It wouldn't be a bad idea for group members to send confirmation 
     emails to each other to reduce anxiety.

 * Submit the homework file (this file) on Blackboard.  Do not rename 
   this file.  There will be a 10 point penalty for this.

 * You must list the names of ALL group members below, using the given
   format. This way we can confirm group membership with the BB groups.
   If you fail to follow these instructions, it costs us time and
   it will cost you points, so please read carefully.


Names of ALL group members: FirstName1 LastName1, FirstName2 LastName2, ...

Note: There will be a 10 pt penalty if your names do not follow 
this format.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
QUESTION 1: SUBSTITUTIONS
;; <<@QUESTION1>>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Question 1: Applying a substitution.

Below you are given a set of ACL2s terms and substitutions. Recall
that a substitution is a list of pairs, where the first
element of each pair is a variable and the second an
expression. Also, variables can appear only once as a left
element of a pair in any substitution. For example, the
substitution ((y (cons a b)) (x m)) maps y to (cons a b) and x to
m. 

For each term/substitution pair below, show what you get when
you apply the substitution to the term (i.e., when you
instantiate the term using the given substitution).  
If the substitution is syntactically invalid (not allowed), indicate why.
Note: you do not need to evaluate the returned expression.

Example.  (foo (bar x y) z)|
          ((x (list 3))(bar zap)(y (cons 'l nil))(z (+ 1 2)))
          *(foo (bar (list 3) (cons 'l nil)) (+ 1 2))
(The * simply indicates the answer line)

In class we wrote this as 
(foo (bar x y) z)| ((x (list 3))(bar zap)(y (cons 'l nil))(z (+ 1 2))) but
the two line format will make it easier for you to read.
Notice that we only substitute for variables and there is no 
variable bar in the example: bar is the name of a function in the
example and when applying a substitution, functions are not affected.
          
a. (rev2 (cons (app w y) z))|
   ((w (app b c)) (y (list a b)) (z (rev2 a)))
   *(rev2 (cons (app (app b c) (list a b))(rev2 a)))

b. (cons 'c d)|
   ((c (cons a (list d))) (d (cons c nil)))
   *(cons 'c (cons c nil)) 
   Note: 'c is not a variable
   
c. (or (endp u) (app u (cons w nil))))|
   ((u (list w)) (w (cons (first x) u)))
   *(or (endp (list w)) (app (list w) (cons (cons (first x) u) nil)))

d. (* (* y (/ y (len z))) (+ (len z) y))|
   ((len (* y z))(y (/ a b)))
   * (* (* (/ a b) (/ (/ a b) (len z))) (+ (len z) (/ a b)))
   len only appears as a function, not a variable.
   
e. (equal (+ (+ (len x) (len y)) (len 'z)) (len (cons z (app 'x y))))|
   ((x '(2 8)) (y '(5 6)) (z '(3)))
   *(equal (+ (+ (len '(2 8)) (len '(5 6))) (len 'z))(len (cons '(3)(app 'x '(5 6)))))
   'x and 'z are not variables!

f. (cons u (app u w))|
   ((u (app w w))(w (app b a)) (w (list w)))
   *Invalid substitution. A variable can occur only once in the substitution list.
   
g. (app u w)|
   ((w (app u w)) (u w))
   *(app w (app u w))
   
h. (cons u (f u w f))|
   ((u (cons a b))(f u)(w (app w u)))
   *(cons (cons a b) (f (cons a b) (app w u) u))
    Note that f is both a function and variable!
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Question 2: Finding a substitution, if it exists.
;; <<@QUESTION2>>
For each pair of ACL2 terms, give a substitution that instantiates the 
first to the second. If no substitution exists write "None".
Example: (app l m)
         (app (cons 3 nil) nil)
        *((l (cons 3 nil))(m nil))
Again the * is just used to indicate the solution line.

a. (app (list a) (rev2 b))
   (app (list (cons (list (first x)) x)) (rev2 (cons z (len2 (rest x)))))
   *((a (cons (list (first x)) x)) (b (cons z (len2 (rest x)))))

b. (and (< (/ z w) (- x (+ x 2))) (> z x))
   (and (< (/ (unary-- (+ (- 5 6) 7)) x) (- (* x x) (+ (* x x) 2))) (> (unary-- (+ (- 5 6) 7)) (* x x)))
   *((z (unary-- (+ (- 5 6) 7))) (w x) (x (* x x)))

c. (app y z)
   (list 9 1)
   *None. Functions are never changed by a substitution.
 
d. (app 'a (app b '(1 2 3)))
   (app x (app y '(1 2 3)))
   *None. Can not substitute for a constant (symbol 'a).

e. (in x y)
   (in y (rev2 y)) 
   *((x y)(y (rev2 y)))
  
f. (app (list a b) b)
   (app (list c d) (first (cons d nil)))
   *None. b cannot be substituted for both d and (first (cons d nil)), 
    even if they are equal!
  
g. (app a (app (cons b c) c))
   (app '(1 2) (app (cons c (cons b c)) (cons b c)))
   *((a '(1 2))(b c)(c (cons b c)))
   
h. (cons y (app (list x)  y))
   (cons (- (expt 2 6) w) (app (list (- (expt 2 6) w)) (- (expt 2 6) q)))
   *None.  y can't be substituted for two different expressions.

|#


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SECTION 2: INTRODUCTION TO EQUATIONAL REASONING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

Questions 3 to 5 ask for equational proofs about ACL2s
programs. Below you are given a set of function definitions you can use. 
Note in many cases the name has been slightly changed so you can't simply
use a theorem from class (ex. in2 instead of in). 

The definitional axioms (input contract => (function call = function body))
and contract theorems (input contract => output contract) for defined 
functions can be used in the proof. 

You can use ACL2s to check the conjectures you come up with, but you are 
not required to do so. 

Here are some notes about equational proofs although additional information
can be found in the course notes 
(http://www.ccs.neu.edu/course/cs2800sp17/rapeq.pdf). Remember the key
consideration when grading your proofs will be how well you communicate 
your ideas and justifications.

1. The context. Remember to use propositional logic to rewrite
the context so that it has as many hypotheses as possible.  See
the lecture notes for details. Label the facts in your
context with C1, C2, ... as in the lecture notes.

2. The derived context. Draw a dashed line (----) after the context 
and add anything interesting that can be derived from the context.  
Use the same labeling scheme as was used in the context. Each derived
fact needs a justification. Again, look at the lecture notes for
more information.

3. Use the proof format shown in class and in the lecture notes,
which requires that you justify each step.

4. When using an axiom, theorem or lemma, show the name of the
axiom, theorem or lemma and then *show the substitution* you are
using for any definitional axiom, or theorem IF a substitution 
actually occurs  (no need to write (n n) for example).  
Ex. Using the definitional axiom for app to conclude (app2 nil l) = l
you would write {Def. app2|((x nil)(y l)), if axioms}

5. When using the definitional axiom of a function, the
justification should say "Def. <function-name>".  When using the
contract theorem of a function, the justification should say
"Contract <function-name>".

6. Arithmetic facts such as commutativity of addition can be
used. The name for such facts is "arithmetic".

7. You can refer to the axioms for cons, and consp as the "cons axioms", 
Axioms for first and rest can be referred to as "first-rest axioms".
The axioms for if are named "if axioms"

8. Any propositional reasoning used can be justified by "propositional
reasoning", "Prop logic", or "PL" except you should use "MP" 
to explicitly identify when you use modus ponens.

9. For this homework, you can only use theorems we explicitly
tell you you can use or we have covered in class / lab. 
You can, of course, use the definitional axiom and contract 
theorem for any function used or defined in this homework. You
may also use theorems you've proven earlier in the homework.
Here are the definitions used for the remainder of the questions.

10. For any given propositional expression, feel free to re-write it
in infix notation (ex a =>(B/\C)).

(defunc listp (l)
  :input-contract t
  :output-contract (booleanp (listp l))
  (if (consp l)
      (listp (rest l))
    (equal l nil)))
    
(defunc endp (l)
  :input-contract (listp l)
  :output-contract (booleanp (endp l))
  (if (consp l) nil t))
  
(defunc len2 (x)
  :input-contract (listp x)
  :output-contract (natp (len2 x))
  (if (endp x)
      0
    (+ 1 (len2 (rest x)))))

(defunc duplicate (l)
  :input-contract (listp l)
  :output-contract (listp (duplicate l))
  (if (endp l)
      nil
    (cons (first l) (cons (first l) (duplicate (rest l))))))

(defunc in2 (a l)
  :input-contract (listp l)
  :output-contract (booleanp (in2 a l))
  (if (endp l)
      nil
    (or (equal a (first l)) (in2 a (rest l)))))
    
(defunc comb-len (m n)
  :input-contract (and (listp m) (listp n))
  :output-contract (natp (comb-len m n))
  (if (endp m) 
      0
    (+ (len2 n) (comb-len (rest m) n))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


For each of the conjectures in questions 3-7:

- perform conjecture contract checking, and add hypotheses if
  necessary.  Contract completion is the process of adding the
  minimal set of hypotheses needed to guarantee that the input
  contracts for all functions used in the conjecture are
  satisfied when the hypotheses are satisfied. Do not add
  anything else to the conjecture.

- run some tests to make an educated guess as to whether the conjecture is
  true or false. 
    - Not all conjectures are valid.
    - If the conjecture is not valid, give a counterexample and show that 
    it evaluates to false. 
    - For theorems, give a proof using equational reasoning, following 
    instructions 1 to 10 above. 
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION3>>
3. (implies (and (listp n) (equal m nil))
            (equal (comb-len m n) 0))
                   
SOLUTION
Context:
C1. (listp n)
C2. (equal m nil)
-----------------
C3. (not (consp m)) {C2, cons axioms} 
C4. (listp m) {Def listp|((l m)), C2}
C5. (endp m) {C3, C4, Def endp|((l m))}
NOTE: C3 is not necessary for full credit but C4 and C5 are. C4 and C5
can be derived from C1 C2 without showing the intermediary step
of C3.
NOTE 2: If students use contract checking and completion to add (listp m), 
then C4 won't be necessary but technically contract completion isn't needed.

Proof:
  (comb-len nil n)
=   {C1, C4, C5, Def comb-len, if-axioms}
  0

OR

  (comb-len m n)
=   {C1, C4, Def comb-len} 
  (if (endp m)
      0
      (+ (len n) (comb-len (rest nil) n)))
=   {if-axioms, C5}
  0
  
QED

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION4>>
4. (implies (in2 x l)
            (in2 x (cons a l)))

SOLUTION:
This needs contract completion

(implies (and (listp l) (in2 x l))
         (in2 x (cons a l)))
                  
The conjecture passes contract checking.
Now the proof of phi:

C1. (listp l)
C2. (in2 x l)

GRADING NOTE: the first two steps below can be combined without penalty.
Each small step is being written only because this is our initial 
equational reasoning assignment.

  (in2 x (cons a l))
=   {Def in2|((a x)(l (cons a l))), C1}
  (if (endp (cons a l))
      nil
      (or (equal x (first (cons a l))) (in2 x (rest (cons a l)))))
=   {Def endp, cons axioms, PL, if axioms}
  (or (equal x (first (cons a l))) (in2 x (rest (cons a l))))
=   {first-rest axioms, cons axioms (twice)}
  (or (equal x a) (in2 x l))
=   {C2, PL}
  t

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION5>>
5. (implies (listp l) 
            (> (len2 (duplicate l)) (len2 l)))

SOLUTION:
This is not a theorem. Students need to provide a counter-example.
For this case the only counter example is l = nil.  In that case
the two lengths are the same.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION6>>
6. (implies (equal (comb-len (rest m) n) x)
            (equal (comb-len m n)
                   (+ x (len2 m))))

SOLUTION:
Contract completion gives us:

(implies (and (listp m) (listp n) (consp m) 
              (equal (comb-len (rest m) n) x))  
         (equal (comb-len m n)
                (+ x (len2 m))))

Note that they do not need to say that x is a natp.
That follows from the comb-len function contract.
This is not a theorem. If we did replace (len2 m)
with (len2 n) we would have a theorem. 

C1. (listp m)
C2. (listp n) 
C3. (consp m) 
C4. x=(comb-len (rest m) n)
------------------------------------
C5. (natp x) {comb-len contract, equality, C4}

  (comb-len m n)
=  {Def comb-len|(), if axioms, C3}
  (len2 n) + (comb-len (rest m) n)
=  {C4}
  (len2 n) + x

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION7>>
7. (implies (equal (in2 a (rest l))
                   (in2 a (duplicate (rest l))))
            (equal (in2 a l)
                   (in2 a (duplicate l))))

SOLUTION:
Contract completion gives us:

(implies (and (list l) (consp l)
              (equal (in2 a (rest l))
                     (in2 a (duplicate (rest l)))))
         (equal (in2 a (duplicate l))
                (in2 a l)))

C1. (list l)
C2. (consp l)
C3. (in2 a (rest l)) = (in2 a (duplicate (rest l)))

(in2 a (duplicate l))
= {Def duplicate, C2, Def endp, if-axioms }
(in2 a (cons (first l) (cons (first l) (duplicate (rest l)))))
= {Def in2, endp, first-rest axioms}
(or (equal a (first l)) (in2 a (cons (first l) (duplicate (rest l)))))
= {Def in2, endp, first-rest axioms}
(or (equal a (first l)) (or (equal a (first l)) (in2a (duplicate (rest l)))))
= {PL: or idempotent}
(or (equal a (first l)) (in2a (duplicate (rest l))))
= {C3}
(or (equal a (first l)) (in2a (rest l)))
= {Def in2, C2, Def endp}
(in2 a l)

|#


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SECTION 3: SPECIFICATIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

This section deals with specifications using the functions
defined in Section 2, as well as any functions appearing in the
lecture notes. Claims below may not satisfy contract checking,
which means you should perform contract completion before
answering the question.

For each claim, formalize it using ACL2s (remember this requires
that you perform contract completion).

After that, indicate whether the formalized claim is valid.  You
do not need proofs here. If it is invalid, provide a
counterexample. Also, if it is invalid, propose the simplest
modification you can think of that is valid and formalize your
new claim. For this part, there may be many possible answers, in
which case any reasonable answer is fine.  If you discover
anything interesting, indicate it.

Example. len2 is equivalent to len.

Answer.
The formalization is:

(implies (listp l)
         (equal (len2 l) (len l)))


This conjuncture is valid.

Note: that if you were to say that the claim is false because it
only holds for lists, that is not a correct answer because you
have to perform contract completion first!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION8>>
8. The length of the list obtained by appending x and y is 
   equal to the length of x plus the length of y.

The formalization is:

(implies (and (listp x) (listp y))
         (equal (len2 (app x y))
                (+ (len2 x) (len2 y))))

This conjuncture is valid.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION9>>
9. Reversing a list three times gives back the original list.

The formalization is:

(implies (listp x) 
         (equal (rev (rev (rev x))) x))

This conjuncture is invalid. Let x=(1 2). Here is a
version that is valid (anything that is valid and similar to the
original conjecture is OK).

(implies (listp x) 
         (equal (rev (rev (rev x))) (rev x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION10>>
10. If a is in (use the function in2) the append of x y and a is
    not in x, then a is in y.

The formalization is:

(implies (and (listp x) 
              (listp y)
              (in2 a (app x y))
              (not (in2 a x)))
         (in2 a y))

This conjuncture is valid.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION11>>
11. If a is in (use in2) the append of x y and a is in x, then a is
    not in y.

The formalization is:

(implies (and (listp x) 
              (listp y)
              (in2 a (app x y))
              (in2 a x))
         (not (in2 a y)))

This conjuncture is not valid. Let a=1, x=(1), y=(1). Here is a
version that is valid (anything that is valid and similar to the
original conjecture is OK).

(implies (and (listp x) 
              (listp y)
              (in2 a (app x y))
              (not (in a y)))
         (in a x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION12>>
12. The comb-len of x and x is x*x.

(implies (and (listp x) (rationalp x))
         (equal (comb-len x x) (* x x)))

Notice that this conjecture is true, but due to a mismatch in the
contracts: no x is both a list and a rational.  Contract
completion has given us a hypothesis that is equivalent to nil!
The moral here is to be careful when you have multiple hypotheses
involving the same variable.

Interesting observation: here is what was really meant.

(implies (listp x)
         (equal (comb-len x x) 
                (* (len2 x) (len2 x))))

This is valid.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION13>>
13. The comb-len of x and y is the same as the comb-len of y and x.

(implies (and (listp x) (listp y))
         (equal (comb-len x y) (comb-len y x)))

This conjecture is true.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION14>>
14. The comb-len of x and y is equal to the comb-len of a and b
    iff the length of x is equal to the length of a and the
    length of y is equal to the length of b.

(implies (and (listp x) (listp y) (listp a) (listp b))
         (iff (equal (comb-len x y) (comb-len a b))
              (and (equal (len2 x) (len2 a))
                   (equal (len2 y) (len2 b)))))

This conjecture is not valid. 

Let x=(1), y=(), a=(), b=(1)

Here is a modified conjecture that is true.

(implies (and (listp x) (listp y) (listp a) (listp b))
         (implies (and (equal (len2 x) (len2 a))
                       (equal (len2 y) (len2 b)))
                  (equal (comb-len x y) (comb-len a b))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION15>>
15. If a is in (use in2) l and b is in l and c is in l, then the
    length of l is greater than or equal to 3.

(implies (and (listp l)
              (in2 a l)
              (in2 b l)
              (in2 c l))
         (>= (len2 l) 3))

This conjecture is not valid. Let l=(1), a=b=c=1.

Here is a modified conjecture that is true.

(implies (and (listp l)
              (in2 a l)
              (in2 b l)
              (in2 c l)
              (not (equal a b))
              (not (equal a c))
              (not (equal b c)))
         (>= (len2 l) 3))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION16>>
16. Suppose 1 is in (use in2) x and 2 is in x. Also, suppose
    that if a is a value that differs from 1 and 2, it is not in
    x.  Similarly 3 and 4 are in y, but if b is a value that
    differs from 3 and 4, it is not in y. Then the comb-len of x
    and y is 4.

The problem here is that the statement

"suppose that if a is a value that differs from 1 and 2, it is
not in x.  Similarly 3 and 4 are in y, but if b is a value that
differs from 3 and 4, it is not in y."

requires quantification. The way around that is to define
a recursive function.

(defunc subsetp (x y)
  :input-contract (and (listp x) (listp y))
  :output-contract (booleanp (subsetp x y))
  (or (endp x)
      (and (in2 (first x) y)
           (subsetp (rest x) y))))

(implies (and (listp x)
	      (listp y)
	      (in2 1 x)
              (in2 2 x)
              (subsetp x '(1 2))
              (in2 3 y)
              (in2 4 y)
              (subsetp y '(3 4)))
           (equal (comb-len x y) 4))

This conjecture is not valid. Let x=(1 1 2 2), y=(3 4).

Here is a version that works.

(defunc nodups (x)
  :input-contract (listp x) 
  :output-contract (booleanp (nodups x))
  (or (endp x)
      (and (not (in2 (first x) (rest x)))
           (nodups (rest x)))))

(implies (and (listp x)
	      (listp y)
	      (in2 1 x)
              (in2 2 x)
              (subsetp x '(1 2))
              (nodups x)
              (in2 3 y)
              (in2 4 y)
              (subsetp y '(3 4))
              (nodups y))
           (equal (comb-len x y) 4))

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@FEEDBACK>>
;; Feedback (10 points)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|

We want to gather feedback about how the course is going
so we can improve your learning experience. After all, if
we only get feedback in the TRACE evaluations this won't help
you; just subsequent classes.

Please fill out the following form.

https://goo.gl/forms/nUF2mpZt7s7Gp74K2

We do not keep track of who submitted what, so please be honest. Each
individual student should fill out the form, e.g., if there are two
people on a team, then each of these people should fill out the form.
Only fill out the provided survey once since we can't identify multiple 
submissions from the same person and multiple responses skew the data.

After you fill out the form, write your name below in this file, not
on the questionnaire. We have no way of checking if you submitted the
file, but by writing your name below you are claiming that you did,
and we'll take your word for it.  

10 points will be awarded to your team for each of you filling out the 
survey. If one member doesn't fill out the survey, indicate this. We'll 
give everyone who claims to have filled out the questionnaire points.

The following team members filled out the feedback survey provided in 
the link above:
---------------------------------------------
<firstname> <LastName>
<firstname> <LastName>

|#
