
#|

CS 2800 Homework 8 - Spring 2017

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

This homework is to be done in a group of 2-3 students. It is designed
to give you practice with function admissibility and introduce you to
measure functions.

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

For this homework you will NOT need to use ACL2s. However, you could
use the Eclipse/ACL2s text editor to write up your solution.

|#


#|

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Admissible or not?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For each of the definitions below, check whether it is theoretically 
admissible, i.e. it satisfies all rules of the definitional principle. 
You can assume that Rule 1 is met: the symbol used in the defunc is a new 
function symbol in each case.

If you claim admissibility, BRIEFLY

1. Explain in English why the body contracts hold.
2. Explain in English why the contract theorem holds.
3. Suggest a measure function that can be used to show termination.
   (You DO NOT have to prove the measure function properties in this problem.)

Otherwise, identify a rule in the Definitional Principle that is violated.

If you blame one of the purely syntactic rules (variable names,
non-wellformed body etc), explain the violation in English.

If you blame one of the semantic rules (body contract, contract theorem or
termination), you must provide an input that satisfies the input contract, but
causes a violation in the body or violates the output contract or causes
non-termination.

Remember that the rules are not independent: if you claim the function does
not terminate, you must provide an input on which the function runs forever
*without* causing a body contract violation: a body contract violation is
not a counterexample to termination. Similarly, if you claim the function
fails the contract theorem, you must provide an input on which it
terminates and produces a value, which then violates the output contract.

Your explanations should be brief but clear. We are not looking for a page 
of text per question but we also want to clearly see that you understand 
the function and if/what is wrong with it.

I used the term "theoretically admissible" because for some functions below
you can demonstrate they are admissible but ACL2s won't actually admit it 
without a lot of extra guidance from you (this isn't your responsibility).

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SECTION 1: Admissibility
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
1.

(defunc f1 (p)
  :input-contract (posp p)
  :output-contract (posp (f1 p))
  (if (equal p 0)
    0
    (f1 (- p 1))))
    
SOLUTION: body contract violation since (f1 1) lead to 
(f1 0) which doesn't match the input contract. Thus the body
is not well formed. (equal p 0) will never be true thus we don't
have a output contract violation.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
2.

(defunc f2 (a b)
  :input-contract  (and (posp a) (posp b))
  :output-contract (posp (f2 a b))
  (cond ((or (equal a 1) (equal b 1)) 1)
        ((> a b)          (f2 a (- b 1)))
        (t                (f2 b a))))

        
SOLUTION: Not admissible.  When a = b, the function goes
into a infinite loop swapping b and a.  Thus (f2 4 4) would
cause a problem.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
3.

(defunc f3 (x y)
  :input-contract (and (natp x) (posp y))
  :output-contract (natp (f3 x y))
  (cond ((equal y 1) y)
        ((equal x 0) x)
        ((< y x)     (f3 y x))
        (t           (f3 x (- y 1)))))

SOLUTION: Admissible
1) functions <, equal and f3 all match their input contracts.
(f3 y x) might look like it could fail but y < x and thus x is
a positive integer.
2) The contract theorem holds since the two non-recursive calls
return x or y.  The returns from the recursive calls must match
the OC.
3) Measure function:
(defunc m3 (x y)
  :input-contract (and (natp x)(posp y))
  :output-contract (natp (m3 x y))
  (if (< y x)
    (+ (* 2 (+ x y)) 1)
    (* 2 (+ x y))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
4.

(defunc f4 (x y)
  :input-contract (and (listp x) (natp y))
  :output-contract (listp (f4 x y))
  (if (equal y 0)
    (list y)
    (f4 (list (first x)) (- y 1))))

SOLUTION: Not admissible.
We don't check if x is empty.  Thus (first x) can cause a body
contract violation.
(f4 nil 4) causes an error.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
5.

(defunc f5 (z)
  :input-contract (posp z)
  :output-contract (integerp (f5 z))
  (if (equal z 1)
    9
    (- 5 (f5 (- z 1)))))
    
SOLUTION: Admissible
1) equal, - and f5 all pass their input contracts given z and
the if conditions.
2) the contract theorem holds. Subtraction with 5 and an integer
(f5 OC) results in an integer.
3) Measure function:
(defunc m5 (z)
  :input-contract (posp z)
  :output-contract (natp (m5 z))
  z)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
6.

(defunc f6 (i)
  :input-contract (integerp i)
  :output-contract (integerp (f6 i))
  (if (< i -5)
    i
    (f6 (- f6 i))))

SOLUTION: Not admissible. 
f6 is not a variable but it is interpretted as that in
(- f6 i). Thus the body is not well formed.
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
7.

(defunc f7 (x y)
  :input-contract (and (listp x)(natp y))
  :output-contract (natp (f7 x y))
  (cond ((equal y 0) (len x))
        ((endp x)    0)
        (t           (f7 (list y) (len x)))))

SOLUTION: Not admissible.  This is non terminating for the 
following: (f7 '(1) 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
8.

(defunc f8 (x y)
  :input-contract (and (integerp x) (integerp y))
  :output-contract (integerp (f8 x y))
  (if (>= x 0)
    (+ x y)
    (+ (* 2 y) (f8 (+ x 1) (- y 1)))))

SOLUTION: Admissible
1) *, +, >= and f8 are given the correct inputs given f8s IC.
2) Integer + integer results in an integer.  Thus the contract theorem
holds
3) Measure function
This function only recurses when x < 0.
(defunc m8 (x y)
  :input-contract (and (integerp x)(integerp y))
  :output-contract (natp (m8 x y))
  (* x x))
  
If an absolute value function (abs x) is defined, then m8's body can be
(abs x)
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
9.

(defunc f9 (i x i)
  :input-contract (and (integerp i) (listp x) (integerp i))
  :output-contract (posp (f9 i x i))
  (if (endp x)
    0
    (f9 i (rest x) i)))
    
SOLUTION: Not admissible. The input variables are not unique (i).

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
10.

(defunc f10 (x y)
  :input-contract (and (listp x) (listp y))
  :output-contract (posp (f10 x y))
  (if (endp x)
    0
    (f10 x (rest y))))

SOLUTION: Not admissible
There is a body contract violation (body is not well formed)
since (f10 '(a b c) nil) causes (rest nil) to be called.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
11.

(defunc f11 (x n)
  :input-contract (and (listp x) (integerp n))
  :output-contract (listp (f11 x n))
  (if (equal n 0)
    (list n)
    (f11 (cons n (rest x)) (- n 1))))

SOLUTION: Not admissible
Problem 1: The function is non-terminating when x is a cons. 
x never becomes nil because n is always consed on to (rest x) but n
goes to negative infinity.  Thus (f11 '(1 2 3) -1) causes an infinite loop.
Problem 2: There is a body contract violation when x is nil due to (rest x)
Thus (f11 nil 4) causes an error.

Our rubric will accept either error, however, ACL2s will actually complain
about problem 2 before it attempts to prove termination. Thus problem 2
is technically what stops the function from being admitted.
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
12.

(defunc f12 (p)
  :input-contract (posp p)
  :output-contract (posp (f12 p))
  (if (equal p 1)
      6
    (f12 (- 7 (f12 (- p 1))))))

SOLUTION: Admissible
1) functions equal, f12, and - all have acceptable input 
contracts based on the IC, OC of f12 and the potential values f12
returns.  Essentially, (f12 x) where x > 1 is always 6.
(f12 p) = (f12 (- 7 (f12 (- p 1)))).  If we assume (f12 (- p 1))
is 6 then (f12 (- 7 6) = (f12 1) = 6. Later we can do this as an inductive
proof.
2) The contract theorem holds since f12 always returns 6.
3) The function terminates.
(defunc m12 (p)
  :input-contract (posp p)
  :output-contract (natp (m12 p))
  p)
SOLUTION 2: actually ACL2s won't admit it since
it cannot prove termination. Thus a claim of
non-termination is also acceptable despite being
able to show termination ourselves.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
13.

(defunc f13 (p i)
  :input-contract (and (posp p)(integerp i))
  :output-contract (posp (f13 p i))
  (cond ((equal p 1)   9)
        ((< i 1)       (f13 (- p 1) i))
        (t             (f13 i (- p 2)))))
 
        
 SOLUTION: Admissible
 1) The functions <, f13, and - all have correct input
 2) The contract theorem holds because recurive calls only return
 what the terminating condition returns (9)
 3) It terminates (but notice the weird flipping of i and p when i >= 1):
 (defunc m13 (p i)
   :input-contract (and (posp p)(integerp i))
   :output-contract (natp (m13 p i))
   (+ (* i i) p))
   
 OR
 
  (defunc m13 (p i)
   :input-contract (and (posp p)(integerp i))
   :output-contract (natp (m13 p i))
   (if (<= i 0) p (+ i p)))
   
 OR (+ (abs i) p) would work.
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

14.

(defunc f14 (x y)
  :input-contract  (and (posp x) (posp y))
  :output-contract (posp (f14 x y))
  (cond ((equal x y)    1)
        ((> x y)        (f14 y x))
        (t              (f14 (- x y) y))))


SOLUTION: Not Admissible
Cond3 has y > x so (- x y) is negative. Contract violation.
(f14 2 5)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
15.

(defunc f15 (x y)
  :input-contract (and (posp x) (posp y))
  :output-contract (integerp (f15 x y))
  (cond ((< x 1)     (f15 x y))
        ((equal x y) 5)
        ((< x y)     (f15 y x))
        (t           (* 5 (f15 (- x 1) y)))))

SOLUTION: Admissible
1) Functions <, equal, f15, -, * all have appropriate input
2) The contract theorem holds given that the recursive calls
return an integer and the 4th condition is the multiplication
of two integers.  Notice the dead code condition (x < 1) will
never be called.
3) Finally the function terminates.
(defunc m15 (x y)
  :input-contract (and (posp x)(posp y))
  :output-contract (natp (m15 x y))
  (if (< x y)
    (+ 1 y)
    x))
Notice: (abs (- x y)) will NOT work because the step required to
flip x and y isn't taken into account.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

16.

(defunc f16 (x y)
  :input-contract (and (listp x) (natp y))
  :output-contract (listp (f16 x y))
  (cond ((equal y 0)  (f16 x (len x)))
        ((endp x)     (list y))
        (t            (f16 (rest x) (- y 1)))))
  
SOLUTION: Not admissible. Condition 1 causes a problem.
(f16 nil 0) would result in a recursive call to (f16 x (len x))
which is the same function call.  Thus there is an infinite loop.
Switching conditions 1 and 2 would solve this problem.
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

17.

(defunc  f17 (l)
  :input-contract (listp l)
  :output-contract (booleanp (f17 l))
  (cond ((endp l)  l)
        ((in e l)  t)
        (t         (cons (first l)(f17 (rest l))))))

SOLUTION: Not admissible
e is a free variable.  Thus the body is not well formed.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SECTION 2: DOES IT TERMINATE?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For each of the following functions, mention whether the function terminates 
;; or not. If it does, give a measure function for it (here we are not asking 
;; you to prove anything). Features of a valid measure function are described
;; in section 3 below and in the notes.
;; If it does not terminate, give a concrete input on which it fails.
;; Here is a function you can use to help you

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; abs: integer -> natural
;; (abs i) takes an integer value
;; and returns the absolute value
;; of that number (thus a natural number)
(defunc abs (i)
  :input-contract (integerp i)
  :output-contract (natp (abs i))
  (if (< i 0) (unary-- i)  i))


#|
(defunc f18 (n)
  :input-contract (natp n)
  :output-contract (integerp (f18 n))
  (if (equal n 0)
    14
    (-  (f18 (- n 1)) (* (* n n) n))))


 SOLUTION: Terminates
 (defunc m18 (n)
   :input-contract (natp n)
   :output-contract (natp (m18 n))
   n)


(defunc  f19 (x)
  :input-contract (integerp x)
  :output-contract (integerp (f19 x))
  (cond ((equal x 0) 1)
        ((> x 0) (* x (f19 (- x 1))))
        (t (* x (f19 (+ x 1))))))

 SOLUTION: terminates
 (defunc m19 (x)
   :input-contract (integerp x)
   :output-contract (natp (m19 x))
   (abs x))

(defunc  f20 (n m)
  :input-contract (and (integerp n)(integerp m))
  :output-contract (integerp (f20 n m))
  (cond ((equal n m)                 1)
        ((< n m)  (f20 (+ n 1)(- m 1)))
        (t             (f20 (- n 1) m))))
        
SOLUTION: terminates
(defunc m20 (n m)
  :input-contract (and (integerp n)(integerp m))
  :output-contract (natp (m20 n m))
  (if (>= n m) (- n m) (+ (- m n) 1)))

  Despite ACL2s not proving termination, m20 should
  prove termination. Also notice we need 1 additional step 
  in the n < m case since we may miss m=n and have to do 
  one additional recursive call.
  

(defunc  f21 (l i)
  :input-contract (and (listp l)(integerp i))
  :output-contract (listp (f21 l i))
  (if (< i 0) 
    l
    (f21 l (- i (len l)))))

SOLUTION: Does not terminate.
(f21 nil 2) causes an infinite loop.  If l is not nil then
termination occurs.

        

(defunc  f22 (l1 l2)
  :input-contract (and (listp l1)(listp l2))
  :output-contract (booleanp (f22 l1 l2))
  (cond ((endp l2)    t)
        ((in (first l2) l1)  (f22 l1 (rest l2)))
        (t    (f22 (cons (first l2) l1) (rest l2)))))

SOLUTION: terminates
(defunc m22 (l1 l2)
  :input-contract (and (listp l1)(listp l2))
  :output-contract (natp (m22 l1 l2))
  (len l2))

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PROVING A MEASURE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|

You can prove a function f terminates using a measure function m. 
This requires the following conditions are met:

Condition 1. m has the same arguments and the same input contract as f.
Condition 2. m's output contract is (natp (m ...))
Condition 3. m is admissible.
Condition 4. On every recursive call of f, given the input contract and 
   the conditions that lead to that call, m applied to the arguments in
   the call is less than m applied to the original inputs.

You should do this proof as shown in class (which is also the way we will
expect you to prove termination on exams):

- Write down the propositional logic formalization of Condition 4.
- Simplify the formula.
- Use equational reasoning to conclude the formula is valid.

Unless clearly stated otherwise, you need to follow these steps for EACH
recursive call separately.

Here is an example.

(defunc f (x y)
  :input-contract (and (listp x) (natp y))
  :output-contract (natp (f x y))
  (if (endp x)
    (if (equal y 0) 
      0
      (+ 1 (f x (- y 1))))
    (+ 1 (f (rest x) y))))

The measure is
(defunc m (x y)
  :input-contract (and (listp x) (natp y))
  :output-contract (natp (m x y))
  (+ (len x) y))


For the first recursive call in f, the propositional logic formalization 
for proving Condition 4 is:
(implies (and (listp x) (natp y) (endp x) (not (equal y 0)))
         (< (m x (- y 1)) (m x y)))

This can be rewritten as:
(implies (and (listp x) (natp y) (endp x) (> y 0))
         (< (m x (- y 1)) (m x y)))
         
Proof of Condition 4 for the first recursive call:
Context
C1. (listp x)
C2. (natp y)
C3. (endp x)
C4. (> y 0)

(m x (- y 1))
= { Def m, C3, Def len, Arithmetic }
(- y 1)
< { Arithmetic }
y
= { Def m, C3, Def. len, Arithmetic }
(m x y)

The propositional logic formalization for Proof of Condition 4 for the 
second recursive call:
(implies (and (listp x) (natp y)(not (endp x)))
         (< (m (rest x) y) (m x y)))

Proof:
C1. (listp x)
C2. (natp y)
C3. (not (endp x))

(m (rest x) y)
= { Def m, C3 }
(+ (len (rest x)) y)
< { Arithmetic, Decreasing len axiom }
(+ (len x) y)
= { Def m }
(m x y)

Hence f terminates, and m is a measure function for it.
QED


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

23. Prove f23 terminates:

(defunc f23 (x y c)
  :input-contract (and (natp x) (posp y) (integerp c))
  :output-contract (integerp (f23 x y c))
  (cond ((and (equal x 0) (equal y 1)) c)
        ((> x 0)                       (f23 (- x 1) y (+ c 1)))
        (t                             (f23 5 (- y 1) c))))

For this question, we are providing a measure function:

(defunc m23 (x y c)
  :input-contract (and (natp x) (posp y) (integerp c))
  :output-contract (natp (m23 x y c))
  (+ x (* 6 y)))

For this question, we are also providing the propositional logic formalization 
for Proof of Condition 4.

For the first recursive call, we have:
(implies (and (natp x) (posp y) (integerp c) 
              (or (not (equal x 0)) (not (equal y 1)))
              (> x 0))
         (< (m23 (- x 1) y (+ c 1)) (m23 x y c))
Now prove the above using equational reasoning
..........
C1. (natp x)
C2. (posp y)
C3. (integerp c)
C4. ~(x=0) \/ ~(y=1)
C5. (x > 0)

(m23 (- x 1) y (+ c 1))
= {Def. m23, C5}
(+ (- x 1) (* 6 y))
< {Arithmetic}
(+ x (* 6 y)
= {Def. m23, C5}
(m23 x y c)


For the second recursive call, we have:
(implies (and (natp x) (posp y) (integerp c) 
              (or (not (equal x 0)) (not (equal y 1))) 
              (not (> x 0)))
         (< (m23 5 (- y 1) c) (m23 x y c))
Now prove the above using equational reasoning
.........
SOLUTION
C1. (natp x)
C2. (posp y)
C3. (integerp c)
C4. ~(x=0) \/ ~(y=1)
C5. ~(x > 0)
------------
C6. (x = 0) {Arithmetic, C5, C1}
C7. (y > 1) {Arithmetic, C6, C4, PL}

  (m23 5 (- y 1) c)
= {Def. m23}
  (+ 5 (* 6 (- y 1)))
= {Arithmetic}
  (- (* 6 y) 1)
< {Arithmetic, C6}
  (+ (* 6 y) x)
= {Def. m23}
  (m23 x y c)

|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Feedback (5 points)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|

Each week we will ask a couple questions to monitor how the course
is progressing.  This should be the same length as the HW07 survey. 

Please fill out the following form.

https://goo.gl/forms/SvvGaynGyjVEhV3i1

As before, feedback is anonymous and each team member should fill out
the form (only once per person).

After you fill out the form, write your name below in this file, not
on the questionnaire. We have no way of checking if you submitted the
file, but by writing your name below you are claiming that you did,
and we'll take your word for it.  

5 points will be awarded to each team member for filling out the 
questionnaire.

The following team members filled out the feedback survey provided by 
the link above:
---------------------------------------------
<firstname> <LastName>
<firstname> <LastName>

|#
