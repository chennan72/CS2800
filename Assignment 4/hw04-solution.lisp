#|
;; <<@PREAMBLE>>
CS 2800 Homework 4 - Spring 2017

The last problem in this homework requires you to see if two expressions
are equivalent.  This happens to be an equivalent problem to SAT or satisfiability.
Thus, all you need to claim the Clay Institute $1M Millennium
prize for solving the P vs NP problem is to either come up with an
efficient algorithm or show that no such algorithm exists! Who guessed
this course could lead to such easy money.

This homework is to be done in a group of 2-3 students.  More thorough
instructions are on the course web page.

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

Also, notice the preamble tags both at the top of the file and
scattered throughout (EX. ;; <<@QUESTION_1>>).  Please leave these 
alone. We are testing potentially better ways to grade assignments.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw04.lisp

- make sure you are in BEGINNER mode. This is essential! Note that you can
  only change the mode when the session is not running, so set the correct
  mode before starting the session.

- insert your solutions into this file where indicated (usually as "...")

- only add to the file. Do not remove or comment out anything pre-existing
  unless asked to.

- make sure the entire file is accepted by ACL2s. In particular, there must
  be no "..." left in the code. If you don't finish all problems, comment
  the unfinished ones out. Comments should also be used for any English
  text that you may add. This file already contains many comments, so you
  can see what the syntax is.

- when done, save your file and submit it as hw04.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file!

Instructions for programming problems:

For each function definition, you must provide both contracts and a body.

You must also ALWAYS supply your own tests. This is in addition to the
tests sometimes provided. Make sure you produce sufficiently many new test
cases. This means: cover at least the possible scenarios according to the
data definitions of the involved types. For example, a function taking two
lists should have at least 4 tests: all combinations of each list being
empty and non-empty.

Beyond that, the number of tests should reflect the difficulty of the
function. For very simple ones, the above coverage of the data definition
cases may be sufficient. For complex functions with numerical output, you
want to test whether it produces the correct output on a reasonable
number of inputs.

Use good judgment. For unreasonably few test cases we will deduct points.
The markers have been given permission to add any tests they want. Thus one
way to tell how many tests you need: are you positive the markers won't break
your code?

We will use ACL2s' check= function for tests. This is a two-argument
function that rejects two inputs that do not evaluate equal. You can think
of check= roughly as defined like this:

(defunc check= (x y)
  :input-contract (equal x y)
  :output-contract (equal (check= x y) t)
  t)

That is, check= only accepts two inputs with equal value. For such inputs, t
(or "pass") is returned. For other inputs, you get an error. If any check=
test in your file does not pass, your file will be rejected.

You should also use test? for your tests. See Section 2.13 of the
lecture notes. An example is test? is the following.

(test? (implies (and (listp l) (natp n)) 
                (<= (len (sublist-start n)) n))) 

|#


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Propositional Logic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

We use the following ascii character combinations to represent the Boolean
connectives:

  NOT     ~

  AND     /\ .....^ in the programming section
  OR      \/ .....v in the programming section

  IMPLIES =>

  EQUIV   =
  XOR     <>

The binding powers of these functions are listed from highest to lowest
in the above table. Within one group (no blank line), the binding powers
are equal. This is the same as in class.

|#

#|

Construct the truth table for the following Boolean formulas. Use
alphabetical order for the variables in the formula, and create columns for
all variables occurring in the formula AND for all intermediate
subexpressions. (with one exception: you can omit negations of a single
variable such as ~p or ~r).

For example, if your formula is

(p => q) \/ r

your table should have 5 columns: for p, q, r, p => q, and (p => q) \/ r .

Then decide whether the formula is satisfiable, unsatisfiable, valid, or
falsifiable (more than one of these predicates will hold!). 

;; <<@QUESTION_1>>

1.
a) ~(p /\ q) = q => p

SOLUTION
(~(p /\ q)) = (q => p)
XX Answer: XX
XX p  q  p /\ q  ~(p/\ q)  q => p     (~(p /\ q)) = (q => p) XX
XX --------------------------------------------------------- XX
XX T  T    T         F       T            F XX
XX T  F    F         T       T            T XX
XX F  T    F         T       F            F XX
XX F  F    F         T       T            T XX
XX The formula is actually just ~q XX
XX This formula is satisfiable and falsifiable. XX



b) (p => q) /\ (~r = ~q) <> ~p => r  

Hint: your table should have 8 or 11 columns (depending if you write
the not columns including columns for p,q,r).

XX With (redundant but helpful) parentheses: XX

XX ((p => ~q) /\ (~r = q)) <> (~p => r) XX

XX XX
XX p | q | r | p => q | ~r | ~q | ~r = ~q | /\ | ~p |~p => r | <> XX
XX --------------------------------------------------------------- XX
XX T   T   T     T      F    F       T      T    F     T        F  XX
XX T   T   F     T      T    F       F      F    F     T        T  XX
XX T   F   T     F      F    T       F      F    F     T        T  XX
XX T   F   F     F      T    T       T      F    F     T        T  XX
XX F   T   T     T      F    F       T      T    T     T        F  XX
XX F   T   F     T      T    F       F      F    T     F        F  XX
XX F   F   T     T      F    T       F      F    T     T        T  XX
XX F   F   F     T      T    T       T      T    T     F        T  XX
XX XX
XX This formula is satisfiable and falsifiable. XX

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION_2>>
2. Simplify the following expressions using propositional logic rules (give 
either the rule name or the formula. You will get no credit for using
a truth table.
Transformations should take the form:
   expression 1
   = {Justification}
   expression 2
   = {Justification}
   expression 3
   ......

(a) ~p <> p \/ (q /\ p)
XX = {p \/ (p /\q) == p} XX
XX ~p <> p XX
XX = {~p <> p = T} XX
XX T XX

(b) (p \/ r => ((q /\ ~p) => (~r => r)))
XX ={ p=>~p = ~p} XX
XX (p \/ r => ((q /\ ~p) => r))
XX = {exportation} XX
XX (p \/ r) /\ (q /\ ~p) => r XX
XX = {commutative, associative} XX
XX ((p \/ r) /\ ~p /\ q => r XX
XX {Distributive} XX
XX ((p /\ ~p) \/ (r /\ ~p)) /\ q => r XX
XX = {p/\~p = nil (complement), identity} XX
XX r /\ ~p /\ q => r XX
XX = {p=>q == ~p\/q, DeMorgan's law, associativity} XX
XX p \/ ~q \/ ~r \/ r XX
XX = {Complement, annihilator} XX
XX t XX

(c) (p \/ q) /\ ((~p \/ q) /\ ~q))

...

XX DO NOT MARK XX
(p \/ q) /\ ((~p \/ q) /\ ~q))
= {Distributive, Complement, annihilator}
(P \/ q)/\ (~p /\ ~q)
={DeMorgan's Law}
(p \/ q) /\ ~(p \/q)
= {complement}
XX false or nil

(d) (p /\ ~q /\ r) \/ (p /\ ~q /\ ~ r) \/ (p /\ q /\ r) \/ (p /\ q /\ ~ r)

...
XX DO NOT MARK XX
(p /\ ~q /\ r) \/ (p /\ ~q /\ ~ r) \/ (p /\ q /\ r) \/ (p /\ q /\ ~ r)
= {Distributive}
(p/\ ((~q/\r) \/ (~q /\ ~r) \/ (q /\ r)\/(q/\~r)))
= {Distributive, Associative}
(p /\ (((~q /\ (r \/ ~r)) \/ (q /\ (r \/ ~r)))))
= {Complement, annihilator}
(p /\ (~q \/ q))
= {Complement, annihilator}
p


(e) (p = q) => ~(~p <> q)

...
XX (p = q) => ~(~p <> q) XX
XX = {~(p<>q) = (p = q) or ~(~p<>q) = (~p = q)}XX
XX (p = q) => (~p = q) XX
XX = {p=> ~p = ~p }XX
XX ~p = q  
XX NOTE: ~p = q = p<>q = ~(p = q)....they are the same:XX
XX   p | q | ~p=q | p<>q | ~(p=q)  XX
XX ------------------------------- XX
XX   F | F | F    |  F   |  F      XX
XX   F | T | T    |  T   |  T      XX
XX   T | F | T    |  T   |  T      XX
XX   T | T | F    |  F   |  F      XX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Section 3: Characterization of formulas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; <<@QUESTION_3>>
#|

For each of the following formulas, determine if they are valid,
satisfiable, unsatisfiable, or falsifiable. These labels can
overlap (e.g. formulas can be both satisfiable and valid), so
keep that in mind and indicate all characterizations that
apply. In fact, exactly two characterizations always
apply. (Think about why that is the case.) Provide proofs of your
characterizations, using a truth table or simplification
argument (for valid or unsatisfiable formulas) or by exhibiting
assignments that show satisfiability or falsifiability.

(A) p =  (q => (p => p))

....

(B) (p => q) <> (~q  /\ p)

....

(C) (((false /\ ~p) \/ p) => p)

....

(D) [(~(p /\ q) \/ r) /\ (~p \/ ~q \/ ~r)] <> (p /\ q)

....

(E) ~(p => ~q \/ q)

|#


#|
  
  Answers:

 XX (A) Resolves to p = t, thus satisfiable (p = t, q = anything) and falsifiable (q is nil) XX
 XX (B) satisfiable and valid (RHS <> ~LHS and thus true) XX
 XX note the RHS = ~(~p \/ q) = ~(p=>q) XX
    Proof: 
    (p => q) <> (~q  /\ p)
    = {Def implies}
    (~p \/ q) <> (~q /\ p)
    = {DeMorgan's Law}
    ~(p /\ ~q) <> (~q /\ p)
    = {p <>~p = T}
    true
 XX (C) false /\ ~p = false, false \/ p = p and thus we have p=>p which is true. XX
 XX     Thus satisfiable and valid. XX
 XX (D) De Morgan's and distributive gives ~(p/\q) <> p /\ q.  Thus valid and satisfiable XX
 XX     Proof XX
 XX     ([(~(p /\ q) \/ r) /\ (~p \/ ~q \/ ~r)] <> (p /\ q) XX
 XX     = {DeMorgan's, Distributive}XX
 XX     (~p \/ ~q)\/ (r/\~r) <> (p/\ q) XX
 XX     = {Complement, annihilator, DeMorgan's} XX
 XX     ~(p/\q) <> (p/\q) XX
 XX     = {p<>~p = true} XX
 XX     true
 
 XX (E) Equivalent to ~(p=>true) or false.  Thus unsatisfiable and falsifiable. XX
 XX     Proof XX
 XX     ~(p => ~q \/ q) XX
 XX     = {complement} XX
 XX     ~(p => true) XX
 XX     = {p=>true = true, negation} XX
 XX     false
|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECTION 4: A logical equivalence solver

Two propositional expressions are equivalent if they have the
same truth tables. 

Define the functions below so that two arbitrary propositional
expressions are evaluated for all possible assignments. If the
two expressions do not evaluate to the same result for some
assignment, then stop.  Otherwise test the next assignment.

For example Expression 

X: (A => (B => C)) 

and Expression 

Y: (A /\ D) 

have 4 variables (A,B,C,D) and there are 16 assignments. 

Example: For Formula 1: (A => B) and Formula 2: (~A \/ B), you need 
to evaluate 4 different  assignments (4 rows in the truth tables).  
AB: FF FT TF TT.  Formula 1 and formula 2 both return T T F T and 
thus your function "equal-expressions" returns t.  

(equal-expressions '(A => B) '((~ A) <> B)) returns nil

since A=>B evaluates to T T nil T and ~A <> B evaluates to T nil nil T

For this exercise, some pre-generated code and definitions are provided.  
This code should *not* be modified.  You will use these functions in the 
functions you write. The constants used in testing can be modified or
added to.

NOTE: If your functions do not get automatically admitted in ACL2s, 
refer to section 2.17 of the lecture notes and use the
(set-defunc-...) forms described there. If your code is correct,
you will get full credit.  Don't spend time trying to get ACL2s
to admit your functions. Right now, you don't know how to do that
effectively.

If you define a recursive function based on a recursive data
definition, use the template that the data definition gives rise
to. Read Section 2.15 of the lecture notes and make sure to at
least read up to the bottom of page 25.  Notice that in the
definition of foo in the lecture notes, you have two recursive
calls in a single cond branch, due to the PropEx data definition.

|#
;; <<@QUESTION_4>>

(defdata UnaryOp '~)

; BinaryOp: '^ means "and", 'v means "or", '=> means "implies",
; '== means "iff", and <> means xor. 

(defdata BinaryOp (enum '(^ v => == <>)))

; PropEx: A Propositional Expression (PropEx) can be a boolean (t
; or nil), a symbol denoting a variable (e.g. 'p or 'q), or a
; list denoting a unary or binary operation. 
; Note: You COULD do something weird and write an propositional
; expression like '(^ ^ ^) where the first and third symbols are a
; variable....but don't. Having variables be a symbol (rather than 
; an enumerated list of possible names) makes your life
; MUCH easier since ACL2s has an easier time proving your code works.
(defdata PropEx 
  (oneof boolean 
         symbol 
         (list UnaryOp PropEx) 
         (list PropEx BinaryOp PropEx)))

; IGNORE THESE THEOREMS. USED TO HELP ACL2S REASON
(defthm propex-expand1
  (implies (and (propexp x)
                (not (symbolp x)))
           (equal (second x)
                  (acl2::second x))))

(defthm propex-expand2
  (implies (and (propexp x)
                (not (symbolp x))
                (not (equal (first (acl2::double-rewrite x)) '~)))
           (equal (third (acl2::double-rewrite x))
                  (acl2::third (acl2::double-rewrite x)))))

(defthm propex-expand3
  (implies (and (propexp px)
                (consp px)
                (not (unaryopp (first px))))
           (and (equal (third px)
                       (acl2::third px))
                (equal (second px)
                       (acl2::second px))
                (equal (first px)
                       (acl2::first px)))))

(defthm propex-expand2a
  (implies (and (propexp x)
                (not (symbolp x))
                (not (unaryopp (first (acl2::double-rewrite x)))))
           (equal (third (acl2::double-rewrite x))
                  (acl2::third (acl2::double-rewrite x)))))

(defthm propex-lemma2
  (implies (and (propexp x)
                (not (symbolp x))
                (not (equal (first (acl2::double-rewrite x)) '~)))
           (and (propexp (first x))
                (propexp (acl2::first x))
                (propexp (third x))
                (propexp (acl2::third x)))))

(defthm propex-lemma1
  (implies (and (propexp x)
                (not (symbolp x))
                (equal (first (acl2::double-rewrite x)) '~))
           (and (propexp (second x))
                (propexp (acl2::second x)))))


(defthm first-rest-listp
  (implies (and l (listp l))
           (and (equal (first l)
                       (acl2::first l))
                (equal (rest l)
                       (acl2::rest l)))))

; END IGNORE
;; <<@QUESTION_4B>>
; A list of prop-vars (symbols)
(defdata Lopv (listof symbol))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; add: All x List -> List
;; (add a X) conses element a to list
;; X if and only if a is not in X
;; You can use the function in.
(defunc add (a X)
  ;; SOLUTION
  :input-contract (listp X)
  :output-contract (listp (add a X))
  (if (in a X)
    X
    (cons a X)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IMPROVE (Modify the input and ouput contracts to use different
;;          recognizers. The function signature can change. 
;;          Do not change the function body)
;; get-vars: PropEx List -> List ;; SOLUTION PropEx x Los -> Los
;; get-vars returns a list of variables appearing in px OR
;;   in the provided accumulator acc. If acc has
;;   no duplicates in it, then the returned list should not have
;;   any duplicates either. See the check='s below.
;; NOTICE: the way you traverse px for get-vars will be how you traverse
;; expressions in later functions you will write.
(defunc get-vars (px acc)
  :input-contract (and (PropExp px) (Lopvp acc));:input-contract (and (PropExp px) (listp acc))
  :output-contract (Lopvp (get-vars px acc));;:output-contract (listp (get-vars px acc))
  (cond ((booleanp px) acc)
        ((atom px) (add px acc))
        ((UnaryOpp (first px)) (get-vars (second px) acc))
        (t (get-vars (third px)
                     (get-vars (first px) acc)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; del: Any x list -> list
;; Del removes the first instance of an element e in list l
(defunc del (e l)
  :input-contract (listp l)
  :output-contract (listp (del e l))
  (cond ((endp l) l)
        ((equal e (first l)) (rest l))
        (t (cons (first l) (del e (rest l))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; perm: list x list -> boolean
;; We define perm (permutation) to make the tests more robust. 
;; Otherwise, some of the tests below may fail because the order 
;; in which variables appear does not matter. Recall lab 2 for 
;; potentially useful built-in functions
(defunc perm (a b)
  ;; SOLUTION
  :input-contract (and (listp a) (listp b))
  :output-contract (booleanp (perm a b))
  (cond ((endp a) (endp b))
        ((endp b) nil)
        (t (and (in (first a) b)
                (perm (rest a) (del (first a) b))))))



(check= (perm (get-vars 'A '()) '(A)) t)
(check= (perm (get-vars 'A '(B C)) '(A B C)) t)
(check= (perm (get-vars '(A ^ B) '()) '(B A)) t)
(check= (perm (get-vars '(B ^ A) '()) '(B A)) t)
;; SOLUTION: add your own tests.
(check= (perm (get-vars '((A ^ B) ^ (C v D)) '()) '(D C B A)) t)
(check= (perm (get-vars '(A ^ (B v A)) '()) '(B A)) t)
(check= (perm (get-vars '(A ^ (B v A)) '(B)) '(A B)) t)
(check= (perm (get-vars T '(H)) '(H)) t)
(test? (implies (and (listp p) (listp q)(listp r))
                (perm (app (app p q) r) (app (app r q) p))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; update: PropEx x Symbol x Boolean -> PropEx
;; The update function "updates a variable" by replacing all instances
;; of the variable with the boolean val in the expression px.
;; Use the template propex gives rise to, as per the lecture notes.
;; Look at get-vars (above).
(defunc update (px name val)
  ;; SOLUTION
  :input-contract (and (PropExp px) (symbolp name) (booleanp val))
  :output-contract (Propexp (update px name val))
  (cond ((booleanp px) px)
        ((atom px)
         (if (equal px name) val px))
        ((UnaryOpp (first px))
         (list '~ (update (second px) name val)))
        (t (list (update (first px) name val)
                 (second px)
                 (update (third px) name val)))))

(check= (update T 'A NIL) T)
(check= (update NIL 'A T) NIL)
(check= (update 'A 'B T) 'A)
(check= (update 'A 'A NIL) NIL)
(check= (update '((NIL v A) ^ (~ B)) 'A T) '((NIL v T) ^ (~ B)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; ConstBoolExp: All -> Boolean
;; (ConstBoolExp px) determines if px is a PropEx 
;; with NO symbols / free variables.
(defunc ConstBoolExp (px)
  ;; SOLUTION
  :input-contract t
  :output-contract (booleanp (ConstBoolExp px))
  (and (PropExp px) (equal (get-vars px nil) nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SOLUTION
;; xor: boolean x boolean -> boolean
;; (xor x y) returns true if x or y but not both
;; are true
(defunc xor (x y)
  :input-contract (and (booleanp x)(booleanp y))
  :output-contract (booleanp (xor x y))
  (if x (not y) y))

;; <<@QUESTION_4C>>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; beval: PropEx -> Booleanp
;; beval evaluates a constant boolean expression and return its value.  
;; A constant boolean expression is a PropEx with no variables, 
;; just booleans and operators. If this expression has variables, then
;; return nil. You may have to define helper functions to evaluate
;; your expressions.
(defunc beval (bx)
  :input-contract (PropExp bx)
  :output-contract (Booleanp (beval bx))
  ;; SOLUTION
  (cond ((not (ConstBoolExp bx)) nil)
        ((booleanp bx) bx)
        ((atom bx) t)
        ((equal (first bx) '~)
         (not (beval (second bx))))
        ((equal (second bx) '^)
         (and (beval (first bx)) (beval (third bx))))
        ((equal (second bx) 'v)
         (or (beval (first bx)) (beval (third bx))))
        ((equal (second bx) '=>)
         (implies (beval (first bx)) (beval (third bx))))
        ((equal (second bx) '==)
         (iff (beval (first bx)) (beval (third bx))))
        (t
         (xor (beval (first bx)) (beval (third bx))))))

(check= (beval T) T)
(check= (beval NIL) NIL)
(check= (beval '(T ^ NIL)) NIL)
(check= (beval '(T ^ T)) T)
(check= (beval '(T v NIL)) T)
(check= (beval '(~ T)) NIL)
;; SOLUTION: Additional Checks
(check= (beval '(NIL <> T)) T)
(check= (beval '((NIL ^ (~ NIL)) v NIL)) NIL)
(check= (beval '((T ^ (~ NIL)) v T)) T)
(check= (beval '((NIL ^ (~ NIL)) v T)) T)
(check= (beval '(T == NIL)) NIL)
(check= (beval '(T == T)) T)
(check= (beval '(NIL == NIL)) T)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; cbe-listp: lopxpair -> boolean
;; (cbe-listp l) takes a list of propositional
;; expression pairs l and tests each PropEx
;; in the list whether it is a constant boolean
;; expression (CBE). This is useful for testing.
(defunc cbe-listp (l)
  :input-contract (lopxpairp l)
  :output-contract (booleanp (cbe-listp l))
  (cond ((endp l) t)
        ((and (ConstBoolExp (first (first l)))
              (ConstBoolExp (second (first l))))
                  (cbe-listp (rest l)))
        (t        nil)))

(check= (cbe-listp nil) t)

(check= (cbe-listp '((t nil))) t)
(check= (cbe-listp '((t nil)
                     ((~ nil)(nil ^ t)))) t)
(check= (cbe-listp '((t nil)
                     ((~ nil)(a ^ t)))) nil)

;; GIVEN  a list of boolean expression PAIRS that can be evaluated.
(defdata px-pair (list PropEx PropEx))
;; DEFINE a list of px-pairs.
(defdata lopxpair (listof px-pair))



#|
 Comparing Propositional Expressions:
 When comparing propositional expressions p1 and p2.
 1) Find all the variables in both expressions
 2) methodically replace variables with a boolean and 
 do this for all possible t/nil replacement combinations
 (this is like generating a truth table).
 3) for each set of variable substitutions, the substituted 
 p1 and p2 form a pair of constant boolean expressions (CBE).
 4) call beval on pairs of constant boolean expressions until
    there are two evaluations which are not equal or you evaluate
    all pairs.
 If all pairs are equivalent, then p1 and p2 are logically equivalent
|#
;; <<@QUESTION_5>>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; equal_px_pair: px-pair -> boolean
;; (equal_px_pair pair) takes a px-pair
;; and returns true iff beval returns
;; the same value for both expressions in the pair
(defunc equal_px_pair (pair)
  :input-contract (px-pairp pair)
  :output-contract (booleanp (equal_px_pair pair))
  ;; SOLUTION
  (equal (beval (first pair))(beval (second pair))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; equal_pxp_list: lopxpair -> boolean
;; (equal_pxp_list pxl) takes a list of px pairs (pxl)
;; and returns true if and only if each px pair is
;; considered equivalent
(defunc equal_pxp_list (pxl)
  :input-contract (lopxpairp pxl)
  :output-contract (booleanp (equal_pxp_list pxl))
  (cond ((endp pxl)                  t)
        ((equal_px_pair (first pxl)) (equal_pxp_list (rest pxl)))
        (t                           nil)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; gen_vars_list: PropEx x PropEx -> Lopv
;; (gen_vars_list px1 px2) returns a list of all 
;; variables from px1 and px2. There are no duplicats
;; in the returned list.
(defunc gen_vars_list (px1 px2)
  ;; SOLUTION
  :input-contract (and (PropExp px1) (PropExp px2))
  :output-contract (Lopvp (gen_vars_list px1 px2))
  (get-vars px2 (get-vars px1 nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; gen_cbe_pairs_list: PropEx x PropEx x Lopv -> lopxpairp
;; (gen_cbe_pairs_list px1 px2 vars) takes two 
;; propositional expressions p1 and p2.  
;; For each variable in the list of variables vars, replace
;; it with t or nil in both px1 an px2. Recurse until vars is empty
;; and (hopefully) you have constant boolean expressions (CBE) based 
;; on px1 and px2. 
;; You need to do all combinations of t/nil. How might
;; you do that? If you get stuck, start with only replacing variables
;; with t. Can you also substitute for nil? How can you combine these
;; lists?
;; Form a pair of cbes for each variable substitution and return the
;; list of all such pairs.
(defunc gen_cbe_pairs_list (px1 px2 vars)
  ;; SOLUTION
  :input-contract (and (PropExp px1) (PropExp px2) (Lopvp vars))
  :output-contract (lopxpairp (gen_cbe_pairs_list px1 px2 vars))
  (if (endp vars) 
    (list (list px1 px2))
    (let ((px1T (update px1 (first vars) 'T))
          (px2T (update px2 (first vars) 'T))
          (px1NIL (update px1 (first vars) 'NIL))
          (px2NIL (update px2 (first vars) 'NIL)))
      (app (gen_cbe_pairs_list px1T px2T (rest vars))
           (gen_cbe_pairs_list px1NIL px2NIL (rest vars))))))


;; Test constants you can modify or add to. Giant expressions with > 4
;; variables may be too slow to run.
(defconst *pxtest1* 'A)
(defconst *pxtest2* '(A ^ (B v A)))
(defconst *pxtest3* '((A ^ B) ^ (C v D)))
(defconst *pxtest4* '(A => (A <> A)))
(defconst *pxtest5* '(~ T))
(defconst *pxtest6* T)
(defconst *pxtest7* '(~ A))

(check= (gen_cbe_pairs_list *pxtest2* *pxtest4* '(A B))
        (list (list '(t ^ (t v t)) '(t => (t <> t)))
              (list '(t ^ (nil v t)) '(t => (t <> t)))
              (list '(nil ^ (t v nil)) '(nil => (nil <> nil)))
              (list '(nil ^ (nil v nil)) '(nil => (nil <> nil)))))

;; Write a test? that checks whether gen_cbe_pairs_list truly
;; creates pairs of constant boolean expressions given
;; arbitrary propositional expressions.
;; SOLUTION
(test? (implies (and (PropExp px1) (PropExp px2))
                (cbe-listp (gen_cbe_pairs_list px1 px2 
                                               (gen_vars_list px1 px2)))))

(check= (gen_cbe_pairs_list *pxtest4* *pxtest5* '(A))
        (list (list '(t => (t <> t)) '(~ t))
              (list '(nil => (nil <> nil)) '(~ t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; equal-expressions: PropEx x PropEx -> Boolean
;; (equal-expressions takes two propositional expressions
;; and returns true if they are logically equivalent. This is the
;; function you should call from the REPL. This should be a one
;; line (for the body) non-recursive function.
(defunc equal-expressions (px1 px2)
  ;; SOLUTION
  :input-contract (and (PropExp px1)(PropExp px2))
  :output-contract (booleanp (equal-expressions px1 px2))
  (equal_pxp_list (gen_cbe_pairs_list px1 px2 (gen_vars_list px1 px2)))) 

(check= (equal-expressions *pxtest1* *pxtest2*) t)
(check= (equal-expressions *pxtest2* *pxtest3*) nil)
(check= (equal-expressions *pxtest1* *pxtest7*) nil)
(check= (equal-expressions *pxtest4* *pxtest7*) t)
