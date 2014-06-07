let _ = exit 0;;
#load "GridCore.cmo";;
#load "Grid.cmo";;

let g = Grid.init (fun i j -> Grid.of_int64_unsafe (if i = j then 1L else 0L))
let _ = Grid.output_grid stdout g


let ((c1, c2, c3, c4) as q) = Grid.cols g
let _ = Grid.to_int64_matrix c1
let _ = Grid.to_int64_matrix c2
let _ = Grid.to_int64_matrix c3
let _ = Grid.to_int64_matrix c4


let q2 = Grid.quad_flip q

let g2 = Grid.cols_to_grid q2

let _ = Grid.output_grid stdout g2




let g = Grid.init (fun i j -> Grid.of_int64_unsafe (Int64.of_int j))
let _ = Grid.output_grid stdout g

let ((r1, r2, r3, r4) as q) = Grid.rows g
let _ = Grid.to_int64_matrix r2

let ((c1, c2, c3, c4) as q2) = Grid.quad_apply Grid.row_to_col q
let _ = Grid.to_int64_matrix c2

let g2 = Grid.cols_to_grid q2
let _ = Grid.output_grid stdout g2


let g = Grid.init (fun i j -> Grid.of_int64_unsafe
                                (if i = j then Int64.of_int (i + 1) else 0L))
let _ = Grid.output_grid stdout g
let _ = Grid.to_int64_matrix (Grid.s_h g)
let _ = Grid.to_int64_matrix (Grid.s_v g)
let _ = Grid.to_int64_matrix (Grid.s_o g)


let g = 
  let g = Grid.make (Grid.of_int64_unsafe 0L) in
  let g = Grid.update g 0 0 (Grid.of_int64_unsafe 1L) in
  let g = Grid.update g 0 3 (Grid.of_int64_unsafe 2L) in
  let g = Grid.update g 3 3 (Grid.of_int64_unsafe 3L) in
  let g = Grid.update g 3 0 (Grid.of_int64_unsafe 4L) in
  g
let () = begin
    Grid.print_grid g ;
    Grid.print_grid (Grid.s_horiz g) ;
    flush_all () ;

  end

let () = begin
    Grid.print_grid g ;
    Grid.print_grid (Grid.s_vert g) ;
    flush_all () ;
  end

let () = begin
    Grid.print_grid g ;
    Grid.print_grid (Grid.s_diag g) ;
    flush_all () ;
  end

let () = begin
    Grid.print_grid g ;
    Grid.print_grid (Grid.s_adiag g) ;
    flush_all () ;
  end

let () = begin
    Grid.print_grid g ;
    Grid.print_grid (Grid.s_cent g) ;
    flush_all () ;
  end

let () = begin
    Grid.print_grid g ;
    Grid.print_grid (Grid.r_plus g) ;
    flush_all () ;
  end

let () = begin
    Grid.print_grid g ;
    Grid.print_grid (Grid.r_minus g) ;
    flush_all () ;
  end
