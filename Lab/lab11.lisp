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
#| Lab 11 Problem Set.

In this lab we will continue practicing induction proofs, using a claim of
/functional equivalence/ as example. "Functional equivalence" is a very
simple concept: suppose you have two implementations, say f1 and f2, of
some functionality. It could be that f2 is a re-implementation (using other
language constructs) of f1, or that f2 uses a different algorithm than f1,
or that f2 implements some data privacy measures that nobody was thinking
of when f1 was created.

Functional equivalence then simply means that f1 and f2 indeed implement
the same function:

<hyp> => (f1 <args>) = (f2 <args>)

Note that if f1 and f2 implement the same function, they must have the same
input variables and the same input contract.

The Lab involves some programming, and some proving. Our example involves
once again the Fibonnaci sequence of numbers. We will implement it using a
very fundamental algorithmic technique known as Dynamic Programming. 

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1. Fibonnaci with Dynamic Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; We turn off testing done by ACL2s while it admits a function,
; and allow ACL2s to be sloppy when it comes to termination checking
; (not because our functions do not terminate [they do], but because
; ACL2s requires help to prove it, which is not the point of this lab).

(acl2s-defaults :set testing-enabled nil)
(set-defunc-termination-strictp nil)

; Recall the textbook definition of the fib function:

(defunc fib (n)
  :input-contract (natp n)
  :output-contract (natp (fib n))
  (if (<= n 1)
    n
    (+ (fib (- n 1))
       (fib (- n 2)))))

(check= (fib 1) 1)
(check= (fib 6) 8)
(check= (fib 8) 21)

#|

This is an elegant and very easy to read definition. But it is also very
slow. In one of the remaining homeworks you may see a tail-recursive
version of this function, as one way of making it more efficient. In this
lab we will study a different way. Our way is easier, but -- it turns out
-- not quite as efficient as the tail-recursive one (but still vastly more
efficient than fib above).

Let's design a new function fib-fast. The idea is as follows. First write a
function fib-help that, for input n, computes the _list_ of Fibonacci
numbers 0,1,1,2,3,5,8,... in _descending_ order from (fib n) down to
(fib 0) = 0. See tests below, and also note the output contract, which is
provided for you. Provide 3 more tests.

In this exercise, you MUST use (let ...) whenever you need the result of a
recursive call several times. That is, your code must not contain several
calls to fib-help with the same arguments. The point of Dynamic Programming
is exactly to avoid evaluating a function several times on the same
arguments. In practice this often means that certain values are stored in a
data structure called /hash table/. For us, using (let ...) achieves the
same effect.

|#

(defdata natlist (listof nat))

(defunc fib-help (n)
  :input-contract (natp n)
  :output-contract (natlistp (fib-help n))
   (cond ((equal n 0) (list 0))
         ((equal n 1) (list 1 0))
         (t 
          (let ((r (fib-help (- n 1))))
            (cons (+ (first r) (second r)) r)))))

(check= (fib-help 0) '(0))
(check= (fib-help 1) '(1 0))
(check= (fib-help 3) '(2 1 1 0))

; Design more tests.

; Now write a non-recursive function fib-fast, with contracts as for the
; original fib function, which calls fib-help to compute (fib n).

(defunc fib-fast (n)
  :input-contract (natp n)
  :output-contract (natp n)
  (if (<= n 1)
    n
         (+ (first (fib-help (- n 1))) (second (fib-help (- n 1))))))

; Test that fib-fast computes the same values as fib above!

(check= (fib-fast 1) (fib 1))
(check= (fib-fast 6) (fib 6))
(check= (fib-fast 8) (fib 8))#|ACL2s-ToDo-Line|#


;; Design more tests, using test? feature. We first turn testing back on:

(acl2s-defaults :set testing-enabled t)

;; Now, before you use test?, heed this warning: you should force ACL2s to
;; test using only relatively small values (say <= 30, but this depends on
;; your machine), otherwise running (fib n) could take "forever"! How do
;; you make this part of your test? specification?

; Now compare the runtimes of fib and fib-fast on some inputs of increasing size.
; You should see a VAST difference.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2. Correctness of fib-fast: Equivalence Checking
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Let's prove that fib-fast implements the same functionality as fib:

     (natp n) => (fib n) = (fib-fast n)                , which is equivalent to
phi: (natp n) => (fib n) = (first (fib-help n))

Of course we will need induction.

First: what is the induction scheme of fib-help? how does it differ from
the induction scheme of fib?

We will discuss in the lab which induction scheme you should use to prove
phi. Among that of fib and that of fib-help, there is only ONE correct
answer.

Now prove phi using the induction scheme as discussed. It will turn out
that you need a lemma. We will synchronize the lab when everyone is stuck.

...
