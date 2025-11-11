## About Ocaml

[Cornell Ocaml instruction](https://courses.cs.cornell.edu/cs3110/2021sp/textbook/intro/ocaml.html)

1. OCaml is a functional programming language. The key linguistic abstraction of functional languages is the mathematical function. 

2. 

A function is tail recursive if it calls itself recursively but does not perform any computation after the recursive call returns, and immediately returns to its caller the value of its recursive call.


```ocaml
let rec sum (l : int list) : int =
  match l with
  | [] -> 0
  | x :: xs -> x + (sum xs)

let rec sum_plus_acc (acc : int) (l : int list) : int =
  match l with
  | [] -> acc
  | x :: xs -> sum_plus_acc (acc + x) xs

```


3. How to open Ocaml