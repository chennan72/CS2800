#|
CS 2800 Homework 7 - Spring 2017

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Purpose of this Assignment:

We realize that you all have lots on your plate right now and that you're
frantically preparing for the exam (provided you read this before the exam)
This homework is designed solely to give you more practice for the exam
and is thus designed to potentially be finished before Thursday.  It
is also meant to be not as time intensive as the previous assignments.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PROPOSITIONAL LOGIC

We use the following ascii character combinations to represent the Boolean
connectives:

  NOT     ~

  AND     /\
  OR      \/ 

  IMPLIES =>

  EQUIV   =
  XOR     <>

The binding powers of these functions are listed from highest to lowest
in the above table. Within one group (no blank line), the binding powers
are equal. This is the same as in class.

|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PROGRAMMING:

For (parts of) this homework you will need to use ACL2s.

Technical instructions:

- open this file in ACL2s as hw07.lisp

- make sure you are in BEGINNER mode. This is essential! Note that you can
  only change the mode when the session is not running, so set the correct
  mode before starting the session.

- insert your solutions into this file where indicated (usually as "...")

- only add to the file. Do not remove or comment out anything pre-existing
  unless we are asking you to fix the code.

- make sure the entire file is accepted by ACL2s. In particular, there must
  be no "..." left in the code. If you don't finish all problems, comment
  the unfinished ones out. Comments should also be used for any English
  text that you may add. This file already contains many comments, so you
  can see what the syntax is.

- when done, save your file and submit it as hw07.lisp

- avoid submitting the session file (which shows your interaction with the
  theorem prover). This is not part of your solution. Only submit the lisp
  file.
  
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

Calls to test? are considered even more powerful.  Try to use
both
|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Equational Reasoning and Logical Equivalences

Here are some notes about equational proofs (and logical equivalence
when applicable):

1. The context: Remember to use propositional logic to rewrite
the context so that it has as many hypotheses as possible.  See
the lecture notes for details. Label the facts in your
context with C1, C2, ... as in the lecture notes.

2. The derived context: Draw a dashed line (----) after the context 
and add anything interesting that can be derived from the context.  
Use the same labeling scheme as was used in the context. Each derived
fact needs a justification. Again, look at the lecture notes for
more information.

3. Use the proof format shown in class and in the lecture notes,
which requires that you justify each step.  Explicitly name each
axiom, theorem or lemma you use but you can use any "shortcut"
we've used in lab or in the lectures. For example, you
do not need to cite the if axioms when using a definitional axiom.
Look at the lecture notes for examples.

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
reasoning", "Prop logic", or "PL", except you should use "MP" 
to explicitly identify when you use modus ponens and MT for Modus Tollens.

9. For any given propositional expression, feel free to re-write it
in infix notation (ex A =>(B/\C)).

10. For this homework, you can only use theorems we explicitly
tell you you can use or we have covered in class / lab / previous
assignments. You can, of course, use the definitional axiom and contract 
theorem for any function used or defined in this homework. You
may also use theorems you've proven earlier in the homework.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

For each conjecture make sure you:

- Perform contract checking and contract completion. This is to make 
  all functions in the conjecture pass all input contracts.
  
- Run some tests to make an educated guess as to whether the conjecture is
  true or false. In the latter case, give a counterexample to the
  conjecture, and show that it evaluates to false. Else, give a proof 
  using equational reasoning, following instructions 1 to 10 above.

|#


#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Section 1: Propositional Expressions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Simplify each of the following propositional expressions using 
logical equivalences like we have done in previous assignments 
and then group them based on what they are equivalent to.  

For example, the following 3 expressions would be grouped as follows:
EX1) a /\ (b \/ a ) 
     = {Absorption}
     a
EX2) (a /\ T) /\ ~a
     = {Associativity, Commutative}
     (a /\ ~a /\ T)
     = {(p /\ nil) = nil, p/\~p = nil}
     nil
EX3) ~a => a
     = {~p => p = p}
     a

Group 1 (A): EX1 EX3
Group 2 (nil): EX2

1) (( a /\ b ) \/ ( b /\ c )) /\ ( d /\ a ) /\ ( ~b \/ ~d )
...........

  
2) a \/ ( p => ~p ) \/ ( b /\ a )
...........

  
3) ( b = b ) /\ (( b <> b ) \/ a)
...........


4) p /\ ~a  => nil
...........


5) ( a <> ~a ) => ( ~p \/ a ) /\ ( ~a /\ p )
...........


6) ~(t => p <> ~( p /\ a ) => ~( p => ~a ))
...........
  

Indicate your groups here:
.....

|#

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Section 2: Truth Tables & Classifications
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Write a truth table for each of these expressions
then clearly state if the expression is valid, satisfiable,
falsifiable, or unsatisfiable. Truth tables should
have a column for each sub-part of the expression like
you wrote in a previous homework.

a) ~( p /\ ~q ) => q
...........

 
b) ( p /\ q <> r) <> r
Notice anything about xor?  What is ( p /\ q ) <> ( r <> r ) 
(you don't need to write this truth table)?
........

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Section 3: PROGRAMMING IN ACL2s
;; Quadoku Validator
;; For Information on how to play sudoku: 
;; http://www.sudokukingdom.com/rules.php
;; or https://en.wikipedia.org/wiki/Sudoku
;; 
;; Instead of Sudoku which uses a 9x9 board, we will play 
;; Quadoku which uses a 4x4 board. For each row, column or block of
;; 4 cells, the group is considered valid if the numbers 1-4 are
;; present. Thus numbers are not duplicated and there are no blank
;; cells (indicated by 0). Blocks of cells are the four 2x2 
;; groups that compose the main board. 
;;
;; Let's make a Quadoku tester such that any quadoku board can be 
;; evaluated as to whether it was done correctly, there are empty 
;; cells or there is a mistake in the solution.
;; Any invalid row, column or block means the quadoku board has 
;; not been solved correctly.

;; The set of admissible symbols in a 4x4 quadoku grid.
(defdata qval (range integer (0 <= _ <= 4)))

;; A group of quadoku numbers consists of 4 positions
;; (a row, column, or 2x2 block) which are positive numbers
;; or 0.
(defdata qgroup (list qval qval qval qval))

;; Make a defdata for group-type which is a 'row, 'column or 'block
(defdata group-type (oneof 'row 'column 'block)) ;; SOLUTION

;; a quadoku board contains 4 qgroups indicating
;; each ROW of the board. Define this data structure
(defdata q-board (list qgroup qgroup qgroup qgroup)) ;; SOLUTION

;; Make your own quadoku board to test your results.
;; Here is one to play with.
(defconst *test-row1* (list 1 2 3 4))
(defconst *test-row2* (list 1 2 3 4))
(defconst *test-row3* (list 1 2 3 4))
(defconst *test-row4* (list 1 2 3 4))

(defconst *test-board* (list *test-row1* *test-row2* 
                             *test-row3* *test-row4* ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start: Useful functions / theorems for sections 3 & 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; len2: list -> natp
;; (len2 l) returns the number of elements in list l
(defunc len2 (l)
  :input-contract (listp l)
  :output-contract (natp (len2 l))
  (if (endp l)
    0
    (+ 1 (len2 (rest l)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; in2: list -> boolean
;; (in2 a l) returns true iff a is an element
;; in l.  Otherwise return nil.
(defunc in2 (a l)
  :input-contract (listp l)
  :output-contract (booleanp (in2 a l))
  (if (endp l)
    nil
    (or (equal a (first l)) (in2 a (rest l)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; no-dupes: list -> boolean
;; (no-dupes l) takes a list l and returns true
;; iff there are no duplicate elements in l
(defunc no-dupes (l)
  :input-contract (listp l)
  :output-contract (booleanp (no-dupes l))
  (if (endp l)
    t
    (if (in2 (first l)(rest l))
      nil
      (no-dupes (rest l)))))

(test? (implies (and (listp l1) (listp l2) (listp l3))
                (not (no-dupes (app l1 (app (cons e1 l2)(cons e1 l3)))))))
(test? (implies (and (listp l)(no-dupes l))
                (not (in2 (first l) (rest l)))))

(check= (no-dupes '(a b c d e)) t)
(check= (no-dupes '(a b c b e)) nil)
(check= (no-dupes nil) t)
(check= (no-dupes '(a)) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; num-unique: list -> natp
;; (num-unique l) takes a list and returns the number
;; of unique elements in it.
(defunc num-unique (l)
  :input-contract (listp l)
  :output-contract (natp (num-unique l))
  (cond ((endp l) 0)
        ((in2 (first l)(rest l)) (num-unique (rest l)))
        (t                      (+ 1 (num-unique (rest l))))))

(check= (num-unique '(1 2 3 4 3 2 1)) 4)
(test? (implies (and (listp l)(not (in2 a l)))
                (equal (num-unique (cons a l))(+ 1 (num-unique l)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theorems to help you code: you can use them in your proofs
;; later and it may help ACL2s prove things about your code.
(defthm q-group-len-thm (implies (qgroupp q)(equal (len q) 4)))
(defthm q-board-len-thm (implies (q-boardp b)
                                 (equal (len b) 4)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END: Useful functions / Theorems for Sections 3 & 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Make your own quadoku board to test your results.
;; The boards below are used in later tests so make a new
;; board.
(defconst *test2-row1* (list 1 2 3 4))
(defconst *test2-row2* (list 3 4 2 1))
(defconst *test2-row3* (list 4 3 1 2))
(defconst *test2-row4* (list 2 1 4 3))

(defconst *test2-board* (list *test2-row1* *test2-row2* 
                              *test2-row3* *test2-row4* ))

(defconst *test3-row1* (list 0 2 0 4))
(defconst *test3-row2* (list 3 0 2 1))
(defconst *test3-row3* (list 4 3 0 0))
(defconst *test3-row4* (list 0 1 4 3))

(defconst *test3-board* (list *test3-row1* *test3-row2* 
                              *test3-row3* *test3-row4* ))

;; q-idx either represents a valid index into the quadoku board
;; OR a filled in value on the board.
(defdata q-idx (range integer (0 < _ <= 4)))
(check= (q-idxp 0) nil)
(check= (q-idxp 1) t)
(check= (q-idxp 1) t)
(check= (q-idxp 1) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; valid-qgroupp: qgroup -> Boolean
;; (valid-qgroupp g) returns true if the qgroup
;; g contains values 1-4 with no repetition.
(defunc valid-qgroupp (g)
  :input-contract (qgroupp g)
  :output-contract (booleanp (valid-qgroupp g))
  (and (not (in2 0 g))(no-dupes g)))

(check= (valid-qgroupp *test2-row4*) t)
(check= (valid-qgroupp *test-row1*) t)

;;;;;;;;;;;;;;;;;; WRITE ADDITIONAL TESTS ;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FIX THE CODE: this can include changing the signature
;;               or the function body
;; get-group-cell: qval x qgroup -> qval
;;
;; (get-group-cell c g) takes a column index c
;; and a qgroup g and returns the value at cell c.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc get-group-cell (c g)
  :input-contract (and (qvalp c)
                       (qgroupp g))
  :output-contract (qvalp (get-group-cell c g))
  (cond ((endp g)    0)
        ((equal c 1) (first g))
        ((equal c 2) (rest g))
        ((equal c 3) (third g))
        (t           (get-row-cell (- c 1) (rest g)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; get-cell: q-idx x q-idx x q-board -> qvalp
;;
;; (get-cell r c b) takes a row index r, a column index c
;; and a q-board b and returns the value at cell (r, c).
;; Notice positions start at 1 and not 0.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defunc get-cell (r c b)
  ...............


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; get-row: q-idx x q-board -> qgroup 
;; (get-row idx b) take an q-idx idx between 1 and 4 and
;; a quadoku board b and returns a qgroup representing 
;; all elements in the idx-th row of b. 
(defunc get-row (idx b)
  ..............

(check= (get-row 1 *test2-board*) *test2-row1*)
(check= (get-row 4 *test2-board*) *test2-row4*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; get-column: q-idx x q-board -> qgroup 
;; (get-column idx b) take an q-idx idx between 1 and 4 
;; and a quadoku board b and returns a qgroup representing
;; all elements in the idx-th column of b.
(defunc get-column (idx b)
  ...............

(check= (get-column 1 *test2-board*) '(1 3 4 2))
(check= (get-column 4 *test2-board*) '(4 1 2 3))

(defdata qidx-off (oneof 0 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; get-block-offset: qidx-off x qidx-off x q-board -> qgroup 
;; (get-block-offset offR offC b) takes two qidx-offset values
;; (offR for the row and offC for the column) and a q-board b.
;; A qgroup block offset from 1 1 by the offR and offC is 
;; returned.
(defunc get-block-offset (offR offC b)
  :input-contract (and (qidx-offp offR)(qidx-offp offC)(q-boardp b))
  :output-contract (qgroupp (get-block-offset offR offC b))
  (list (get-cell (+ offR 1) (+ offC 1) b)
        (get-cell (+ offR 1) (+ offC 2) b)
        (get-cell (+ offR 2) (+ offC 1) b)
        (get-cell (+ offR 2) (+ offC 2) b)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINE
;; get-block: q-idx x q-board -> qgroup 
;; (get-block idx b) take an q-idxp idx between 1 and 4 and
;; a quadoku board b and returns a qgroup representing all 
;; elements in the idx-th block of b. Blocks are numbered 
;; from the top left (with cell (1,1)) to the top right (block 2
;; with cell 1, 4) and then from top to bottom
;; Thus block 4 includes cell (4,4). Cells in a block are 
;; numbered in the same way.
(defunc get-block (idx b)
  ..........
       
(check= (get-block 1 *test2-board*) '(1 2 3 4))
(check= (get-block 3 *test2-board*) '(3 4 2 1))
(check= (get-block 1 *test3-board*) '(0 2 3 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; *** FIX CODE (and comment) to make it work***
;; valid-typep: symbol x qval x q-board
;;
;; (valid-typep type idx b) takes a symbol type and an 
;; q-board b and tests the validity of 
;; a qgroup type (row, column, block) from 1 to 4.  
(defunc valid-typep (type idx b)
  :input-contract (and (symbolp type)(qvalp idx)(q-boardp b)) 
  :output-contract (booleanp (valid-typep type idx b))
  (cond ((equal type 'row)    (valid-qgroupp (get-row idx b)))
        ((equal type 'column) (valid-qgroupp (get-column idx b)))
        (t                    (valid-qgroupp (get-block idx b)))))
  
(check= (valid-typep 'row 1 *test-board*) t)
(check= (valid-typep 'column 1 *test-board*) nil)
(check= (valid-typep 'column 1 *test2-board*) t)
(check= (valid-typep 'block 1 *test2-board*) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; valid-all-typep: group-type x q-board -> boolean
;; (valid-all-typep type b) takes a q-board b and 
;; a type of group (row, column, or block) and returns
;; whether all groups of that type are correctly
;; filled in.
(defunc valid-all-typep (type b)
  :input-contract (and (group-typep type)(q-boardp b))
  :output-contract (booleanp (valid-all-typep type b))
  (and (valid-typep type 1 b)(valid-typep type 2 b)
       (valid-typep type 3 b)(valid-typep type 4 b)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GIVEN
;; valid-qboardp: q-board -> boolean
;; (valid-qboardp b) takes a q-board b and returns
;; whether it is correctly filled in with all
;; rows, columns, and blocks on the board having
;; valid values.
(defunc valid-qboardp (b)
  :input-contract (q-boardp b)
  :output-contract (booleanp (valid-qboardp b))
  (and (valid-all-typep 'row b)
       (valid-all-typep 'column b)
       (valid-all-typep 'block b)))

(check= (valid-qboardp *test-board*) nil)
(check= (valid-qboardp *test2-board*) t)

;;;;;;;;;;;;;; ADD YOUR OWN TESTS FOR YOUR OWN BOARD ;;;;;;;;;
..........

#|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Section 4: Equational Reasoning
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Prove the following conjectures are valid.  Function definitions can
be found above in section 3.

a) **UNMARKED EXTRA PRACTICE**
   (implies (listp l)
            (implies (or (endp l)
                         (and (not (endp l))(in2 (first l)(rest l))
                              (implies (listp (rest l))(<= (num-unique (rest l))(len2 (rest l)))))
                         (and (not (endp l))(not (in2 (first l)(rest l)))
                              (implies (listp (rest l))(<= (num-unique (rest l))(len2 (rest l))))))
                     (<= (num-unique l)(len2 l))))

.....................


b) (implies (and (listp l)(no-dupes l)) 
            (and (implies (endp l)(equal (num-unique l)(len2 l)))
                 (implies (and (not (endp l))
                               (implies (and (listp (rest l))(no-dupes (rest l)))
                                        (equal (num-unique (rest l))(len2 (rest l)))))
                          (equal (num-unique l)(len2 l)))))

.....................

We will claim that this gives us the following theorem (even if you don't
finish the proof)
Phi_nd_uniquelen: (implies (and (listp l)(no-dupes l))
                           (equal (num-unique l)(len2 l)))

                           
                           
c) The function valid-qgroupp seems strange.  We
don't actually check if 1-4 are all in the group. Instead we check 
for conditions that indicate they cannot all be in the group.
However, consider the following function:

(defunc valid-qgroup2p (g)
  :input-contract (qgroupp g)
  :output-contract (booleanp (valid-qgroup2p g))
  (and (in 1 g)(in 2 g)(in 3 g)(in 4 g)))

Prove the following conjecture is valid thus showing
that the functions are equivalent.
   (implies (qgroupp g) (and (implies (valid-qgroup2p g)
                                      (valid-qgroupp g))
                             (implies (valid-qgroupp g)
                                      (valid-qgroup2p g))))

You might want to look at q-group-len-thm above (ACL2s has proved this is
a theorem).

You can use any theorems above. You can also assume the following are theorems.
Phi_group4_nd: (implies (and (qgroupp g)(in 1 g)(in 2 g)(in 3 g)(in 4 g))
                        (no-dupes g))
Phi_exclude0: (implies (and (qgroupp g)(in 1 g)(in 2 g)(in 3 g)(in 4 g))
                            (not (in 0 g)))

Phi_unique_ex0: (implies (and (qgroupp g)(equal (num-unique g) 4)(not (in 0 g)))
                         (and (in 1 g)(in 2 g)(in 3 g)(in 4 g)))
                          

...............

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Feedback (5 points)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|

Each week we will ask a couple questions to monitor how the course
is progressing.  This should be a far shorter questionnaire than 
for HW05. 

Please fill out the following form.

https://goo.gl/forms/SRabgC8TXZhqJV3q1

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
