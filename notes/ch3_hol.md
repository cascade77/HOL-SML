# ch3 — writing hol terms & types

HOL works on top of ML. Everything we do (terms, types, theorems) is written using ML commands.

---

## parser & printer

- we type `"p /\ q"` → HOL parses that into a proper logic structure
- `pretty printer` makes it look nice (like showing ∧ instead of `/\`)
- real internal thing is long & messy, so printer hides that from us

---

## unicode vs ascii

you can write logic in **ascii** (`/\`, `\/`, `==>`) or **unicode** (`∧`, `∨`, `⇒`)  
→ both are accepted by parser  
→ output shown in unicode by default

| logic     | unicode | ascii |
|-----------|---------|--------|
| and       | ∧       | /\     |
| or        | ∨       | \/     |
| implies   | ⇒       | ==>    |
| not       | ¬       | ~      |
| forall    | ∀       | !      |
| exists    | ∃       | ?      |
| in set    | ∈       | IN     |
| not in    | ∉       | NOTIN  |

---

## delimiters (important)

used to switch from ML to HOL terms:
- `"p /\ q"` = just string
- ``p /\ q`` = HOL term
- use ``...`` for logic, and `"...“` for strings
- if you forget this → syntax errors

---

## session 1 — writing terms

```sml
val tlist = [``p /\ q``, ``q ==> r``];
```

- creates a list of logic terms
- **use comma**, not semicolon here (`[a, b]`, not `[a; b]`)

---

## session 2 — unicode printing

```sml
set_trace "PP.avoid_unicode" 1;
```
→ turns OFF unicode. Now output uses `/\`, `==>` etc.

```sml
set_trace "PP.avoid_unicode" 0;
```
→ turns it back ON

---

## session 3 — type checking

```sml
type_of ``p /\ q``;                 → :bool
type_of ``!x:'a. P x ==> ~Q x``;    → :bool
```

- shows that both are well-formed terms of type `bool`

---

## session 4 — ml vs hol lists

```sml
[1,2,3]     (* ML uses commas *)
[1;2;3]     (* HOL uses semicolons *)
```

```sml
type_of ``[1;2;3]``;      → :num list
```

---

## session 5 — hol function: zip

```sml
val zip_def =
  tDefine "zip" `zip (l1, l2) =
    if NULL l1 \/ NULL l2 then []
    else (HD l1, HD l2) :: zip (TL l1, TL l2)`
  (WF_REL_TAC `measure (LENGTH o FST)` >> Cases_on `l1` >> simp[]);
```

### still not making any sense?

- `tDefine` defines a function in HOL logic (not just ML)
- `NULL`, `HD`, `TL` are HOL’s versions of `null`, `hd`, `tl`
- `::` builds list like in ML
- `WF_REL_TAC ...` = **termination proof** (HOL needs proof that recursion will stop)

###  why do we need this "termination proof"?

Because HOL is a logic system — it must guarantee that the function doesn’t loop forever.  
So this part:

```sml
(WF_REL_TAC `measure (LENGTH o FST)` >> Cases_on `l1` >> simp[])
```

is a **proof tactic** that says:  
"I’m using the `length` of the first list `l1` to show recursion will end."

You don’t need to understand every detail yet — just know that **it's mandatory when defining recursive HOL functions.**

---

```sml
type_of ``zip``;
```

→ returns `:'a list # 'b list -> ('a # 'b) list`  
(it takes a **pair of lists** and gives a **list of pairs**)

---

## session 6 — eval & math

```sml
load "intLib";
EVAL ``3 + 4``;         → ⊢ 3 + 4 = 7
EVAL ``~3 + 4``;        → ⊢ -3 + 4 = 1
EVAL ``-3 * 4``;        → ⊢ -3 * 4 = -12
```

- use `EVAL` to simplify logic expressions
- `⊢` means "HOL proved this"

---

## session 7 — tuples

```sml
type_of ``(1, 2)``;              → :int # int
type_of ``(1, (2, 3))``;         → :int # (int # int)
```

- HOL only supports 2-tuples → use nesting for triples etc.
- `#` is the tuple type in HOL (like `*` in ML)

---

## session 8 — defining datatype + function

```sml
Datatype:
  tree = Lf | Nd tree 'a tree
End
```

- defines a binary tree type  
- `Lf` = leaf, `Nd` = node with left, value, right

```sml
type_of ``Nd``;
```

→ returns `:α tree -> α -> α tree -> α tree`  
(means: takes left subtree, value, right subtree → gives whole tree)

---

### define size function

```sml
Definition size_def:
  (size Lf = 0) /\ (size (Nd l _ r) = 1 + size l + size r)
End
```

- defines `size` recursively  
- `_` = wildcard (we ignore node value)

→ result is stored as a theorem called `size_def`

```
⊢ size Lf = 0 ∧ ∀l v0 r. size (Nd l v0 r) = 1 + size l + size r
```

---

## extra notes

- ML uses `*` for tuples, HOL uses `#`
- ML uses `,` in lists, HOL uses `;`
- ML uses `op+ (3, 4)`  
  HOL uses `EVAL "(+) 3 4"` or `$+`

