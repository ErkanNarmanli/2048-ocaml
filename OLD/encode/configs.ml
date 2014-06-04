module type configs = sig
    type t = int
    type rep = int array array
    val n : int
    val rep_case_to_int : t -> int
    val int_to_rep_case : int -> t
    val from_rep : int array array -> t
    val to_rep : t -> int array array
  end


(* finalement je ne pense pas que la place soit le pb... mais bonm trop tard ... *)
let get_module n =
  let module M = struct
    type t = int (* /!\ si on est en 64 bits, int suffit, sinon Int64 bits *)
    (* TODO : faire un test ... *)
    (* TODO : plus un test sur n de la capacité de int ... *)
    
    type rep = int array array

    (* version sans tests (opti) ; attention trash *)
    let n = n

    let rep_case_to_int k =
      let rec f acc x =
        if x = 1 then acc else
          f (acc + 1) (x lsr 1)
      in if k = 0 then 0 else f 0 k
                                
    let int_to_rep_case k =
      let rec f acc x =
        if x = 0 then acc else
          f (acc lsl 1) (x - 1)
      in if k = 0 then 0 else f 1 k
                                
                                
    let from_rep m = 
      let rec g res i j =
        if i >= 0 then
          if j >= 0 then
            g (res + (rep_case_to_int m.(i).(j))
                     * (Utils.pow 12 (n * i + j))) i (j - 1)
          else
            g res (i - 1) (n - 1)
        else res
      in
      g 0 (n - 1) (n - 1)
        
        
    let to_rep k =
      let acc = ref k in
      Array.init n (fun _ ->
                    Array.init n (fun _ ->
                                  ( let i = int_to_rep_case (!acc mod 12) in
                                    let () = acc := (!acc / 12) in i )))
                 
  end in (module M : configs)
