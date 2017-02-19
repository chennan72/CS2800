Lab 6 Problem Set.

To get ready for the first midterm, we will practice Equational Reasoning
proofs in this Lab. HW06 (posted soon) refreshes you on the rules for doing
ER, but there is nothing new here, so no need to wait for HW06. The
conjectures have already been contract-checked, but convince yourself that
no hypotheses are missing.

---------------------------------------------------------------------------

The following function definitions are given:

(defunc length (x)
  :input-contract (listp x)
  :output-contract (natp (length x))
  (if (endp x)
    0
    (+ 1 (length (rest x)))))

(defunc concat (a b)
  :input-contract (and (listp a) (listp b))
  :output-contract (and (listp (concat a b))
                        (equal (length (concat a b))
                               (+ (length a) (length b))))
  (if (endp a)
    b
    (cons (first a) (concat (rest a) b))))

(defunc reverse (x)
  :input-contract (listp x)
  :output-contract (and (listp (reverse x))
                        (equal (length (reverse x))
                               (length x)))
  (if (endp x)
    nil
    (concat (reverse (rest x)) (list (first x)))))

(defunc mem (x l)
  :input-contract (listp l)
  :output-contract (booleanp (mem x l))
  (cond ((endp l)            nil)
        ((equal x (first l)) t)
        (t                   (mem x (rest l)))))

(defdata natlist (listof nat))

(defunc sum (l)
  :input-contract (natlistp l)
  :output-contract (natp (sum l))
  (if (endp l)
      0
    (+ (first l) (sum (rest l)))))

(defunc scale (l n)
  :input-contract (and (natlistp l) (natp n))
  :output-contract (natlistp (scale l n))
  (if (endp l)
    nil
    (cons (* n (first l)) (scale (rest l) n))))

---------------------------------------------------------------------------

Recall that for each of the defunc's above we have both a definitional axiom

(ic => (f <args>) = <function body>)

(you can refer to it in justifications as "def. f"), and a contract theorem

(ic => oc)

(you can refer to it in justifications as "oc of f").

Definitional axioms and contract theorems of admitted functions are
available for you to use.

===========================================================================

1.

(implies (and (listp x)
              (listp y))
         (equal (length (concat x y))
                (length (concat y x))))

Hint: carefully look at the involved functions' definitions.

...

2.

(implies (and (listp x)
              (listp y))
         (equal (length (concat (reverse x) (reverse y)))
                (length (reverse (concat x y)))))

...

3.

(implies (natlistp x)
         (and (implies (endp x)
                       (equal (sum (reverse x)) (sum x)))
              (implies (and (natp a)
                            (equal (sum (reverse x)) (sum x)))
                       (equal (sum (reverse (cons a x))) (sum (cons a x))))))

For your conjecture contract checking, you can assume that a natlist is a
list, that reversing a natlist results in a natlist, and that consing a nat
onto a natlist results in a natlist.

You can also assume that the following has been proved (we name it (*)):

(*) (implies (and (natlistp l1) (natlistp l2))
             (equal (sum (concat l1 l2)) (+ (sum l1) (sum l2))))

Hint: This proof requires some propositional reasoning up front to rewrite
the conjecture appropriately. Do not try to prove the whole conjecture as
given at once.

...

4.

Prove the following conjecture.

phi: (listp l) /\ (mem x l) => (mem x (cons a l))

Hint: the expression (mem x (cons a l)), which you need to prove to reduce
to t, expands into a cond, but we don't know which case. A poor solution to
this problem is case analysis over x. Don't! An elegant solution is to
remember that cond is defined via "if", and that some if expressions can be
equivalently rewritten as propositional logic expressions, e.g. for
Booleans r,s, (if r s nil) = (and r s).

...

5.

Using equational reasoning, prove the following:

(and (implies (endp l)
              (equal (scale (scale l n1) n2)
                     (scale l (* n1 n2))))
     (implies (and (consp l)
                   (equal (scale (scale (rest l) n1) n2)
                          (scale (rest l) (* n1 n2))))
              (equal (scale (scale l n1) n2)
                     (scale l (* n1 n2)))))

Hint: This proof requires some propositional reasoning up front to rewrite
the conjecture appropriately. Do not try to prove the whole conjecture as
given at once.

...
