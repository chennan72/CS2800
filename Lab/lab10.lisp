Lab 10 Problem Set.

In this lab we will practice all steps of induction proofs:

1. how to extract an induction scheme from an admissible ACL2s function
2. how to choose an induction scheme suitable to prove a given conjecture
3. how to prove a conjecture by induction, given an induction scheme.

In the process we will also discuss soundness of the induction principle,
and what that means in the first place.

ACL2s is not required for this lab, so feel free to come with pencil and paper.

===========================================================================
======= 1. Induction Schemes
===========================================================================

Remember that every admissible function gives rise to a sound induction
scheme. "Sound" means that whatever you prove using that induction scheme
is actually true -- you cannot prove "0=1" using such an induction scheme.

Remember further that with *non-admissible* functions all bets are off: either

- their induction scheme is sound, or
- their induction scheme is not sound, or
- their induction scheme doesn't even make sense syntactically. (Why might that be the case?)

For the following function definitions, first decide whether they are
admissible or not. (No proof required; just be prepared to defend your
decision.) In the former case, extract the induction scheme. In the latter
case, ALSO extract the induction scheme if that scheme syntactically makes
sense. Then proceed as follows:

- if you believe the scheme is sound, state so.
- otherwise, show that it is not sound. How does one do that? You need to
  come up with a false conjecture that you can "prove" using the scheme.

A final note: in this exercise we extract induction schemes from some
non-admissible functions. This is not meant as an encouragement for you to
do so in the future! Induction schemes should only be extracted from
admissible functions. An exception is an educational situation like this
lab, in which we study what may go wrong if we do so. Think of it as a
crash test.

In the following, assume that phi is a fictitious conjecture, and formulate
your induction schemes, if any, for phi.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(a)

(defunc natlistp (l)
  :input-contract (listp l)
  :output-contract (booleanp (natlistp l))
  (cond ((endp l)               t)
        ((not (natp (first l))) nil)
        (t                      (natlistp (rest l)))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(b)

(defunc fib (n)
  :input-contract (natp n)
  :output-contract (natp (fib n))
  (cond ((equal n 0) 0)
        ((equal n 1) 1)
        (t           (+ (fib (- n 1)) (fib (- n 2))))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(c)

(defunc exists-symbol (l)
  :input-contract (listp l)
  :output-contract (booleanp (exists-symbol l))
  (and (not (endp l))
       (or (symbolp (first l))
           (exists-symbol (rest l)))))

Hint: first rewrite this function equivalently using a single cond.

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(d)

(defunc zip (x y)
  :input-contract (and (listp x) (listp y) (equal (len x) (len y)))
  :output-contract (listp (zip x y))
  (if (endp x)
    nil
    (cons (list (first x) (first y))
          (zip (rest x) (rest y)))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(e)

(defunc run-down-a-list (n l)
  :input-contract (and (integerp n) (listp l))
  :output-contract t
  (if (endp l)
    nil
    (if (equal n 0)
      (first l)
      (run-down-a-list (- n 1) l))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(f)

(defunc foo (m n)
  :input-contract (and (natp m) (natp n) (evenp n))
  :output-contract (integerp (foo m n))
  (cond ((equal m 0) -3)
        ((evenp m)   (if (> n 2)
                       10
                       (foo (/ m 2) n)))
        (t           (foo (- m 1) (+ n 1)))))

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(g)

(defunc implies (p q)
  :input-contract (and (booleanp p) (booleanp q))
  :output-contract (booleanp (implies p q))
  (if q
    t
    (not p)))

...

===========================================================================
======= 2. Use of Induction Schemes
===========================================================================

Consider the following function definitions:

(defunc in (x l)
  :input-contract (listp l)
  :output-contract (booleanp (in x l))
  (cond ((endp l)            nil)
        ((equal x (first l)) t)
        (t                   (in x (rest l)))))

(defunc subsetp (l1 l2)
  :input-contract (and (listp l1) (listp l2))
  :output-contract (booleanp (subsetp l1 l2))
  (if (endp l1)
    t
    (and (in (first l1) l2)
         (subsetp (rest l1) l2))))

(defunc union (l1 l2)
  :input-contract (and (listp l1) (listp l2))
  :output-contract (listp (union l1 l2))
  (if (endp l1)
    l2
    (cons (first l1) (union (rest l1) l2))))

(a) All these functions operate on lists (convince yourself of their
admissibility). Two of them have the same induction scheme. Which ones? how
does their common induction scheme differ from the induction scheme of the
third function?

...

(b) Consider the conjecture

    (listp l1) /\ (listp l2) => (subsetp l1 (union l1 l2))

Which induction scheme would you use to prove it (any admissible function
is eligible, not only the above three)?

You can decide this by
- induction "as done by the professionals" (see lecture notes), or
- sketching the proof in your head, predicting what induction hypothesis
  you may need.

The induction scheme should be the simplest that satisfies your needs,
i.e. choose the "smallest" ACL2s function whose scheme fulfills those needs.

(Do not prove the above conjecture in the lab. Keep this for a home exercise.)

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Consider the following function definitions:

(defunc remove-dups (a)
  :input-contract (listp a)
  :output-contract (listp (remove-dups a))
  (if (endp a)
    nil
    (if (in (first a) (rest a))
      (remove-dups (rest a))
      (cons (first a) (remove-dups (rest a))))))

(defunc rev (x)
  :input-contract (listp x)
  :output-contract (and (listp (rev x)) (equal (len (rev x)) (len x)))
  (if (endp x)
    nil
    (app (rev (rest x)) (list (first x)))))

(defunc last (l)
  :input-contract (and (listp l) (not (endp l)))
  :output-contract t
  (first (rev l)))

(defunc rd-induct (a)
  :input-contract (listp a)
  :output-contract (listp (rd-induct a))
  (cond ((endp a)                nil)
	((endp (rest a))         (list (first a)))
	((in (first a) (rest a)) (rd-induct (rest a)))
	(t                       (cons (first a) (rd-induct (rest a))))))

(c) How does the induction scheme suggested by rd-induct differ from that suggested by remove-dups?

...

(d) How does the /value/ computed by rd-induct differ from that computed by remove-dups?

...

(e) Consider the conjecture

    (listp a) /\ (not (endp a)) => (last (remove-dups a)) = (last a)

Which induction scheme would you use to prove it? Consider this question
carefully, and give a justification.

(Do not prove the above conjecture in the lab. Keep this for a home exercise.)

...

===========================================================================
======= 3. An Induction Proof
===========================================================================

(defunc remove-dups (a)
  :input-contract (listp a)
  :output-contract (listp (remove-dups a))
  (if (endp a)
    nil
    (if (in (first a) (rest a))
      (remove-dups (rest a))
      (cons (first a) (remove-dups (rest a))))))

Prove the following conjecture by induction. Indicate which induction
scheme you are using. Use what we learned in the previous exercises.

phi: (listp l) => (len (remove-dups l)) <= (len l)

Hint: first rewrite the nested-if part in the body of remove-dups into a
cond construct.

...

