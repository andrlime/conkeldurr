(* Some useful file system utils *)
module Files : sig
  val get_absolute_file_path : string -> string
  val is_valid_path : string -> bool
  val set_working_directory : string -> string
end

val read_file : string -> string
val write_file : string -> string -> unit
