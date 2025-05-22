(lang dune 3.18)

(name timburr)

(generate_opam_files true)

(source
 (github andrlime/timburr))

(authors "Andrew Li <andrewli@u.northwestern.edu>")
(maintainers "Andrew Li <andrewli@u.northwestern.edu>")

(license MIT)

(package
 (name timburr)
 (synopsis "CSV to React build-time content streamer")
 (description "Injects static content to static pages without needing to modify frontend code by compiling CSV schema to Typescript object arrays.")
 (depends dune ocaml ocamlformat ounit2)
 (tags
  ("ocaml" "dsl" "cli" "codegen" "csv" "aws" "compiler" "react")))
