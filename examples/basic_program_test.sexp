(
	(ReadConstant ((var "thing") (value (String "ABCDEF"))))
	(ReadConstant ((var "thing2") (value (Integer 123))))
	(ReadVariable ((var "thing3") (value (Float 3.14))))
	(ReadConstant ((var "thing5") (value (String "a afsdafds afsdsa"))))
	(ReadSpreadsheet ((var "spreadsheet_123") (interface "SomeType") (path (Csv "./data/sample_spreadsheet.csv"))))
	(Export (File test.ts))
)
