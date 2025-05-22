/**
 * Example static analysis between two types
 * 
 * To type check, simply run tsc filename.ts
 * 
 * Fails if types are not the same
 * 
 * For unit testing purposes, the goal is to dynamically generate this file,
 * run tsc on it, and pass the test if type names are the same, and fail if not
 * 
 * So...
 * - [ ] Generate this file from ocaml
 * - [ ] Run tsc from ocaml
 * - [ ] Use that to write integration tests
 */

export interface InterfaceVariable3 {
    id:number;
    name:string;
    friend:string;
    otherid:number;
};
export interface InterfaceVariable4 {
    name:string;
    otherid:number;
    id:number;
    friend:string;
    friend2:string;
    friend3:string;
    friend4:string;
    friend5:string;
};

type IsSame<T, U> =
  (<G>() => G extends T ? 1 : 2) extends
  (<G>() => G extends U ? 1 : 2) ? true : false;
type Assert<T extends true> = T;

type _ = Assert<IsSame<InterfaceVariable3, InterfaceVariable4>>;
type __ = Assert<IsSame<InterfaceVariable4, InterfaceVariable3>>;
