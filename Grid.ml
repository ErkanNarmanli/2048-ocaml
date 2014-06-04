(* TODO : commenter correctement et en anglais *)
(* TODO : optimiser (plus tard) *)
(* TODO : des phantom types pour assurer (en dehors) qu'on manipule bien
   un(e) grille/ligne/colone/element ... => c'est fait (cf .mli)
   + partager en core (ou c'est unsafe) et ext (via foncteur ?) *)

type 'a t = int64

let to_int64 x = x
let of_int64_unsafe x = x

(* to be inlined later (unless the compiler do so) *)

(* /\ dommage, pourrait profiter a merveille des phatom types ... 
   notamment shift_pop et autres, qui marchent sur les element et les colones
   (pas les lignes ...) ; en mettant le tout dans un sous-module unsafe ... *)

let first g = Int64.logand g 15L
let first_row g = Int64.logand g 65535L
let first_col g = Int64.logand g 4222189076152335L

let shitf_pop g = Int64.shift_right_logical g 4
let shift_push x g = Int64.logor x (Int64.shift_left g 4)
let shift_row_pop g = Int64.shift_right_logical g 16
let shift_row_push r g = Int64.logor r (Int64.shift_left g 16)

let shift_npop g n = Int64.shift_right_logical g (n lsl 2)
let shift_row_npop g n = Int64.shift_right_logical g (n lsl 4)

(* / to be inlined later *)


let row_nth g n = first (shift_npop g n)
let col_nth g n = first (shift_row_npop g n)

let grid_nth_row g n = first_row (shift_row_npop g n)
let grid_nth_col g n = first_col (shift_npop g n)

let get g i j = row_nth (grid_nth_row g i) j


(* \/ on peut faire qq optis en virant qq appels de fonctions ... *)
let rows g =
  (grid_nth_row g 0, grid_nth_row g 1, grid_nth_row g 2, grid_nth_row g 3)

let cols g =
  (grid_nth_col g 0, grid_nth_col g 1, grid_nth_col g 2, grid_nth_col g 3)



let rows_to_grid (r1, r2, r3, r4) =
  (shift_row_push r1 (shift_row_push r2 (shift_row_push r3 r4)))

let cols_to_grid (c1, c2, c3, c4) =
  (shift_push c1 (shift_push c2 (shift_push c3 c4)))



let quad_flip (a1, a2, a3, a4) = (a4, a3, a2, a1)

let quad_apply f (a1, a2, a3, a4) = (f a1, f a2, f a3, f a4)

(* pas le plus efficace ... *)
let row_to_col r =
  (shift_row_push (row_nth r 0)
  (shift_row_push (row_nth r 1)
                  (shift_row_push (row_nth r 2) (row_nth r 3))))
let col_to_row c =
  (shift_push (col_nth c 0)
  (shift_push (col_nth c 1)
                  (shift_push (col_nth c 2) (col_nth c 3))))

(* TODO : col to row et vice versa + les symetries et tout et tout *)

let make x =
  let rec aux g i =
    if i = 16 then g else
      aux (shift_push x g) (i + 1)
  in aux 0L 0


(* la numérotation commence à 0 hein ! *)
let init f =
  let rec aux g i j =
    if i < 0 then g else
      if j < 0 then aux g (i - 1) 3 else
        aux (shift_push (f i j) g) i (j - 1)
  in aux 0L 3 3


let fold_left f e g =
  let rec aux g i j acc  =
    if i > 3 then acc else
      if j > 3 then aux g (i + 1) 0 acc else
        aux (shitf_pop g) i (j + 1) (f acc (first g))
  in aux g 0 0 e

(* la suite pourrait etre ailleurs et beneficier des phantom types ... *)

let iter f g = fold_left (fun _ x -> f x) () g

(* pour affichage dans le toplevel : *)

let to_int64_matrix g =
  Array.init 4 (fun i -> Array.init 4 (fun j -> get g i j))


let _ = ()
