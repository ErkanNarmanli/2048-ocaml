
(* mon pervasives a moi ... ; a revoir en s'inspirant de Core ? *)
(* TODO : a deplacer dans un endroit plus approprié ... *)
(* RQ : \/ ceci est également présent dans Batteries ... *)

module Math = struct
  (* a mon avis, mauvaise facon de cloisonner mais bon ... *)
  let pow a b =
    let rec f b aux res =
      if b = 0 then res else
        if b land 1 = 1 then
          f (b lsr 1) (aux * aux) (res * aux)
        else
          f (b lsr 1) (aux * aux) res
    in f b a 1
end


(* TODO : faire une signature uniforme pour les structures linéaires ! *)
(* instanciée via with type ... *)

module ExtArray = struct
(*  include Array *)

  (* RQ : pas opti au maximum ... *)
  let for_all p a = Array.fold_left (fun res x -> res && p x) true a
  let exists p a = Array.fold_left (fun res x -> p x || res) false a

  let map_inplace f a =
    for i = 0 to Array.length a - 1 do
      a.(i) <- f a.(i)
    done
end
