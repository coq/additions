
Require Import Constants.
Require Import generation.
Require Import monoid.
Require Import machine.
Require Import strategies.
Require Import spec.
Require Import log2_spec.
Require Import log2_implementation.
Require Import Compare_dec.

Require Import while.
Require Import imperative.
Require Import develop.
Require Import dicho_strat.
Require Import binary_strat.
Require Import trivial.
Require Import standard.
Require Import monofun.
Require Import matrix.
Require Import ZArith.
Require Import main.

(*******************************)
(* generation of an Scheme File *)
(*******************************)

Extraction Language Scheme.

Axiom int : Set. 
Axiom big_int : Set.
Axiom i2n : int -> nat. 
Axiom z2b : Z -> big_int. 

Extract Inlined Constant int => "int". 
Extract Constant big_int => "Big_int.big_int".

Extract Constant i2n =>
 "(lambda (i) (if (zero? i) `(O) `(S ,(i2n (- i 1)))))".

Extract Constant z2b =>
 "(lambda (z)
    (define (p2i p)
      (match p
        ((XH) 1)
        ((XO p) (* 2 (p2i p)))
        ((XI p) (+ 1 (* 2 (p2i p))))))
    (match z
       ((Z0) 0)
       ((Zpos p) (p2i p))
       ((Zneg p) (- (p2i p)))))
  ".

Extraction Inline Wf_nat.gt_wf_rec Wf_nat.lt_wf_rec.

Extraction NoInline u o top pop.

Extraction NoInline M11 M12 M21 M22 Mat_mult.

Extraction "fibo" fibonacci int big_int i2n z2b.
