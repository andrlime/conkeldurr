(
	(Chdir "./data/a")
	(ReadSpreadsheet ((var "sheet1") (interface "interface1") (path (Csv "data.csv"))))
	
	(Chdir "./data/b")
	(ReadSpreadsheet ((var "sheet2") (interface "interface2") (path (Csv "data.csv"))))
	
	(Chdir "./data/c")
	(ReadSpreadsheet ((var "sheet3") (interface "interface3") (path (Csv "data.csv"))))
	
	(Export Stdout)
)
