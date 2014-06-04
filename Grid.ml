(* module grid ; pour les trucs a optimiser, voir core
   (mais ici c'est plus safe ...) *)

include GridCore

let get g i j = row_nth (grid_nth_row g i) j

let iter f g = fold_left (fun _ x -> f x) () g

(* pour affichage dans le toplevel : *)

let to_int64_matrix g =
  Array.init 4 (fun i -> Array.init 4 (fun j -> get g i j))


(* TODO : transformations + comparaison ... *)
