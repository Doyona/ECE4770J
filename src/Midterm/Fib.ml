
let rec sum = function [] -> 0 | x :: xs -> x + sum xs

let sum_tail lst = 
  let rec sum_tail_helper lst sum =
    match lst with
    | [] -> sum
    | x::xs -> sum_tail_helper xs (sum+x) 
  in
  sum_tail_helper lst 0

let sum_cps ls =
    let rec sum_cps_helper ls k =
        match ls with
        | [] ->
            k 0
        | x :: xs ->
            sum_cps_helper xs (fun acc -> k (x + acc))
    in
    sum_cps_helper ls (fun x -> x)

let sum_cps_tail ls =
    let rec sum_cps_tail_helper acc ls k =
        match ls with
        | [] ->
            k acc
        | x :: xs ->
            sum_cps_tail_helper (acc + x) xs k
    in
    sum_cps_tail_helper 0 ls (fun x -> x)

let rec fib = function n when n <= 1 -> n | n -> fib (n - 1) + fib (n - 2)

let fib_tail =
    let rec fib_tail_helper a b = function
        | n when n <= 1 ->
            b
        | n ->
            fib_tail_helper b (a + b) (n - 1)
    in
    fib_tail_helper 0 1

let fib_cps n =
    let rec fib_cps_helper n k =
        if n <= 1 then k n
        else
          fib_cps_helper (n - 1) (fun a ->
              fib_cps_helper (n - 2) (fun b -> k (a + b)) )
    in
    fib_cps_helper n (fun x -> x)

let fib_cps_tail n =
    let rec fib_cps_tail_helper n a b k =
        if n <= 1 then k b else fib_cps_tail_helper (n - 1) b (a + b) k
    in
    fib_cps_tail_helper n 0 1 (fun x -> x)

let test n ls =
    let time_it name f arg =
        let start = Sys.time () in
        let result = f arg in
        let duration = Sys.time () -. start in
        Printf.printf "%s: result: %d (%.6f seconds)\n" name result duration
    in
    time_it "sum          " sum ls ;
    time_it "sum_cps      " sum_cps ls ;
    time_it "sum_tail     " sum_tail ls ;
    time_it "sum_cps_tail " sum_cps_tail ls ;
    print_endline "----" ;
    time_it "fib          " fib n ;
    time_it "fib_cps      " fib_cps n ;
    time_it "fib_tail     " fib_tail n ;
    time_it "fib_cps_tail " fib_cps_tail n ;
    print_endline ""

let run_tests _ =
    test 15 [140; 280; 7; 25; 25] ;
    List.init 20000 (fun x -> x + 1) |> test 35