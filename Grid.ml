(* module grid ; pour les trucs a optimiser, voir core
   (mais ici c'est plus safe ...) *)

include GridCore

let quad_flip (a1, a2, a3, a4) = (a4, a3, a2, a1)

let quad_apply f (a1, a2, a3, a4) = (f a1, f a2, f a3, f a4)




(* TODO : transformations + comparaison + pretty_print + ... *)
