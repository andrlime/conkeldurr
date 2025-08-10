(
	(ReadConstant ((var "thing") (value (String "ABCDEF"))))
	(ReadConstant ((var "thing2") (value (Integer 123))))
	(ReadVariable ((var "thing3") (value (Float 3.14))))
	; (ReadSpreadsheet ((var "spreadsheet_123") (interface "INTERFACE_123") (path (Csv "./hello.csv"))))
	(Export Stdout)
	; (File "abc.ts"))
)
