(* Added by OPAM. *)
let () =
  try Topdirs.dir_directory (Sys.getenv "OCAML_TOPLEVEL_PATH")
  with Not_found -> ()
;;


#utop_prompt_simple;;

UTop.set_topfind_verbose false;;
(* UTop.set_show_box false;; *)

#use "topfind";;
#thread;;

#require "containers";;
#require "containers.data";;

#require "lambda-term";;
if false then
LTerm_read_line.bind
  [ { LTerm_key.control = false; meta = false; shift = false; code = LTerm_key.Enter } ]
  [ UTop.end_and_accept_current_phrase ]
;;

(* #require "bos.setup";; *)
(* #require "ocp-index-top";; *)

let hex n = Printf.sprintf "0x%x" n;;
let sprintf fmt = Printf.sprintf fmt;;

(* #require "nosetup";; *)

#use "omod.top"
#use "down.top"

#require "rresult";;
#require "bos";;
#require "fpath";;

let (>>) f g x = g (f x)
let (<<) f g x = f (g x)
let flap xs x = List.map ((|>) x) xs
let all xs = List.fold_left (&&) true xs
let filter = List.filter

module R = Rresult.R
let string_contains pattern string = CCString.Find.(find ~pattern:(compile pattern)) string <> -1
let contains needle file = Bos.OS.File.read (Fpath.v file) |> R.get_ok |> string_contains needle
let files dir = Bos.OS.Dir.fold_contents ~elements:`Files (List.cons) [] (Fpath.v dir) |> R.get_ok |> List.map Fpath.to_string
(* files "." |> filter (all << flap [contains "build"; contains "@doc"; not << contains "odoc"]);; *)

let () = UTop.history_file_name := Some (Filename.concat (Unix.getenv "HOME") ".cache/utop-history")
