# ch2 — HOL System + SML Basics

basic stuff to get started with types, lists, functions, exceptions — all using ML inside HOL

---

## types

- `int`, `bool`, `string`, `char`, `list`, `tuple`
- `'a`, `'b` = polymorphic (generic)

---

## function syntax

```sml
fun name args = expression
```

- works with recursion, conditionals
- supports curried functions

---

## session 1 — list + cons

```sml
1 :: [2,3,4,5]
```

- adds to front of list
- `hd` = first element  
- `tl` = rest of list  
- `;` ends the statement

---

## session 2 — using `it`

```sml
val l = it;
tl l;
hd it;
```

- `it` = last result  
- can bind `it` to a name  
- nest `tl` to get empty list

---

## session 3 — `and` keyword

```sml
val l1 = [1,2,3] and l2 = ["a","b","c"];
```

- make 2 lists in one line  
- types stay separate

---

## session 4 — string to char list

```sml
explode "a b c";
```

- returns list of `char`s  
- like `[#a, #" ", #b, ...]`

---

## session 5 — tuples

```sml
val triple1 = (1, true, "abc");
#2 triple1;  (* true *)
```

- use `#1`, `#2`, etc. to get tuple elements  
- nested tuples are treated differently

---

## session 6 — zip function

```sml
fun zip (l1, l2) =
  if null l1 orelse null l2 then []
  else (hd l1, hd l2) :: zip(tl l1, tl l2);
```

- pairs up two lists  
- `(hd l1, hd l2)` makes a pair  
- `::` adds to front  
- recursion builds the final list

---

## session 7 — curried + partial

```sml
fun curried_zip l1 l2 = zip(l1, l2);
fun zip_num l2 = curried_zip [0,1,2] l2;
```

- functions take args one by one  
- can partially apply and reuse

---

## session 8 — exceptions

```sml
3 div 0;                        (* error *)
3 div 0 handle _ => 0;          (* fallback 0 *)
```

- `handle` catches errors  
- `_` means "any exception"

---
