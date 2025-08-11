# Conkeldurr: Lightweight CSV-to-React Build-Time Content Organisation System

![Conkeldurr](logo.png)

## Summary
This is a domain specific language powered by OCaml that bridges CSV (and soon, maybe other) data into TypeScript files with specific variable names and ordering for build-time importing by a React app, i.e. a build-time content organisation system.

The goal of this project is to stream CSV data as a build-time CDN into a React app. Obviously, the data can be put as
```ts
export const DATA = whatever
```
in some `.ts` file, but that can be difficult to maintain. A spreadsheet is a lot easier.

While that is quite trivial, organisation of some of these values may require specific control over formatting. Therefore, this is a compiler that bridges an s-expression based language to TypeScript:
```ocaml
((ReadConstant ((value (String "ABCDEF")) (var "thing")))
 (ReadConstant ((value (Integer 123)) (var "thing2")))
 (ReadVariable ((value (Float 3.14)) (var "thing3")))
 (ReadSpreadsheet ((var "spreadsheet_123") (interface "INTERFACE_123") (path "./hello")))
 (Export Stdout))
```
and converts it into the file `some_file.ts` that looks like
```ts
export const thing: string = “ABCDEF”;
export const thing2: number = 123;
export let thing3: number = 123;

export interface INTERFACE_123 = {
	…
}

export const spreadsheet_123: Array<INTERFACE_123> = [
	{...},
	{...},
	{...},
]
```
To support types, CSV headers are comma-separated s-expressions like
```
(String colname),(Number colname2)
```

## Todo
- [ ] Implement joins between spreadsheets
- [ ] Implement enum types
- [ ] Improve error messages to be less dense
- [ ] Quotes in CSV rows cause a crash
