(
  (ReadConstant ((value (String "Market Tick Demo")) (var "APP_NAME")))
  (ReadConstant ((value (Integer 20250811)) (var "BUILD_ID")))
  (ReadConstant ((value (Float 0.0001)) (var "TICK_SIZE_USD")))

  (ReadVariable ((value (Integer 100)) (var "max_ticks_per_page")))
  (ReadVariable ((value (Float 1.0)) (var "ui_zoom")))

  (ReadSpreadsheet
    ((var "ticks")
     (interface "Tick")
     (path (Csv "./ticks.csv"))))

  (Export (File "ticks.ts"))
)


