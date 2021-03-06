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

Names of ALL group members: Nihaal Korandla, Caden Shelman, Changzong Liu







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


Names of ALL group members: Nihaal Korandla, Caden Shelman, Changzong Liu

Note: There will be a 10 pt penalty if your names do not follow 
this format.

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

You should also use test? for your tests.  It takes the form
(test? (implies hyp concl)) 
such as:
(test? (implies (and (listp l)(natp n)) (<= (len (sublist-start n)) n))) 

|#


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Propositional Logic
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
subexpressions. (with one exception: you can omit basic negations such as 
~p or ~r).

For example, if your formula is

(p => q) \/ r

your table should have 5 columns: for p, q, r, p => q, and (p => q) \/ r .

Then decide whether the formula is satisfiable, unsatisfiable, valid, or
falsifiable (more than one of these predicates will hold!). 


1. ~(p /\ q) = q => p

p    q    (p / \q)    ~(p /\ q)    q => p     ~(p /\ q) = q => p
F    F    F           T            T          T
T    F    F           T            T          T
F    T    F           T            F          F
T    T    T           F            T          F

2. (p => q) /\ (~r = ~q) <> ~p => r  

p    q    r    (p => q)    (~r = ~q)    (p => q) /\ (~r = ~q)    (p => q) /\ (~r = ~q) <> ~p    (p => q) /\ (~r = ~q) <> ~p => r 
F    F    F    T           T            T                        T                              F
F    F    T    T           F            F                        F                              T
F    T    F    T           F            F                        F                              T
F    T    T    T           T            T                        T                              T
T    F    F    F           T            F                        T                              F
T    F    T    F           F            F                        T                              T
T    T    F    T           F            F                        T                              F
T    T    T    T           T            T                        F                              T

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

 = { Commutative }
 ~p <> p \/ (p /\ q)
 
 = { Absorbtive }
 ~p <> p
 
 ={ Annihilator }
 t
 

(b) (p \/ r => ((q /\ ~p) => (~r => r)))

 = { Def of implies }
 (p \/ r => ((q /\ ~p) => r))
 
  = { Def of implies }
 (p \/ r => (~(q /\ ~p) \/ r))
 
  = { Def of implies }
 (~(p \/ r) \/ (~(q /\ ~p) \/ r))
 
  = { Associtive }
 ~(p \/ r) \/ ~(q /\ ~p) \/ r)
  
  = { De Morgan && Distributive }
 ~(p \/ r) \/ ~q \/ p \/ r
        
  = { Distributive }
 ~(p \/ r) \/ ~q \/ (p \/ r)
        
  = { p \/ ~p = t && Def of OR}
  t \/ ~q
  t
          

(c) (p \/ q) /\ ((~p \/ q) /\ ~q))

 = { Distributive }
 (p \/ q) /\ ((~p /\ ~q) \/ (q /\ ~q))
 
 = { De Morgan && q /\ ~q = false }
 (p \/ q) /\ ~(p \/ q) \/ false
 
 = { Def of OR }
 (p \/ q) /\ ~(p \/ q) 
 
 = { p /\ ~p =false }
 false
          

(d) (p /\ ~q /\ r) \/ (p /\ ~q /\ ~ r) \/ (p /\ q /\ r) \/ (p /\ q /\ ~ r)
  = { Associtive }
  (((p /\ ~q) /\ r) \/ ((p /\ ~q) /\ ~ r)) \/ (((p /\ q) /\ r) \/ ((p /\ q) /\ ~ r))
  
  = { Factoring }
 ((p /\ ~q) /\ (r \/ ~r)) \/ ((p /\ q) /\ (r \/ ~r)) 
  = { p \/ ~p = t }
  ((p /\ ~q) /\ t) \/ ((p /\ q) /\ t)
  
  ={ Identity }
  (p /\ ~q) \/ (p /\ q)
  
  = { Factoring }
  p \/ (q /\ ~q)
  
  ={ Identity && q /\ ~q = false }
  p

  
(e) (p = q) => ~(~p <> q)

 = { Def of implies }
 ~(p = q) \/ ~(~p <> q)
 
  = { De Morgan }
 ~((p = q) /\ (~p <> q))
 
  = { XOR = not EQUAL }
 ~((p = q) /\ (p = q))
 
  = { Def of AND }
  ~(p = q)

  = { XOR = not EQUAL }
  p <> q



|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Section 3: Characterization of formulas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

  = { Def of implies }
  p =  (q => (~p \/ p))
  = { Def of implies }
  p =  (~q \/ (~p \/ p))
  = { Identity && ~p \/ p = t }
  p = t
  
  Satisfiable & Falsifiable

(B) (p => q) <> (~ q  /\ p)

p    q    (p => q)    (~ q  /\ p)    (p => q) <> (~ q  /\ p)
0    0    1           0              1
1    0    0           1              1
0    1    1           0              1
1    1    1           0              1
 
 Satisfiable && Valid

(C) (((false /\ ~ p) \/ p) => p)
  = { Def of implies }
  ((false \/ p) => p)
  = { Identity }
  p => p
  = { Def of implies }
  ~p \/ p = t
  
  Satisfiable & Valid

(D) [(~(p /\ q) \/ r) /\ (~p \/ ~q \/ ~ r)] <> (p /\ q)

  = { De Morgan && Associative }
  [((~p \/ ~q) \/ r) /\ ((~p \/ ~q) \/ ~ r)] <> (p /\ q)
  = { Factoring }
  ((~p \/ ~q) /\ (r \/ ~r)) <> (p /\ q)
  = { Identity && r \/ ~r = true}
  (~p \/ ~q) <> (p /\ q)
  = { De Morgan}
  ~(p /\ q) <> (p /\ q)
  = { p XOR ~p = t }
  t
  
  Valid && Satisfiable
  
(E) ~ (p => ~ q \/ q)

p    q    ~ q \/ q    ~ (p => ~ q \/ q)
0    0    1           0
0    1    1           0
1    0    1           0
1    1    1           0

 Unsatisfiable && Falsifiable

|#


#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECTION 4: A logical equivalence solver

Two propositional expressions are equivalent if they have the same 
truth tables, up to variable ordering. Thus if you evaluate all 
variable combinations in both expressions and they evaluate to the 
same thing each time, the expressions are the same.

Define the functions below so that two arbitrary propositional expressions
are evaluated for all possible variable values. If the two expressions do not
have the same result, then stop.  Otherwise test the next set of variable
assignments.

For example Expression X: (A => B => C) and Expression Y: (A /\ D) will be 
evaluated for variables ABCD = TTTT, FTTT, FFTT, FTFT, TFTT, ....
You may assume that variable names are consistent across formulas thus you 
are NOT looking to see if A in formula 1 maps to variable B in formula 2.

NOTE: you will have to do two recursive calls in a single cond branch
(like you probably did in Fundies) based on the PropEx data definition.  
If you don't remember how to do this, review your old notes.  It's also a very 
good idea to work through a number of examples to make sure you 
understand how your code should work BEFORE you begin coding.

Example: For Formula 1: (A=> B) and Formula 2: (~A \/ B), you need 
to evaluate 4 different variable assignments (4 rows in the truth tables).  
AB: FF FT TF TT.  Formula 1 and formula 2 both return T T F T and 
thus your function "equal-expressions" returns t.  
(equal-expressions '(A => B) '((~ A) <> B)) returns nil
since A=>B evaluates to T T nil T and ~A <> B evaluates to T nil nil T

For this exercise, some pre-generated code and definitions are provided.  
This code should *not* be modified.  You will use these functions in the 
functions you write. The constants used in testing can be modified or
added to.

 NOTE: If you get stuck and your functions won't be admitted into ACL2s, 
 you can switch to :program mode for a 5% penalty.
 It is better to pass in something rather than nothing but your code always
 needs to be admissible to avoid getting 0. I made it work in logic mode 
 as I'm sure most of you will be able to. I just want to offer a fallback
 plan since not all these functions are trivially admitted.
 Remember recursive calls should follow the data definitions like they did
 in Fundies.
|#


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

; A list of prop-vars (symbols)
(defdata Lopv (listof symbol))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; add: All x List -> List
;; (add a X) conses element a to list
;; X if and only if a is not in X
(defunc add (a X)
 :input-contract (listp X)
 :output-contract (listp (add a X))
 (if (in a X)
   X
   (cons a X)))
   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IMPROVE (make the IC and OC better)
;; get-vars: PropEx Lopv -> Lopv 
;; get-vars returns a list of variables appearing in px OR
;;   in the provided accumulator acc. If acc has
;;   no duplicates in it, then the returned list should not have
;;   any duplicates either. See the check='s below.
;; NOTICE: the way you traverse px for get-vars will be how you traverse
;; expressions in later functions you will write.
(defunc get-vars (px acc)
  :input-contract (and (PropExp px) (Lopvp acc))
  :output-contract (Lopvp (get-vars px acc))
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; update: PropEx x Symbol x Boolean -> PropEx
;; The update function "updates a variable" by replacing all instances
;; of the variable with the boolean val in the expression px.
;; This is a function that has two recursive calls on a single line.  
;; Look to get-vars (above)
(defunc update (px name val)
  :input-contract (and (PropExp px) (symbolp name) (booleanp val))
  :output-contract (Propexp (update px name val))
  (cond ((booleanp px)         px)
        ((symbolp px)          (if (equal px name) val px))
        ((UnaryOpp (first px)) (list (first px) (update (second px) name val)))
        (t                     (list (update (first px) name val) 
                                     (second px) (update (third px) name val)))))
  
(check= (update T 'A NIL) T)
(check= (update 'A 'A NIL) NIL)
(check= (update (list '~ 'P) 'P NIL) (list '~ NIL))
(check= (update (list 'P '<> (list '~ 'P)) 'P T) (list T '<> (list '~ T)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; ConstBoolExp: All -> Boolean
;; (ConstBoolExp px) determines if px is a PropEx 
;; with NO symbols / free variables.
(defunc ConstBoolExp (px)
  :input-contract t
  :output-contract (booleanp (ConstBoolExp px))
  (if (propExp px)
    (endp (get-vars px '()))
    nil))

(check= (ConstBoolExp NIL) T)
(check= (ConstBoolExp T) T)
(check= (ConstBoolExp 'P) NIL)
(check= (ConstBoolExp (list '~ T)) T)
(check= (ConstBoolExp (list '~ 'P)) NIL)
(check= (ConstBoolExp (list T '^ 'Q)) NIL)


;; HELPER
;; bineval: Boolean x BinaryOp x Boolean -> Boolean
;; bineval evaluates a binary boolean expression given two booleans
;; and a symbol representing a binary operation
(defunc bineval (b1 binop b2)
  :input-contract (and (booleanp b1) (BinaryOpp binop) (booleanp b2))
  :output-contract (booleanp (bineval b1 binop b2))
  (cond ((equal binop '^)  (and b1 b2))
        ((equal binop 'v)  (or b1 b2))
        ((equal binop '=>) (or (not b1) b2))
        ((equal binop '==) (equal b1 b2))
        (t                 (or (and b1 (not b2)) (and (not b1) b2)))))

(check= (bineval T '^ T) T)
(check= (bineval NIL 'v NIL) NIL)
(check= (bineval T '=> NIL) NIL)
(check= (bineval NIL '== NIL) T)
(check= (bineval NIL '<> T) T)

:program

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; beval: PropEx -> Boolean
;; beval evaluates a constant boolean expression and return its value.  
;; A constant boolean expression is a PropEx with no variables, 
;; just booleans and operators. If this expression has variables, then
;; return nil. You may have to define helper functions to evaluate
;; your expressions.
;; (in case you were wondering: admitting the function with an IC
;; of ConstBoolExp is much more difficult. Hence you can just check)
(defunc beval (bx)
  :input-contract (PropExp bx)
  :output-contract (booleanp (beval bx))
  (cond ((not (ConstBoolExp bx)) NIL)
        ((booleanp bx)           bx)
        ((UnaryOpp (first bx))   (not (beval (second bx))))
        (t                       (bineval (beval (first bx)) (second bx) (beval (third bx)))))) 
  
         
(check= (beval T) T)
(check= (beval NIL) NIL)
(check= (beval '(T ^ NIL)) NIL)
(check= (beval '(T ^ T)) T)
(check= (beval '(T v NIL)) T)
(check= (beval '(~ T)) NIL)

:logic

;; GIVEN  a list of boolean expression PAIRS that can be evaluated.
(defdata px-pair (list PropEx PropEx))
;; DEFINE a list of px-pairs.
(defdata lopxpair (listof px-pair))

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
  (equal (beval (first pair)) (beval (second pair))))

(check= (equal_px_pair (list T T)) T)
(check= (equal_px_pair (list T NIL)) NIL)
(check= (equal_px_pair (list (list '~ NIL) (list T 'v NIL))) T)
(check= (equal_px_pair (list (list T '=> NIL) (list NIL '== NIL))) NIL)

    
  
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
  :input-contract (and (PropExp px1) (PropExp px2))
  :output-contract (Lopvp (gen_vars_list px1 px2))
  (get-vars px1 (get-vars px2 '())))

(check= (gen_vars_list T T) NIL)
(check= (gen_vars_list T (list '~ T)) NIL)
(check= (gen_vars_list (list 'P '^ 'P) (list 'Q '== NIL)) '(P Q))
(check= (gen_vars_list (list 'P '^ (list '~ 'Z)) (list 'Z 'v T)) '(P Z))
         
;; gen_lopxpair_1var: lopxpair x Symbol -> lopxpair
;; takes a list of propex pairs and one variable and returns a new list (2x size)
;; with half of the pairs replaced with the variable = true and the other
;; half replaced with nil
(defunc gen_lopxpair_1var (lst var)
  :input-contract (and (lopxpairp lst) (symbolp var))
  :output-contract (lopxpairp (gen_lopxpair_1var lst var))
  (cond ((endp lst) '())
        (t          (app (list (list (update (first (first lst)) var T) 
                                     (update (second (first lst)) var T))
                               (list (update (first (first lst)) var NIL) 
                                     (update (second (first lst)) var NIL)))
                         (gen_lopxpair_1var (rest lst) var)))))

(check= (gen_lopxpair_1var '() 'Q) '())
(check= (gen_lopxpair_1var (list '(Q Q)) 'Q) '((T T) (NIL NIL)))
(check= (gen_lopxpair_1var (list '(P Q) '(Q P)) 'Q) (list '(P T) '(P NIL)
                                                          '(T P) '(NIL P)))
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; gen_cbe_pairs_list: PropEx x PropEx x Lopv -> lopxpair
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
  :input-contract (and (PropExp px1) (PropExp px2) (Lopvp vars))
  :output-contract (lopxpairp (gen_cbe_pairs_list px1 px2 vars))
  (cond ((endp vars)        (list (list px1 px2)))
        (t                  (gen_lopxpair_1var (gen_cbe_pairs_list px1 px2 (rest vars)) 
                                               (first vars)))))

  
;; Test constants you can modify or add to. Giant expressions with > 4
;; variables may be too slow to run.
(defconst *pxtest1* 'A)
(defconst *pxtest2* '(A ^ (B v A)))
(defconst *pxtest3* '((A ^ B) ^ (C v D)))
(defconst *pxtest4* '(A => (A <> A)))
(defconst *pxtest5* '(~ T))
(defconst *pxtest6* T)
(defconst *pxtest7* '(~ A))

(check= (perm (gen_cbe_pairs_list *pxtest2* *pxtest4* '(A B))
              (list (list '(t ^ (t v t)) '(t => (t <> t)))
                    (list '(t ^ (nil v t)) '(t => (t <> t)))
                    (list '(nil ^ (t v nil)) '(nil => (nil <> nil)))
                    (list '(nil ^ (nil v nil)) '(nil => (nil <> nil))))) T)
(check= (perm (gen_cbe_pairs_list *pxtest3* *pxtest4* '(A))
              '((((T ^ B) ^ (C V D)) (T => (T <> T)))
                (((NIL ^ B) ^ (C V D))
                 (NIL => (NIL <> NIL))))) T)

;; Write a test? that checks whether gen_cbe_pairs_list truly
;; creates pairs of constant boolean expressions given
;; arbitrary propositional expressions.
(test? (implies (and (PropExp px1)
                     (PropExp px2))
                     (equal (cbe-listp (gen_cbe_pairs_list 
                                        px1 px2 (gen_vars_list px1 px2)))
                            T)))

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
  :input-contract (and (PropExp px1) (PropExp px2))
  :output-contract (booleanp (equal-expressions px1 px2))
  (equal_pxp_list (gen_cbe_pairs_list px1 px2 (gen_vars_list px1 px2))))
  
(check= (equal-expressions *pxtest1* *pxtest2*) t)
(check= (equal-expressions *pxtest2* *pxtest3*) nil)
(check= (equal-expressions *pxtest1* *pxtest7*) nil)
(check= (equal-expressions *pxtest4* *pxtest7*) t)#|ACL2s-ToDo-Line|#
