# Conkeldurr: Lightweight CSV-to-React Build-Time Content Organisation System

![Conkeldurr](logo.png)

## Summary
This is a domain specific language powered by OCaml that bridges CSV (and soon, maybe other) data into Typescript files with specific variable names and ordering for build-time importing by a React app, i.e. a build-time content organisation system. Additionally, to inject dynamic image content, this app supports uploading images to an AWS S3 bucket to not require importing images in frameworks like Vite.

## Overview

The goal of this project is to stream CSV data as a build-time CDN into a React app. Obviously, the data can be put as
```ts
export const DATA = whatever
```
in some `.ts` file, but that can be difficult to maintain. A spreadsheet is a lot easier.

While that is quite trivial, organisation of some of these values may require specific control over formatting. Therefore, this is a mini compiler/interpreter that takes a file that looks like
```ocaml
const "some constant string" DESTINATION_VARIABLE_1
parse "./data/some_spreadsheet.csv" INTERFACE_VARIABLE_2 DESTINATION_VARIABLE_2
parse "./data/some_other_spreadsheet.csv" INTERFACE_VARIABLE_3 DESTINATION_VARIABLE_3
dump "./output/some_file.ts"
```
and converts it into the file `some_file.ts` that looks like
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
id:number,name:string,image_url:image
```
which indicates that `id` should be number-ified, `name` is a string. and `image_url` is a relative path to an image file on disk. The only raw types that are supported here are `number` and `string`. The `image` type is uploaded to an AWS S3 bucket as specified in a config file. Columns indicated to be a number but contain any value that is "N/A" or "nan" or "null" will force cast those values to number. Invalid image URLs will raise an exception.

The format of all columns must be some alphanumeric/underscore variable name that would be supported by Typescript, followed by a colon and the type. The implication here is that input files are a subset of all CSV files, i.e. not all CSV files are created equal.

Input variable names can be given in `snake_case`, `CamelCase` or `CAPITAL_SNAKE_CASE`. Interfaces will be converted to `CamelCase` with an optional leading `I`. Variables will be written in `CAPITAL_SNAKE_CASE`. `snake_case` is not used.

## AWS Config
AWS can be configured at the top of a file via
```
env "AWS_IAM_IDENTITY"
env "AWS_SECRET_KEY"
env "AWS_S3_BUCKET"
env "AWS_BUCKET_PATH"
env "ENV_VARIABLE_NAME" "TARGET_VARIABLE_NAME"
```
If there is one string, then it writes the value to that string for later reference. If there are two strings, then it behaves as `env src dest`. The AWS config keys are hard coded as
```
env "AWS_IAM_IDENTITY"
env "AWS_SECRET_KEY"
env "AWS_S3_BUCKET"
env "AWS_BUCKET_PATH"
```
All files are uploaded to `AWS_S3_BUCKET:AWS_BUCKET_PATH/instance_uuid/uuid()` with a unique ID for each run, and a unique ID for each photo. The
```
flush_bucket
```
command optionally deletes everything within `AWS_BUCKET_PATH`.

## Features Supported
1. `const constant_value:type` Declares a constant and assigns it to a variable. If type is absent, no type annotation is added.
2. `parse relative_spreadsheet_path` Reads a CSV spreadsheet, and creates JSON objects for each row. During parsing, this will error if any column contains non-alphanumeric characters.
3. `dump file_name` Exports to a given filename and clears the buffer. At the end of program execution, dump is automatically called with the name of the input file with a `.ts` extension. During program parsing, if any `dump` command includes the name of the input file, the program terminates.
4. Changes on file stream to the React-or-whatever frontend by bundling file listeners.
5. Read env variables with `ENV VARIABLE_NAME`. Can set these to `AWS_IAM` or `WHATEVER_API`.
6. `flush_bucket` clears everything within `AWS_S3_BUCKET:AWS_BUCKET_PATH`.

## List of all commands
1. `const var:type "value"` outputs `export const VAR: type = "value";`
2. `parse`: parses a spreadsheet with embedded type annotations
3. `dump` flushes output buffer to a given file
4. `env` reads environment variables, currently only used for AWS S3
5. `flush_bucket` deletes everything in a bucket

## Future Development
1. Design around other sources of input too, like TSV or SQLite.
2. Support reading from external databases like Postgres and whatnot. This will require writing an engine to query Postgres, MySQL, etc. databases and connect to them.
