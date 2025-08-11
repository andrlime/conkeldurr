(
	(Import ((var SomeEnum) (from some-file.ts)))
	(Import ((var SomeOtherEnum) (from some-other-file.ts)))
	(ReadConstant ((var "dataset_name") (value (String "PEOPLE_NAMES"))))
	(ReadSpreadsheet ((var "people_names") (interface "Person") (path (Csv "./data/sample_spreadsheet_medium.csv"))))
	(Export Stdout)
)
