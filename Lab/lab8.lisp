Lab 8 Problem Set.

In this lab we will first discuss the problems of the exam. These problems
are not posted here; we will display them during the lab and then walk
through them.

The second part of the lab is some initial practice about admissibility.
Here are some problems that should be easy after reading the new Lecture
Notes and attending the lecture on Monday.

===========================================================================
======= Admissibility
===========================================================================

This problem set is about the "Definitional Principle" (DP).

For each of the definitions below, check whether it is admissible, i.e. it
satisfies all conditions of the DP. You can assume that Condition 1 is met:
the symbol used in the defunc is a new function symbol in each case.

1. If you claim admissibility:

- write down the logical formulas expressing the body contract conditions
  for *one* function call occurring in the body.

  For example, for the (admissible) function definition

  (defunc f (x)
    :input-contract (natp x)
    :output-contract (integerp (f x))
    (if (equal x 0)
      3
      (- 23 (f (- x 1)))))

  the body contract condition for the recursive call is

  (natp x) /\ x != 0 => (natp (- x 1))

  which needs to be a theorem for f to be admitted (which of course it is).

- state the contract theorem (which you claim is indeed a theorem).

2. If you claim the function is not admissible, identify a condition in the
DP that is violated, as follows.

- if you blame one of the "easy" rules (formal argument names distinct,
  well-formed body etc), explain the violation in English.

- if you blame one of the semantic rules (body contract, termination,
  contract theorem), provide an input that satisfies the input contract (!)
  but causes the condition to fail.

Remember that we don't care what the function does on inputs outside of its
input contract (IC). Therefore, an input that fails the IC is *not* a
suitable witness to show that a DP condition is violated. To show the
violation, give an input that satisfies the IC but then otherwise causes
trouble.

===========================================================================

(defunc f (x)
  :input-contract (natp x)
  :output-contract (integerp (f x))
  (if (equal x 0)
    3
    (- 23 (f (+ f x)))))

Not admissible (+ f x) is not valid.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x)
  :input-contract (natp x)
  :output-contract (integerp (f x))
  (if (equal x 0)
    3
    (- 23 (f x (f x)))))

Not admissible function f only takes one variable

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x)
  :input-contract (natp x)
  :output-contract (integerp (f x))
  (if (equal x 0)
    3
    (+ 99 (f (- x 1)))))

Admissible

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x)
  :input-contract (integerp x)
  :output-contract (integerp (f x))
  (if (equal x 0)
    3
    (* 2 (f (- x 2)))))

when x = 1 it can not be terminated

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x)
  :input-contract (natp x)
  :output-contract (integerp (f x))
  (if (equal x 0)
    3
    (* 2 (f (- x 2)))))

body contract failed when x = 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x y)
  :input-contract (and (natp x) (natp y))
  :output-contract (integerp (f x y))
  (cond ((< x 0)     (f x y))
        ((equal x 0) -3)
        (t           (f (- x 1) y))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x y)
  :input-contract (and (listp x) (natp y))
  :output-contract (listp (f x y))
  (cond ((equal y 0) nil)
        ((equal y 1) (list x))
        ((endp x)    (list y))
        (t           (f (cons y x) (- y 1)))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x y)
  :input-contract (and (listp x) (integerp y))
  :output-contract (listp (f x y))
  (if (< y 0)
    x
    (f (rest x) (- y 1))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x y)
  :input-contract (and (listp x) (integerp y))
  :output-contract (natp (f x y))
  (if (endp x)
    (+ 1 y)
    (+ 1 (f (rest x) y))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (l)
  :input-contract (listp l)
  :output-contract (listp (f l))
  (if (endp l)
    nil
    (h (rest l))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (n a n)
  :input-contract (and (natp n) (listp a))
  :output-contract (natp (f n a n))
  (if (endp a)
      0
      (f n (rest a) n)))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x y)
  :input-contract (and (listp x) (listp y))
  :output-contract (natp (f x y))
  (if (endp x)
    (- (len y) 1)
    (f (rest x) (cons 1 y))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x a)
  :input-contract (and (listp x) (natp a))
  :output-contract (natp (f x a))
  (if (endp x)
    (* a a)
    (f (rest x) (+ a 1))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x y)
  :input-contract (and (integerp x) (integerp y))
  :output-contract (integerp (f x y))
  (if (equal x 0)
    0
    (+ (* 2 y) (f (- x 1) y))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (a n)
  :input-contract (and (listp a) (natp n))
  :output-contract (listp (f a n))
  (if (equal n 0)
    (list n)
    (f (cons (rest a) (first a))
       (- n 1))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (a b)
  :input-contract  (and (natp a) (natp b))
  :output-contract (natp (f a b))
  (cond ((and (equal a 0) (equal b 0)) 0)
        ((equal a b)                   (f b a))
        (t                             (f a (- b a)))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (a b)
  :input-contract  (and (natp a) (natp b))
  :output-contract (natp (f a b))
  (cond ((and (equal a 0) (equal b 0)) 0)
        ((< a b)                       (f a (- b 1)))
        (t                             (f b a))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x y)
  :input-contract (listp y)
  :output-contract (natp (f x y))
  (cond ((endp y)  0)
        (t         (f  (len y) (x (rest y))))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (a b a)
  :input-contract  (and (natp a) (natp b))
  :output-contract (natp (f a b))
  (cond
    ((and (equal a 0) (equal b 0))  0)
    ((< a b)                        (f a (- b 1)))
    (t                              (f b (- a 1)))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defunc f (x l)
  :input-contract (and (integerp  x) (listp l))
  :output-contract (natp (f x l))
  (cond ((endp l) 0)
        ((> x 0)  (f (len l) (rest l)))
        (t        (- (f x (rest l)) 1))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Consider the following function definition:

(defunc h (a b c)
  :input-contract (and (natp a) (integerp b) (listp c))
  :output-contract (natp (h a b c))
  (cond ((equal a 0) (len c))
        ((endp c)    (+ a b))
        ((<= b 1)    (+ a (h (- a 1) (+ b 1) (rest c))))
        ((< a b)     (h a (- b 2) c))
        (t           (h a b (rest c)))))

(a) One condition of the Definitional Principle of ACL2s states: "The input
contracts of all functions called in the body of h must hold, provided the
input contract of h holds." Formalize this condition as a logical
conjecture, but only for all functions called in the body expression

(h a (- b 2) c))              (in the fourth cond clause).

Your conjecture must involve the condition that leads to that cond clause.
Do not omit parts that appear to be trivial.

...

(b) Now simplify the conjecture in (a), using propositional reasoning and
basic arithmetic facts. Is the conjecture true? A formal proof is not
required.

...

(c) Despite all of this effort, the function is not admitted by ACL2s.
Explain which condition exactly is violated, and give an input that
illustrates this violation.

...
