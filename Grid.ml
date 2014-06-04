(* module grid ; pour les trucs a optimiser, voir core
   (mais ici c'est plus safe ...) *)

include GridCore

let quad_flip (a1, a2, a3, a4) = (a4, a3, a2, a1)

let quad_apply f (a1, a2, a3, a4) = (f a1, f a2, f a3, f a4)

let s_horiz g = rows_to_grid (quad_flip (rows g))

let s_vert g = cols_to_grid (quad_flip (cols g))

let s_cent g = s_vert (s_horiz g)

let s_diag g = rows_to_grid (quad_apply col_to_row (cols g))

(* tres probablement pas des plus efficace *)
let s_adiag g = s_cent (s_diag g)

(* plus = sens trigo *)
(* TODO : optim en virant des conversions inutiles ... *)
let r_plus g = s_diag (s_vert g)

let r_moins g = s_vert (s_diag g)

(* TODO : TESTER !!!! *)
(* TODO : dans les calcul de l'element canonique, pas faire le bourrin,
   mais plutot réutiliser les calculs intermédiaires *)
(* TODO : element canonique + pretty_print + ... *)
