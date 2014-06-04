(* avec des phantom types pour gerer les elements/lignes/colonnes/grilles *)
(* faudrait en faire pour les indices ... *)

type 'a t

val to_int64 : 'a t -> int64
val of_int64 : int64 -> 'a t (* unsafe ; voir plus tard pour différencier *)
val elem_of_int : int -> [ `Elem ] t

(*
val first : 'a t -> 'a t
val first_row : 'a t -> 'a t
val shitf_pop : 'a t -> 'a t
val shift_push : 'a t -> 'a t -> 'a t
val shift_row_pop : 'a t -> 'a t
val shift_row_push : 'a t -> 'a t -> 'a t
val shift_npop : 'a t -> int -> 'a t
val shift_row_npop : 'a t -> int -> 'a t
 *)
val nth : [< `Col | `Row ] t -> int -> [ `Elem ] t
val nth_row : [ `Grid ] t -> int -> [ `Row ] t
(*
val get_first_col : 'a t -> 'a t
 *)
val nth_col : [ `Grid ] t -> int -> [ `Col ] t
val make : [ `Elem ] t -> [ `Grid ] t
val init : (int -> int -> [ `Elem ] t) -> [ `Grid ] t


val to_int_matrix : 'a t -> int array array
val to_int_array : 'a t -> int array
