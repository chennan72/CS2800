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

Lab 5 Problem Set.

In line with the next homework, in this lab we will do some logic
exercises. This is very new material, so expect to get stuck here and
there. The purpose of the lab is precisely to help you get unstuck
immediately, rather than having to wait for the next office hour. So try
these at home, and come prepared with questions.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; A. Substitutions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The following are somewhat tricky substitution questions. Think about
; them, and ask if you cannot solve them. Their purpose is to sharpen your
; understanding of substitutions, rather than routine practice (the
; homework will help you with the latter).

#|

1. Let sigma1 = ((a b)) and sigma2 = ((b a)). Then, for any formula phi,
(phi|sigma1)|sigma2 = phi. True or false? If true, explain why. If false,
give a counterexample.

false

f= (any type)a (any relationship) (anytype)b 

The first substitution doesn't change the b.

substitute a with b first, then substitute b with a

The final result will be the same with phi

2. Let sigma = ((a b) (b a)). Then, for any formula phi,
(phi|sigma)|sigma = phi. True or false? If true, explain why.
If false, give a counterexample.

True

3. For any formula phi and any substitution sigma,
(phi|sigma)|sigma = phi|sigma . True or false? If true, explain why.
If false, give a counterexample.

False

For division in the function, the denominator can not be subsitituted with 0.

4. Give an example of two formulas f and g and a substitution sigma such that
all of the following hold: (i) f and g are *not* logically equivalent,
(ii) f|sigma = g, and (iii) g|sigma = f.

a => b

not equal --- substitute a with b

b => a

5. Give an example of a formula g such that, for any substitution
sigma, the formula g|sigma is *not* valid.

(~p and p)

g = False for any substitution is always false

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; B. Equational Reasoning
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



For the following conjectures:

- first perform conjecture contract checking. This is required NO MATTER
  whether you think the conjecture is true or false!

- then predict whether the conjecture is true or false.
  If false, you should be able to find a counterexample.
  If true, prove it by equational reasoning.

cons, rest, and arithmetic functions are built in -- all we know about them
is the axioms that define them; see the ACL2s lecture notes.

Here are some other functions' definitions:

(defunc len (l)
  :input-contract (listp l)
  :output-contract (natp (len l))
  (if (endp l)
    0
    (+ 1 (len (rest l)))))

(defunc app (a b)
  :input-contract (and (listp a) (listp b))
  :output-contract (listp (app a b))
  (if (endp a)
    b
    (cons (first a) (app (rest a) b))))

(defunc dup (x)
  :input-contract (listp x)
  :output-contract (listp (dup x))
  (if (endp x)
    nil
    (cons (first x) (cons (first x) (dup (rest x))))))

Warning: some of the below conjectures are "odd" -- they seem to make no
sense. How do we wiggle ourselves out of this situation? Can logic help?

|#

#|

6. (len (cons a l)) = l + 1

(listp l) /\ (rationalp l) => ... l + 1

nil => ....

Intutively saying this formula makes no sense --- Vacuity

(len (list l)) + 1

7. (len (cons a l)) = (len l) + 1

(len (list l)) + 1


8. (len (rest l)) = (len l) - 1

(endp l)


9. (len (cons l1 l2)) = (len l1) + (len l2)

=2

10. l = () v (len (cons a l)) >= 2



11. (app (cons x y) z) = (cons x (app y z))

Advanced:

12. (len (dup x)) = 2 * (len x) => (len (dup (cons a x))) = 2 * (len (cons a x))

|#
