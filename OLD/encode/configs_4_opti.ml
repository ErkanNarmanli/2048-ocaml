


(* finalement je ne pense pas que la place soit le pb... mais bonm trop tard ... *)

module Configs = struct
  type t = int (* /!\ si on est en 64 bits, int suffit, sinon Int64 bits *)
               (* TODO : faire un test ... *)
    
  type rep = int array array

  (* version sans tests (opti) ; attention trash *)

  let rep_case_to_int n =
    let rec f acc x =
      if x = 1 then acc else
        f (acc + 1) (x lsr 1)
    in if n = 0 then 0 else f 0 n

  let int_to_rep_case n =
    let rec f acc x =
      if x = 0 then acc else
        f (acc lsl 1) (x - 1)
    in if n = 0 then 0 else f 1 n


  let from_rep m = 
    let rec g res i j =
      if i >= 0 then
        if j >= 0 then
          g (res + (rep_case_to_int m.(i).(j))
             * (Utils.pow 12 (4 * i + j))) i (j - 1)
        else
          g res (i - 1) 3
      else res
    in
    g 0 3 3


  let to_rep n =
    let acc = ref n in
    Array.init 4 (fun _ ->
      Array.init 4 (fun _ ->
        ( let i = int_to_rep_case (!acc mod 12) in
          let () = acc := (!acc / 12) in i )))

end

(* tests *)

let c1 = Configs.from_rep
  [|  [| 2048 ; 0 ; 0 ; 0|] ;
      [| 2 ; 0 ; 0 ; 0|] ;
      [| 0 ; 0 ; 0 ; 0|] ;
      [| 0 ; 0 ; 0 ; 0|] |]

let a1 = Configs.to_rep 20747

let c2 = Configs.from_rep
  [|  [| 2048 ; 2048 ; 2048 ; 2048 |] ;
      [| 2048 ; 2048 ; 2048 ; 2048|] ;
      [| 2048 ; 2048 ; 2048 ; 2048|] ;
      [| 2048 ; 2048 ; 2048 ; 2048|] |]

let a2 = Configs.to_rep 184884258895036415
