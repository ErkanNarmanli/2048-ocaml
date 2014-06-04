let _ = exit 0;;
#load "Grid.cmo";;

let g = Grid.init (fun i j -> Grid.of_int64_unsafe (if i = j then 1L else 0L))
let _ = Grid.to_int64_matrix g


let ((c1, c2, c3, c4) as q) = Grid.cols g
let _ = Grid.to_int64_matrix c1
let _ = Grid.to_int64_matrix c2
let _ = Grid.to_int64_matrix c3
let _ = Grid.to_int64_matrix c4


let q2 = Grid.quad_flip q

let g2 = Grid.cols_to_grid q2

let _ = Grid.to_int64_matrix g

