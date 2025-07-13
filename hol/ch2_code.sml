(* HOL CHAPTER 2 — SESSION CODE *)

(* Session 1: List basics *)
val it = 1 :: [2, 3, 4, 5];      (* cons *)
hd it;                           (* 1 *)
tl it;                           (* [2,3,4,5] *)

(* Session 2: Working with 'it' *)
val l = it;
tl l;                            (* [3,4,5] *)
hd it;                           (* 3 *)
tl (tl (tl (tl (tl l))));        (* [] *)

(* Session 3: Multiple declarations *)
val l1 = [1, 2, 3] and l2 = ["a", "b", "c"];

(* Session 4: Exploding string *)
explode "a b c";                (* char list: [#"a", #" ", #"b", #" ", #"c"] *)

(* Session 5: Tuples *)
val triple1 = (1, true, "abc");
#2 triple1;                     (* true *)
val triple2 = (1, (true, "abc"));
#2 triple2;                     (* (true, "abc") *)

(* Session 6: Function zip *)
fun zip (l1, l2) =
  if null l1 orelse null l2 then []
  else (hd l1, hd l2) :: zip(tl l1, tl l2);

zip ([1,2,3], ["a", "b", "c"]);

(* Session 7: Currying & partial application *)
fun curried_zip l1 l2 = zip (l1, l2);
fun zip_num l2 = curried_zip [0,1,2] l2;
zip_num ["a", "b", "c"];

(* Session 8: Exception handling *)
3 div 0;                        (* raises Div exception *)
3 div 0 handle _ => 0;          (* fallback value 0 *)
