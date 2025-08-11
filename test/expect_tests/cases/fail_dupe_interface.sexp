(
	(ReadSpreadsheet ((var "spreadsheet_123") (interface "SomeType") (path (Csv "./data/sample_spreadsheet.csv"))))
	(ReadSpreadsheet ((var "spreadsheet_456") (interface "SomeType") (path (Csv "./data/sample_spreadsheet.csv"))))
	(Export Stdout)
)
