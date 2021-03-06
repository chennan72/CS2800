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

CS 2800 Homework 2 - Spring 2017

This homework is done in groups. More elaborate instructions will be 
posted on the course website soon:

 * One group member will create a group in BlackBoard.
 
 * Other group members then join the group.
 
 * Homework is submitted once. Therefore make sure the person
   submitting actually does so. In previous terms when everyone needed
   to submit we regularly had one person forget but the other submissions
   meant the team did not get a zero. Now if you forget, your team gets 0.
   - It wouldn't be a bad idea for groups to email confirmation messages
     to each other to reduce anxiety.

 * Submit the homework file (this file) on Blackboard.  Do not rename 
   this file.  There will be a 10 point penalty for this.

 * You must list the names of ALL group members below, using the given
   format. This way we can confirm group membership with the BB groups.
   If you fail to follow these instructions, it costs us time and
   it will cost you points, so please read carefully.

The format should be: FirstName1 LastName1, FirstName2 LastName2, ...
For example:
Names of ALL group members: David Sprague, Peizun Liu

There will be a 10 pt penalty if your names do not follow this format.
Names of ALL group members: ...

* Later in the term if you want to change groups, the person who created
  the group should stay in the group. Other people can leave and create 
  other groups or change memberships (the Axel Rose membership clause). 
  We will post additional instructions about this later.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw02.lisp

- make sure you are in BEGINNER mode. This is essential! Note that you can
  only change the mode when the session is not running, so set the correct
  mode before starting the session.

- insert your solutions into this file where indicated (usually as "...")

- only add to the file. Do not remove or comment out anything pre-existing.

- make sure the entire file is accepted by ACL2s. In particular, there must
  be no "..." left in the code. If you don't finish all problems, comment
  the unfinished ones out. Comments should also be used for any English
  text that you may add. This file already contains many comments, so you
  can see what the syntax is.

- when done, save your file and submit it as hw02.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file.

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

|#

#|

Since this is our first programming exercise, we will simplify the
interaction with ACL2s somewhat: instead of asking it to formally *prove*
the various conditions for admitting a function, we will just require that
they be *tested* on a reasonable number of inputs. This is achieved using
the following directive (do not remove it!):

|#
:program
#|ACL2s-ToDo-Line|#

#|

Notes:

1. Testing is cheaper but less powerful than proving. So, by turning off
proving and doing only testing, it is possible that the functions we are
defining cause runtime errors even if called on valid inputs. In the future
we will require functions complete with admission proofs, i.e. without the
above directive. For this first homework, the functions are simple enough
that there is a good chance ACL2s's testing will catch any contract or
termination errors you may have.

2. The tests ACL2s runs test only the conditions for admitting the
function. They do not test for "functional correctness", i.e. does the
function do what it is supposed to do? ACL2s has no way of telling what
your function is supposed to do. That is what your own tests are for.

3. For now testing is written using check= expressions.  These take the following
format (and should be familiar to those of you that took Fundies I)
(check= <expression> <thing it should be equal to>)
EX: (check= (- 4/3 1) 1/3)

|#

#|
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 Part I:
 The functions below should warm you up for the rest of the 
 assignment.
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; Define
 ;; TriXOR: Bool x Bool x Bool -> Bool
 ;;
 ;; (TriXOR x y z) takes three booleans x y and z and returns true if and
 ;; only if exactly 1 of the variables is true. This is XOR applied
 ;; to three variables.
 (defunc TriXOR (x y z)
   ;; SOLUTION
   :input-contract (and (booleanp x)(booleanp y)(booleanp z))
   :output-contract (booleanp (TriXOR x y z))
   (if (and x (not y)(not z))
     t
     (if (and (not x) y (not z))
       t
       (if (and (not x)(not y) z)
         t
         nil))))
 
 ;; Note: A cond, rather than a set of nested if statements, would
 ;; also work for TriXOR. Throughout the rest of the solutions, I will
 ;; use cond statements BUT nested ifs are equally correct.
 ;;   (cond ((and x (not y)(not z))  t)
 ;;         ((and (not x) y (not z)) t)
 ;;         ((and (not x)(not y) z)  t)
 ;;         (t                     nil))

(check= (TriXOR t t nil) nil)
(check= (TriXOR nil t nil) t)
;; Additional checks needed
;; SOLUTION
(check= (TriXOR nil nil nil) nil)
(check= (TriXOR t t t) nil)
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define
;; how-many: All x List -> Nat
;;
;; (how-many e l) returns the number of occurrences of element e 
;; in list l.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc how-many (e l)
  ;;SOLUTION
  :input-contract (listp l)
  :output-contract (natp (how-many e l))
  (if (endp l)
    0
    (+ (if (equal e (first l)) 1 0)
       (how-many e (rest l)))))

(check= (how-many  1 ())     0)
(check= (how-many  1 '(1 1)) 2)
;; Add additional tests


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; same-multiplicity: List x List x List -> Boolean
;
; (same-multiplicity l l1 l2) returns t iff every element of l occurs in l1
; and l2 the same number of times.
; REMEMBER: you can ALWAYS use functions from earlier in the 
; program.  The functions were given in this order for a reason.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc same-multiplicity (l l1 l2)
  ;; SOLUTION
  :input-contract (and (listp l) (and (listp l1) (listp l2)))
  :output-contract (booleanp (same-multiplicity l l1 l2))
  (if (endp l)
    t
    (and (equal (how-many (first l) l1)
                (how-many (first l) l2))
         (same-multiplicity (rest l) l1 l2))))

(check= (same-multiplicity '(1)   '(2 1 3) '(1 2 2)) t)
(check= (same-multiplicity '(1 2) '(2 1 3) '(1 2 2)) nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flat-listp
;; flat-listp: Any -> Boolean
;;
;; (flat-list l) takes an input l and returns true if and only if
;; l is a list AND each element in l is not a list. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc flat-listp (l)
  ;; SOLUTION
  :input-contract t
  :output-contract (booleanp (flat-listp l))
  (cond ((not (listp l))                    nil)
         ((endp l)                             t)
         ((listp (first l))                  nil)
         (t                (flat-listp (rest l)))))

(check= (flat-listp '(1 2 (3))) nil)
(check= (flat-listp '(1 2 3)) t)
;; Make sure you add additional tests
;; SOLUTION
(check= (flat-listp nil) t)
(check= (flat-listp '(nil)) nil)
(check= (flat-listp '(1 2 a)) t)
(check= (flat-listp '(1 2 nil)) nil)
(check= (flat-listp 3) nil)
(test? (implies (and (listp l1)(listp l2)) (not (flat-listp (cons l1 l2)))))

#|
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 Part II: List manipulation
 This following section deals with functions involving lists in general.
 Some functions you write may be useful in subsequent functions.
 In all cases, you can define your own helper functions if that simplifies
 your coding
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; merge-lists
;; merge-lists: List x List -> List
;;
;; (merge-lists l1 l2) takes two lists l1 and l2 and returns a
;; list with all elements from both alternating between elements in l1
;; and l2....consider it zipping the lists together.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc merge-lists (l1 l2)
  ;; SOLUTION
  :input-contract (and (listp l1)(listp l2))
  :output-contract (listp (merge-lists l1 l2))
  (cond ((endp l1)                       l2)
        ((endp l2)                       l1)
        (t        (cons (first l1)
                        (cons (first l2)
                              (merge-lists (rest l1)
                                           (rest l2)))))))

(check= (merge-lists '(a b c d) '(1 2 3 4 5))
        '(a 1 b 2 c 3 d 4 5))
;; SOLUTION
(check= (merge-lists '(a b c d) nil) '(a b c d))
(check= (merge-lists nil '(a b c d)) '(a b c d))
(test? (implies (listp l) (equal l (merge-lists nil l))))
(test? (implies (listp l) (equal l (merge-lists l nil))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flatten-list
;; flatten-list: List -> List (a flat list)
;;
;; (flatten-list l) takes an input list l and creates a new list
;; with all the same atomic elements (excluding nil) in l but the new list
;; has no sub-lists.
;; HINT: this may be a complex function for many of you. Let's pretend
;; (first l) is a list. What happens if I append (first l) to (rest l)?? 
;; Can I call flatten-list again on this new list? Am I guaranteed
;; to stop recursing?
;; When can I NOT call app?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc flatten-list (l)
  :input-contract (listp l)
  :output-contract (flat-listp (flatten-list l))
  ;; SOLUTION (students can use a cond but we may not have discussed conds in
  ;; class by this due date).
  (if (endp l)
    l
    (if (listp (first l))
      (flatten-list (app (first l) (rest l)))
      (cons (first l) (flatten-list (rest l))))))

;; -- Cond solution --
;; (cond (((endp l)          l)
;;        ((listp (first l)) (flatten-list (app (first l) (rest l))))
;;        (t                 (cons (first l)(flatten-list (rest l))))))
 
(check= (flatten-list '((1 2 3) nil 4 (5 6))) '(1 2 3 4 5 6))
; Add additional tests.
(check= (flatten-list nil) nil)
(check= (flatten-list '(1 2 3 4)) '(1 2 3 4))
(check= (flatten-list '(1 (2 (3 (4))))) '(1 2 3 4))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wrap-elements: List -> List
;;
;; (wrap-elements l) takes an input list l and creates a new list
;; with all elements of l put into list of size 1 (hence each element
;; of l is wrapped in a list in the returned list. See the check=
;; tests below for illustrative examples
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc wrap-elements (l)
  :input-contract (listp l)
  :output-contract (listp (wrap-elements l))
  ;; SOLUTION
  (if (endp l)
    l
    (cons (list (first l)) (wrap-elements (rest l)))))

(check= (wrap-elements '(1 2 3)) '((1) (2) (3)))
(check= (wrap-elements '(1 2 (3))) '((1) (2) ((3))))

; Additional tests
;; SOLUTION:
(check= (wrap-elements '((1 2) (3 4))) '(((1 2)) ((3 4))))
(test? (implies (and (listp l)(not (endp l))) 
                (not (flat-listp (wrap-elements l)))))

(test? (implies (listp l) 
                (flat-listp (flatten-list (wrap-elements l)))))

(test? (implies (and (listp l)(flat-listp l))
                (equal (flatten-list (wrap-elements l)) l)))


#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Part III: Discrete Math Fun
Below are a set of functions that you might find useful later
in the term. These help you do discrete arithmetic like you 
did in CS 1800.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define
;; rem-similar: Nat x Nat-{0} -> Nat
;;
;; (rem-similar x y) returns the remainder of the integer division of 
;; x by y assuming that x and y are relatively the same size.
;; This is a helper method for (rem x y)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc rem-similar (x y)
  :input-contract (and (natp x)(posp y))
  :output-contract (natp (rem-similar x y))
  ;; SOLUTION
  (if (< x y)
    x
    (if (equal y 1)
      0
      (rem-similar (- x y) y))))

(check= (rem-similar 8000000004 2000000000) 4)
;; The check below would be extremely slow using this method of calculating 
;; the remainder
;; (check= (rem-similar 800000 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Define
; rem-smally: Nat x Nat-{0} -> Nat
;
; (rem-smally x y) returns the remainder of the integer division of 
; x by y assuming that y is relatively small compared to x.
; This is a helper method for (rem x y)
(defunc rem-smally (x y)
  :input-contract (and (natp x)(posp y))
  :output-contract (natp (rem-smally x y))
  ;; SOLUTION
  (if (< x y)
    x
    (if (integerp (/ x y))
      0
      (+ 1 (rem-smally (- x 1) y)))))

;; The check below would be extremely slow using this method of calculating 
;; the remainder
;;(check= (rem-smally 8000000004 2000000000) 4)
(check= (rem-smally 800001 2) 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rem: Nat x Nat-{0} -> Nat
;
; (rem x y) returns the remainder of the integral division of x by y.
; There are two ways to calculate the remainder(both use subtraction). 
; Think about what these two ways are.
; Note that for some numbers like x = 100000000 and y =11 one method is better.
; Thus we will make two definitions:
; For x and y being approximately the same size we use rem-similar
; since it is more efficient.
; For small values of y (and arbitrarily large x values), use rem-smally
; Fill in these function above.  If you are curious, try calling
; (rem-smally 5000000000 4999999) and (rem-similar 5000000000 3)
; and see why we need 2 approaches.
(defunc rem (x y)
  :input-contract (and (natp x)(posp y))
  :output-contract (natp (rem x y))
  (if (< y (/ x y))
    (rem-smally x y)
    (rem-similar x y)))
  
(check= (rem 2 4) 2)
(check= (rem 4 2) 0)
(check= (rem 16 1) 0)
(check= (rem 1234567 10) 7)
(check= (rem 123 48) 27)

; Additional Checks
;; XX SOLUTION
(check= (rem 1 16) 1)
(check= (rem 0 1) 0)
(check= (rem 2999 11) 7)
(check= (rem 1234567 93) 85)
(check= (rem 12345677 48777) 5096)
(test? (implies (and (natp x)(posp y)) 
                (equal (rem-smally x y)(rem-similar x y))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nat/: Nat x Nat-{0} -> Nat
;; (nat/ x y) takes a natural number x and a positive integer
;; y and returns x / y rounded down to the nearest natural number
;; HINT: If you want this function to work in logic mode later
;; in the term, how can you do division without using "/"? 
;; (the function / returns a rational and ACL2s can't easily 
;; prove the output is actually a natural number).
;; What is (nat/ 5 2)?  What about (nat/ 7 2)? (nat/ 9 2)?
;; Do you notice a pattern.
(defunc nat/ (x y)
  :input-contract (and (natp x)(posp y))
  :output-contract (natp (nat/ x y))
  ;; SOLUTION
  (if (< x y)
    0
    (+ 1 (nat/ (- x y) y))))

(check= (nat/ 16 3) 5)
(check= (nat/ 16 2) 8)

;; SOLUTION
(check= (nat/ 0 1) 0)
(check= (nat/ 1000 1) 1000)
(check= (nat/ 100002 3) 33334)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; abs: Rationalp -> Rationalp >= 0
;; (abs r) alculates the absolute value of a rational number r
(defunc abs (r)
  :input-contract (rationalp r)
  :output-contract (and (rationalp (abs r))(>= (abs r) 0)) 
  (if (< r 0)
    (unary-- r)
    r))

(check= (abs -3/2) 3/2)
(check= (abs 3/2) 3/2)
(check= (abs -3456778/2) 3456778/2)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; int/: Int x Int-{0} -> Int
;; (int/ x y) takes an integer x and a non-zero integer y
;; and returns x / y rounded down to the nearest integer value if
;; positive and rounded UP if the result is negative.
;; HINT: Do not re-invent the wheel here. Use previous functions.
(defunc int/ (x y)
  ;; SOLUTION
  :input-contract (and (integerp x)(integerp y)
                       (not (equal y 0)))
  :output-contract (integerp (int/ x y))
  (if (or (and (< x 0)(> y 0))
          (and (> x 0)(< y 0)))
    (unary-- (nat/ (abs x) (abs y)))
    (nat/ (abs x)(abs y))))

;; Add additional tests after these
(check= (int/ -5 -4) 1)
(check= (int/ 5 -4) -1)
(check= (int/ 5 -4) -1)
(check= (int/ 5 4) 1)
;; SOLUTION
(check= (int/ 0 -4) 0)
(check= (int/ 1 -4) 0)
(check= (int/ -2 -4) 0)
(check= (int/ -723 -700) 1)

; Additional Checks
(check= (nat/ 1 1) 1)
(check= (nat/ 2 1) 2)
(check= (nat/ 5 2) 2)
(test? (implies (and (natp x) (posp y)) 
                (equal (+ (rem x y) (* (nat/ x y) y)) x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; floor: Rational -> Integer
;;
;; (floor r) returns the closest integer less than rational r 
;; (if r is an integer return r).
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc floor (r)
  :input-contract (rationalp r)
  :output-contract (integerp (floor r))
  (let* ((absnum (abs (numerator r)))
         (posfloor (nat/ absnum (denominator r))))
    (cond ((integerp r)   r)
          ((< (numerator r) 0)         (- (unary-- posfloor) 1))
          (t                           posfloor))))


(check= (floor 4/3) 1)
(check= (floor 3/4) 0)
(check= (floor 2) 2)
(check= (floor -2) -2)
(check= (floor -4/3) -2)
(check= (floor 0) 0)
(check= (floor 24/5) 4)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; round: Rational -> Integer
;;
;; (round r) returns the closest integer to the rational
;; number r. For simplicity sake, any value X.Y should be rounded up
;; (the direction of positive infinity) for Y > 1/2 
;; and rounded down for values of Y <= 1/2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc round (r)
  ;; SOLUTION
  :input-contract (rationalp r)
  :output-contract (integerp (round r))
  (cond ((integerp r) r)
        ((>= 1/2 (- r (floor r))) (floor r))
        (t                        (+ (floor r) 1))))


(check= (round 4/3) 1)
(check= (round -4/3) -1)
(check= (round 5/3) 2)
(check= (round -5/3) -2)

;; Additional Tests
;; SOLUTION
(check= (round 5/2) 2)
(check= (round -5/2) -3)
