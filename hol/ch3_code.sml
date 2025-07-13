---
(* ch3 — HOL function + term examples *)

(* session 1 *)
val tlist = [``p /\ q``, ``q ==> r``];

(* session 2 *)
set_trace "PP.avoid_unicode" 1;
``x IN A``;
set_trace "PP.avoid_unicode" 0;
``x ∈ A``;

(* session 3 *)
type_of ``p /\ q``;
type_of ``!x:'a. P x ==> ~Q x``;

(* session 4 *)
``[1; 2; 3; 4]``;
type_of it;

(* session 5 *)
val zip_def =
  tDefine "zip" `zip (l1, l2) =
    if NULL l1 \/ NULL l2 then []
    else (HD l1, HD l2) :: zip (TL l1, TL l2)`
  (WF_REL_TAC `measure (LENGTH o FST)` >> Cases_on `l1` >> simp[]);

type_of ``zip``;

(* session 6 *)
load "intLib";
EVAL ``3 + 4``;
EVAL ``~3 + 4``;
EVAL ``-3 * 4``;

(* session 7 *)
type_of ``(1, 2)``;
type_of ``(1, (2, 3))``;

(* session 8 *)
Datatype:
  tree = Lf | Nd tree 'a tree
End

type_of ``Nd``;

Definition size_def:
  (size Lf = 0) /\ (size (Nd l _ r) = 1 + size l + size r)
End
