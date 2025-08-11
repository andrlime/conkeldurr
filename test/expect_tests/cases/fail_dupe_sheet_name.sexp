(
	(ReadSpreadsheet ((var "spreadsheet_123") (interface "SomeType") (path (Csv "./data/sample_spreadsheet.csv"))))
	(ReadSpreadsheet ((var "spreadsheet_123") (interface "SomeType2") (path (Csv "./data/sample_spreadsheet.csv"))))
	(Export Stdout)
)
