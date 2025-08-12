(
  ;; ---------- First dataset: menu ----------
  (ReadConstant ((value (String "Lunch Menu")) (var "DATASET_NAME")))
  (ReadConstant ((value (Float 0.1025)) (var "SALES_TAX_RATE")))
  (ReadVariable ((value (Integer 12)) (var "max_items_per_page")))
  
  (ReadSpreadsheet
    ((var "menu")
     (interface "MenuItem")
     (path (Csv "./menu.csv"))))

  (Export (File "./menu.ts"))

  ;; ---------- Add more data: suppliers ----------
  (ReadConstant ((value (String "Supplier List")) (var "DATASET_NAME")))
  (ReadVariable ((value (Integer 12)) (var "max_items_per_page")))
  (ReadSpreadsheet
    ((var "suppliers")
     (interface "Supplier")
     (path (Csv "./suppliers.csv"))))

  (Export (File "./suppliers.ts"))
)
