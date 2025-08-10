# Conkeldurr: Lightweight CSV-to-React Build-Time Content Organisation System

![Conkeldurr](logo.png)

## Summary
This is a domain specific language powered by OCaml that bridges CSV (and soon, maybe other) data into Typescript files with specific variable names and ordering for build-time importing by a React app, i.e. a build-time content organisation system. Additionally, to inject dynamic image content, this app supports uploading images to an AWS S3 bucket to not require importing images in frameworks like Vite.

A nice future direction is to support non-structured data (so like JSON, but in a more human-editable format) and support enum types.

## Overview

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
To minimally support types, the CSV header is modified to look like
```csv
id:number,name:string
```
which indicates that `id` should be number-ified, `name` is a string.. The only raw types that are supported here are `number` and `string`.

The format of all columns must be some alphanumeric/underscore variable name that would be supported by Typescript, followed by a colon and the type. The implication here is that input files are a subset of all CSV files, i.e. not all CSV files are created equal.
