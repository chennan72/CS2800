; **************** BEGIN INITIALIZATION FOR ACL2s B MODE ****************** ;
; (Nothing to see here!  Your actual file is after this initialization code);

#|
Pete Manolios
Fri Jan 27 09:39:00 EST 2012
----------------------------

Made changes for spring 2012.


Pete Manolios
Thu Jan 27 18:53:33 EST 2011
----------------------------

The Beginner level is the next level after Bare Bones level.

|#

; Put CCG book first in order, since it seems this results in faster loading of this mode.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading the CCG book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "ccg/ccg" :uncertified-okp nil :dir :acl2s-modes :ttags ((:ccg)) :load-compiled-file nil);v4.0 change

;Common base theory for all modes.
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s base theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "base-theory" :dir :acl2s-modes)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s customizations book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "custom" :dir :acl2s-modes :uncertified-okp nil :ttags :all)

;Settings common to all ACL2s modes
(acl2s-common-settings)

#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading trace-star and evalable-ld-printing books.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "trace-star" :uncertified-okp nil :dir :acl2s-modes :ttags ((:acl2s-interaction)) :load-compiled-file nil)
(include-book "hacking/evalable-ld-printing" :uncertified-okp nil :dir :system :ttags ((:evalable-ld-printing)) :load-compiled-file nil)

;theory for beginner mode
#+acl2s-startup (er-progn (assign fmt-error-msg "Problem loading ACL2s beginner theory book.~%Please choose \"Recertify ACL2s system books\" under the ACL2s menu and retry after successful recertification.") (value :invisible))
(include-book "beginner-theory" :dir :acl2s-modes :ttags :all)


#+acl2s-startup (er-progn (assign fmt-error-msg "Problem setting up ACL2s Beginner mode.") (value :invisible))
;Settings specific to ACL2s Beginner mode.
(acl2s-beginner-settings)

; why why why why 
(acl2::xdoc acl2s::defunc) ; almost 3 seconds

(cw "~@0Beginner mode loaded.~%~@1"
    #+acl2s-startup "${NoMoReSnIp}$~%" #-acl2s-startup ""
    #+acl2s-startup "${SnIpMeHeRe}$~%" #-acl2s-startup "")


(acl2::in-package "ACL2S B")

; ***************** END INITIALIZATION FOR ACL2s B MODE ******************* ;
;$ACL2s-SMode$;Beginner
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
   
   (rev2 (cons (app (app b c) (list a b)) (rev2 a)))
   
b. (cons 'c d)|
   ((c (cons a (list d))) (d (cons c nil)))
   
   (cons 'c (cons c nil))
   
c. (or (endp u) (app u (cons w nil))))|
   ((u (list w)) (w (cons (first x) u)))
   
   (or (endp (list w)) (app (list w) (cons (cons (first x) u) nil)))

d. (* (* y (/ y (len z))) (+ (len z) y))|
   ((len (/ a b)) (y (/ a b)))
   ??????????
   (* (* (/ a b) (/ (/ a b) ((* y z) z))) (+ ((/ a b) z) (/ a b)))
   
e. (equal (+ (+ (len x) (len y)) (len 'z)) (len (cons z (app 'x y))))|
   ((x '(2 8)) (y '(5 6)) (z '(3)))
   
   (equal (+ (+ (len '(2 8)) (len '(5 6))) (len 'z)) (len (cons '(3) (app 'x '(5 6)))))

f. (cons u (app u w))|
   ((u (app w w))(w (app b a)) (w (list w)))
   ????????????
   (cons (app w w) (app (app w w) w))
   
g. (app u w)|
   ((w (app u w)) (u w))
   
   (app w (app u w))
   
h. (cons u (f u w f))|
   ((u (cons a b))(f u)(w (app w u)))
   
   (cons (cons a b) (u (cons a b) (app w u) u))
   
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
   
   ((a (cons (list (first x)) x)) (b (cons z (len2 (rest x)))))

b. (and (< (/ z w) (- x (+ x 2))) (> z x))
   (and (< (/ (unary-- (+ (- 5 6) 7)) x) (- (* x x) (+ (* x x) 2))) (> (unary-- (+ (- 5 6) 7)) (* x x)))
   
   ((z (unary-- (+ (- 5 6) 7))) (w x) (x (*x x)))

c. (app y z)
   (list 9 1)
   
   ((y '(9)) (z '(1)))
 
d. (app 'a (app b '(1 2 3)))
   (app x (app y '(1 2 3)))
   
   (('a x) (b y))

e. (in x y)
   (in y (rev2 y)) 
   
   ((x y) (y (rev2 y)))
  
f. (app (list a b) b)
   (app (list c d) (first (cons d nil)))
   
   None??????????
  
g. (app a (app (cons b c) c))
   (app '(1 2) (app (cons c (cons b c)) (cons b c)))
   
   ((a '(1 2)) (b c) (c (cons b c)))
   
h. (cons y (app (list x)  y))
   (cons (- (expt 2 6) w) (app (list (- (expt 2 6) w)) (- (expt 2 6) q)))
   
   ((y (- (expt 2 6) w)) (x (- (expt 2 6) w)))

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
3.  (implies (and (listp n) (equal m nil))
             (equal (comb-len m n) 0))


...............................

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION4>>
4.  (implies (in2 x l)
             (in2 x (cons a l)))
.................

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION5>>
5. (implies (listp l)
            (> (len2 (duplicate l)) (len2 l)))

...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION6>>
6. (implies (equal (comb-len (rest m) n) x)
            (equal (comb-len m n)
                   (+ x (len2 m))))

...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION7>>
7. (implies (equal (in2 a (rest l))
                   (in2 a (duplicate (rest l))))
            (equal (in2 a l)
                   (in2 a (duplicate l))))

...............

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

...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION9>>
9. Reversing a list three times gives back the original list.

...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION10>>
10. If a is in (use the function in2) the append of x y and a is
    not in x, then a is in y.

...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION11>>
11. If a is in (use in2) the append of x y and a is in x, then a is
    not in y.

...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION12>>
12. The comb-len of x and x is x*x.

...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION13>>
13. The comb-len of x and y is the same as the comb-len of y and x.

...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION14>>
14. The comb-len of x and y is equal to the comb-len of a and b
    iff the length of x is equal to the length of a and the
    length of y is equal to the length of b.

...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION15>>
15. If a is in (use in2) l and b is in l and c is in l, then the
    length of l is greater than or equal to 3.

...............

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION16>>
16. Suppose 1 is in (use in2) x and 2 is in x. Also, suppose
    that if a is a value that differs from 1 and 2, it is not in
    x.  Similarly 3 and 4 are in y, but if b is a value that
    differs from 3 and 4, it is not in y. Then the comb-len of x
    and y is 4.

...............

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
Changzong Liu
<firstname> <LastName>

|#