(* Some useful file system utils *)
module Files : sig
  exception Io_exception of string

  val get_absolute_file_path : string -> string
  val is_valid_path : string -> bool
  val cd : string -> unit
  val set_working_directory : string -> string
end

val read_file : string -> string
val write_file : string -> string -> unit
