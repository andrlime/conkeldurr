(
	(Import ((var Something) (from some-file.ts)))
	(ReadSpreadsheet ((var "SOME_SHEET") (interface "Type") (path (Csv "./data/sample_spreadsheet_enums.csv"))))
	(Export Stdout)
)
