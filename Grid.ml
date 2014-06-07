(* Grid module ; several things are still to be optimized (see GridCore)     *
 * there, function are type-safe                                             *)

include GridCore

let quad_flip (a1, a2, a3, a4) = (a4, a3, a2, a1)

let quad_apply f (a1, a2, a3, a4) = (f a1, f a2, f a3, f a4)

let s_horiz g = rows_to_grid (quad_flip (rows g))

let s_vert g = cols_to_grid (quad_flip (cols g))

let s_cent g = s_vert (s_horiz g)

let s_diag g = rows_to_grid (quad_apply col_to_row (cols g))


(* probaly not very efficient *)
let s_adiag g = s_cent (s_diag g)

(* TODO : translate comments *)
(* plus = sens trigo *)
(* TODO : optim en virant des conversions inutiles ... *)
let r_plus g = s_diag (s_vert g)

let r_minus g = s_vert (s_diag g)


(* THIS IS A TEST VERSION *)
(* TODO : when computong canonical element, one shall not use brute force    *
 * but reuse intermediate results ; also minimum sould not be computed       *
 * by linear traversal of a list (as min is associative and commutative)     *)
(* BE CAREFUL : built-in min treat 64-bit integer as signed ; to be fixed    *)
let canon_elem g =
  let list = [ s_horiz g ; s_vert g ; s_cent g ; s_diag g ; s_adiag g ; 
               r_plus g ; r_minus g ] in
  List.fold_left min g list


(* Outputs *)

let to_tile_value (e : [ `Elem ] t) =
  let rec aux n acc =
    if n = 1 then acc else aux (n - 1) (acc lsl 1)
  in
  let i = Int64.to_int (to_int64 e) in
  if i = 0 then 0 else aux i 2

let output_grid oc g =
  begin
    Printf.fprintf oc "\n+-------+-------+-------+-------+\n" ;
    for i = 0 to 3 do
      Printf.printf "|" ;
      for j = 0 to 3 do
        Printf.fprintf oc " %5d |" (to_tile_value (get g i j)) ;
      done ;
      Printf.fprintf oc "\n+-------+-------+-------+-------+\n" ;
    done ;
    Printf.fprintf oc "\n"
  end


let print_grid g = output_grid stdout g
