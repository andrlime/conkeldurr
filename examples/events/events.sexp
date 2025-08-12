(
  (ReadConstant ((value (String "Training Portal")) (var "APP_NAME")))
  (ReadConstant ((value (Integer 20250811)) (var "BUILD_ID")))
  (ReadVariable ((value (Integer 10)) (var "max_rows_per_page")))

  (ReadSpreadsheet
    ((var "training_sessions")
     (interface "TrainingSession")
     (path (Csv "./events.csv"))))

  (Export (File events.ts))
)
