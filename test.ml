let _ = exit 0;;
#load "GridCore.cmo";;
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

let _ = Grid.to_int64_matrix g2




let g = Grid.init (fun i j -> Grid.of_int64_unsafe (Int64.of_int j))
let _ = Grid.to_int64_matrix g

let ((r1, r2, r3, r4) as q) = Grid.rows g
let _ = Grid.to_int64_matrix r2

let ((c1, c2, c3, c4) as q2) = Grid.quad_apply Grid.row_to_col q
let _ = Grid.to_int64_matrix c2

let g2 = Grid.cols_to_grid q2
let _ = Grid.to_int64_matrix g2


let g = Grid.init (fun i j -> Grid.of_int64_unsafe
                                (if i = j then Int64.of_int (i + 1) else 0L))
let _ = Grid.to_int64_matrix g
let _ = Grid.to_int64_matrix (Grid.s_h g)
let _ = Grid.to_int64_matrix (Grid.s_v g)
let _ = Grid.to_int64_matrix (Grid.s_o g)
