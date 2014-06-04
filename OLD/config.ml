open Utils

type t = { size : int ; matrix : int array array } 
           (* nexts_human : t list lazy_t ;
              nexts_computer : t list lazy_t } *)

type dir = Up | Down | Left | Right

(*
let move c d =
  let up i j = if ... then Some ...
  let (next, ...) = (
    match d with Up -> (..., ... , ...)
 *)

let size c = c.size

let to_rep c = c.matrix

let from_rep m =
  let rec correct x =
    if x = 0 then true else
      if (1 land x = 1) then false else
        if x = 2 then true else correct (x lsr 1)
  in
  let n = Array.length m in
  if ExtArray.for_all
       (fun a ->
        Array.length a = n
        && ExtArray.for_all
             (fun x -> correct x) a) m
  then 
    let rec c = { size = n ; matrix = m } in c
  else raise (Invalid_argument "from_rep: invalid matrix")

