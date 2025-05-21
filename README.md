# Timburr: Lightweight CSV-to-React Build-Time Content Organisation System

![Timburr](logo.png)

## Summary
This is a domain specific language powered by OCaml that bridges CSV (and soon, maybe other) data into Typescript files with specific variable names and ordering for build-time importing by a React app, i.e. a build-time content organisation system.

## Overview

The goal of this project is to stream CSV data as a build-time CDN into a React app. Obviously, the data can be put as
```ts
export const DATA = whatever
```
in some `.ts` file, but that can be difficult to maintain. A spreadsheet is a lot easier.

While that is quite trivial, organisation of some of these values may require specific control over formatting. Therefore, this is a mini compiler that compiles a file that looks like
```ocaml
const "some constant string" DESTINATION_VARIABLE_1
parse "./data/some_spreadsheet.csv" INTERFACE_VARIABLE_2 DESTINATION_VARIABLE_2
parse "./data/some_other_spreadsheet.csv" INTERFACE_VARIABLE_3 DESTINATION_VARIABLE_3
dump "./output/some_file.ts"
```
into the file `some_file.ts` that looks like
```ts
export const DESTINATION_VARIABLE_1 = "some constant string";
interface INTERFACE_VARIABLE_2 {
    ...
}
export const DESTINATION_VARIABLE_2: Array<INTERFACE_VARIABLE_2> = [
    {...}
]
interface INTERFACE_VARIABLE_3 {
    ...
}
export const DESTINATION_VARIABLE_3: Array<INTERFACE_VARIABLE_3> = [
    {...}
]
```
To minimally support types, the CSV header is modified to look like
```csv
id:number,name:string
```
which indicates that `id` should be number-ified, `name` is a string. The only types that are supported here are `number` and `string`. Columns indicated to be a number but contain any value that is "N/A" or "nan" or "null" will force cast those values to number.

Input variable names can be given in `snake_case`, `CamelCase` or `CAPITAL_SNAKE_CASE`. Interfaces will be converted to `CamelCase` with an optional leading `I`. Variables will be written in `CAPITAL_SNAKE_CASE`. `snake_case` is not used.

## Features Supported
1. `const constant_value` Declares a constant and assigns it to a variable.
2. `parse relative_spreadsheet_path` Reads a CSV spreadsheet, and creates JSON objects for each row. During parsing, this will error if any column contains non-alphanumeric characters.
3. `dump file_name` Exports to a given filename and clears the buffer. At the end of program execution, dump is automatically called with the name of the input file with a `.ts` extension. During program parsing, if any `dump` command includes the name of the input file, the program terminates.

## Future Development
1. Design around other sources of input too, like TSV or SQLite.
2. Support reading from external databases like Postgres and whatnot. This will require writing an engine to query Postgres, MySQL, etc. databases and connect to them.
