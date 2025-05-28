(lang dune 3.18)

(name conkeldurr)

(generate_opam_files true)

(source
 (github andrlime/conkeldurr))

(authors "Andrew Li <andrewli@u.northwestern.edu>")
(maintainers "Andrew Li <andrewli@u.northwestern.edu>")

(license MIT)

(package
 (name conkeldurr)
 (synopsis "CSV to React build-time content streamer")
 (description "Injects static content to static pages without needing to modify frontend code by compiling CSV schema to Typescript object arrays.")
 (depends dune ocaml ocamlformat ounit2 csv core_unix)
 (tags
  ("ocaml" "dsl" "cli" "codegen" "csv" "aws" "compiler" "react")))
