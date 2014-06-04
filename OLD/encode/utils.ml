

let pow a b =
  let rec f b aux res =
    if b = 0 then res else
      if b land 1 = 1 then
        f (b lsr 1) (aux * aux) (res * aux)
      else
        f (b lsr 1) (aux * aux) res
  in f b a 1

