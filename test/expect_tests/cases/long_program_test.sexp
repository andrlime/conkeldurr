(
	(ReadConstant ((var "thing") (value (String "ABCDEF"))))
	(ReadConstant ((var "thing2") (value (Integer 123))))
	(ReadSpreadsheet ((var "spreadsheet_123") (interface "SomeType") (path (Csv "./data/sample_spreadsheet.csv"))))
	(ReadSpreadsheet ((var "spreadsheet_456") (interface "SomeType") (path (Csv "./data/sample_spreadsheet_long.csv"))))
	(Export Stdout)
)
