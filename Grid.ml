(* TODO : commenter correctement et en anglais *)
(* TODO : optimiser (plus tard) *)
(* TODO : des phantom types pour assurer (en dehors) qu'on manipule bien
   un(e) grille/ligne/colone/element ... => c'est fait (cf .mli)
   + partager en core (ou c'est unsafe) et ext (via foncteur ?) *)

type 'a t = int64

let to_int64 x = x
let of_int64 x = x
let elem_of_int = Int64.of_int (* /!\ pas de checks *)

(* to be inlined later : (unless the compiler do so) *)
let first g = Int64.logand g 15L
let first_row g = Int64.logand g 65535L
let shitf_pop g = Int64.shift_right_logical g 4
let shift_push x g = Int64.logor x (Int64.shift_left g 4)
let shift_row_pop g = Int64.shift_right_logical g 16
let shift_row_push r g = Int64.logor r (Int64.shift_left g 16)


let shift_npop g n = Int64.shift_right_logical g (n lsl 2)
let shift_row_npop g n = Int64.shift_right_logical g (n lsl 4)

(*
let get_first_col g =
  let mask = (Int64.logor (Int64.shift_left (Int64.logor (Int64.shift_left 15L 16) 15L) 16) 15L)
  in Int64.logand g mask
 *)


(* attention, ne se comporte pas comme pour des matrices *)
let nth g n = first (shift_npop g n)

let nth_row g n = first_row (shift_row_npop g n)


(* mode bourrin pour le moment ; a optimiser !!! *)
let get_first_col g =
  shift_push (first g) (shift_push (nth g 4) (shift_push (nth g 8) (nth g 12)))

let nth_col g n = get_first_col (shift_npop g n)

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



(* pour affichage dans le toplevel : *)

(* version bourin ; mais en meme temps ce sera utilisé que pour du debug ... *)
let to_int_matrix g =
  Array.init 4 (fun i ->
    Array.init 4 (fun j ->
      Int64.to_int (nth (nth_row g i) j)))


let to_int_array g =
  Array.init 4 (fun i -> Int64.to_int (nth g i))
