let sum_tail lst = 
  let rec sum_tail_helper lst sum =
    match lst with
    | [] -> sum
    | x::xs -> sum_tail_helper xs (sum+x) 
  in
  sum_tail_helper lst 0