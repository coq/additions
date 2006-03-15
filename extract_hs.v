
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
(* generation of an Haskell File *)
(*******************************)

Extraction Language Haskell.

Axiom int : Set. 
Axiom i2n : int -> nat. 
Axiom z2i : Z -> int. 

Extract Inlined Constant int => "Integer". 

Extract Constant i2n =>
 "\n -> 
   case n of  
     0 -> O
     n -> S (i2n (n-1))  
".


Extract Constant z2i =>
   "
  let p2b XH = 1
      p2b (XO p) = 2*(p2b p)
      p2b (XI p) = 2*(p2b p)+1
  in 
  \z -> case z of 
          Z0 -> 0
          Zpos p -> (p2b p)
          Zneg p -> - (p2b p)
".

Extraction Inline Wf_nat.gt_wf_rec Wf_nat.lt_wf_rec.

Extraction NoInline u o top pop.

Extraction NoInline M11 M12 M21 M22 Mat_mult.

Extraction "Fibo" fibonacci int i2n z2i.

(* finally, 
     import qualified Prelude 
   is to be replaced by 
     import Prelude hiding (Bool, True, False, Left, Right)
*)