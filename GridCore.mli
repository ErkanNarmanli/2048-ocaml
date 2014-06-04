(* avec des phantom types pour gerer les elements/lignes/colonnes/grilles *)
(* faudrait en faire pour les indices ... *)

type 'a t

val to_int64        : 'a t -> int64
val of_int64_unsafe : int64 -> 'a t

val row_nth      : [ `Row ] t  -> int -> [ `Elem ] t
val col_nth      : [ `Col ] t  -> int -> [ `Elem ] t
val grid_nth_row : [ `Grid ] t -> int -> [ `Row ] t
val grid_nth_col : [ `Grid ] t -> int -> [ `Col ] t

val rows : [ `Grid ] t -> [ `Row ] t * [ `Row ] t * [ `Row ] t * [ `Row ] t
val cols : [ `Grid ] t -> [ `Col ] t * [ `Col ] t * [ `Col ] t * [ `Col ] t

val rows_to_grid : [ `Row ] t * [ `Row ] t * [ `Row ] t * [ `Row ] t
                     -> [ `Grid ] t
val cols_to_grid : [ `Col ] t * [ `Col ] t * [ `Col ] t * [ `Col ] t
                     -> [ `Grid ] t

val row_to_col : [ `Row ] t -> [ `Col ] t
val col_to_row : [ `Col ] t -> [ `Row ] t

val make : [ `Elem ] t                 -> [ `Grid ] t
val init : (int -> int -> [ `Elem ] t) -> [ `Grid ] t

val get : [ `Grid ] t -> int -> int -> [ `Elem ] t

val fold_left : ('b -> [ `Elem ] t -> 'b) -> 'b -> [ `Grid ] t -> 'b

val iter : ([ `Elem ] t -> unit) -> [ `Grid ] t -> unit

(* juste pour le debuggage *)
val to_int64_matrix : 'a t -> int64 array array
