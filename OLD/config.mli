
type t

val size : t -> int

val to_rep : t -> int array array

val from_rep : int array array -> t
