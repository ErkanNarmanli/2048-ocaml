
let _ = exit 0
#load "utils.cmo"
#load "config.cmo"
  
(* tests *)

let _ = Config.from_rep
          [| [| 0 ; 0 |] ;
             [| 0 ; 0 |] |]
