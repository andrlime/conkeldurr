open Conkeldurr

let%expect_test "end to end test setup" = Sys.chdir "./cases"

let%expect_test "passes basic end to end test" =
  Entry.entry_point "basic_program_test.sexp";
  [%expect
    {|
    import { SomeEnum } from "some-file.ts";
    export const thing2: number = 123;
    export const thing5: string = "a afsdafds afsdsa";
    export const thing: string = "ABCDEF";
    export let thing3: number = 3.14;
    export interface SomeType {
    a: string;
    b: string;
    c: string;
    ab: number;
    bc: number;
    cd: boolean;
    };

    export const spreadsheet_123: Array<SomeType> = [
    { a: "A", b: "B", c: "C", ab: 1., bc: 2, cd: false },
    { a: "D", b: "E", c: "F", ab: 3.1, bc: 33, cd: true }
    ];
    |}]
;;

let%expect_test "passes enums end to end test" =
  Entry.entry_point "enum_program_test.sexp";
  [%expect
    {|
    import { Something } from "some-file.ts";
    export const apple: Fruit = Apple;
    export interface Type {
    a: Something;
    };

    export const SOME_SHEET: Array<Type> = [
    { a: Something.A },
    { a: Something.B },
    { a: C },
    { a: D },
    { a: E }
    ];
    |}]
;;

let%expect_test "passes long end to end test" =
  Entry.entry_point "medium_program_test.sexp";
  [%expect
    {|
    import { SomeEnum } from "some-file.ts";
    import { SomeOtherEnum } from "some-other-file.ts";
    export const dataset_name: string = "PEOPLE_NAMES";
    export interface Person {
    index: number;
    firstname: string;
    lastname: string;
    };

    export const people_names: Array<Person> = [
    { index: 1, firstname: "KMYRYSJI", lastname: "QFVHADCF" },
    { index: 2, firstname: "EJSNVQJD", lastname: "VBRSKMQQ" },
    { index: 3, firstname: "SSQWBDHD", lastname: "NYVGSYBT" },
    { index: 4, firstname: "WEAQZGIE", lastname: "EAENPYEM" },
    { index: 5, firstname: "ETRMYIVI", lastname: "QVRNSTNZ" },
    { index: 6, firstname: "TVXLVNRP", lastname: "MJAQKKDS" },
    { index: 7, firstname: "DSCJUWJH", lastname: "DBTRFEVR" },
    { index: 8, firstname: "NOHKNRWM", lastname: "LHUMAPHX" },
    { index: 9, firstname: "VBALYGIJ", lastname: "GXDXIIJT" },
    { index: 10, firstname: "WUMGKXYX", lastname: "HQTPMGQZ" },
    { index: 11, firstname: "PJUFMSKN", lastname: "DSVDLPIW" },
    { index: 12, firstname: "SLQHECZW", lastname: "BKYTKXQB" },
    { index: 13, firstname: "POUZFKXZ", lastname: "FRQRDHIB" },
    { index: 14, firstname: "BCXYJSVR", lastname: "KDIOLCBA" },
    { index: 15, firstname: "ZWDSEQTA", lastname: "KHWLZTHL" },
    { index: 16, firstname: "HYVQPKYY", lastname: "AXMAHGEC" },
    { index: 17, firstname: "TPRCJUGA", lastname: "GDCMWFKH" },
    { index: 18, firstname: "TZWGMPMC", lastname: "AAROTMYI" },
    { index: 19, firstname: "PDEGDGMY", lastname: "CEEIXREP" },
    { index: 20, firstname: "AISJHBMI", lastname: "NPQXWSEM" },
    { index: 21, firstname: "XCEQEGFG", lastname: "VTDNTVUL" },
    { index: 22, firstname: "XFYKFNPF", lastname: "MSJKMIYO" },
    { index: 23, firstname: "PSZNVWYS", lastname: "ZHSWXHDI" },
    { index: 24, firstname: "IPSKWSGY", lastname: "CTGFDJBQ" },
    { index: 25, firstname: "CZNNWQIR", lastname: "PRDMYEHW" },
    { index: 26, firstname: "ZZDAXQKN", lastname: "IHQQLPRZ" },
    { index: 27, firstname: "UKLYKAHJ", lastname: "YUOAPRES" },
    { index: 28, firstname: "APQYQEGS", lastname: "KITPJJRT" },
    { index: 29, firstname: "RWGAATND", lastname: "BQYGTVSU" },
    { index: 30, firstname: "RNIOVKHY", lastname: "NEVDDNQB" },
    { index: 31, firstname: "OSDTLQTI", lastname: "BTEUFBLZ" }
    ];
    |}]
;;

let%expect_test "passes long end to end test" =
  Entry.entry_point "long_program_test.sexp";
  [%expect
    {|
    import { SomeEnum } from "some-file.ts";
    import { SomeOtherEnum } from "some-other-file.ts";
    import { SomeOtherEnum2 } from "some-other-file.ts";
    export const thing2: number = 123;
    export const thing: string = "ABCDEF";
    export interface SomeType {
    a: string;
    b: string;
    c: string;
    ab: number;
    bc: number;
    cd: boolean;
    };

    export const spreadsheet_123: Array<SomeType> = [
    { a: "A", b: "B", c: "C", ab: 1., bc: 2, cd: false },
    { a: "D", b: "E", c: "F", ab: 3.1, bc: 33, cd: true }
    ];


    export interface SomeType2 {
    a: Type;
    b: string;
    c: string;
    ab: number;
    bc: number;
    cd: boolean;
    de: number;
    };

    export const spreadsheet_456: Array<SomeType2> = [
    { a: Alpha, b: "Beta", c: "Gamma", ab: 0.5, bc: 10, cd: true, de: 3. },
    { a: Delta, b: "Echo", c: "Foxtrot", ab: 1.2, bc: 21, cd: false, de: 7. },
    { a: Giga, b: "Hera", c: "Iota", ab: 2.4, bc: 32, cd: true, de: 5. },
    { a: Juno, b: "Kilo", c: "Lima", ab: 3.7, bc: 43, cd: false, de: 8. },
    { a: Mira, b: "Nova", c: "Orin", ab: 4.1, bc: 54, cd: true, de: 10. },
    { a: Pax, b: "Quin", c: "Rhea", ab: 5.6, bc: 65, cd: false, de: 6. },
    { a: Sera, b: "Tau", c: "Uria", ab: 6.9, bc: 76, cd: true, de: 4. },
    { a: Vega, b: "Will", c: "Xan", ab: 7.3, bc: 87, cd: false, de: 12. },
    { a: Yara, b: "Zane", c: "Aero", ab: 8.4, bc: 98, cd: true, de: 1. },
    { a: Bryn, b: "Cleo", c: "Dane", ab: 9.8, bc: 12, cd: false, de: 14. },
    { a: Faye, b: "Gio", c: "Hale", ab: 0.4, bc: 23, cd: true, de: 9. },
    { a: Iris, b: "Jace", c: "Kara", ab: 1.5, bc: 34, cd: false, de: 2. },
    { a: Liam, b: "Myra", c: "Niko", ab: 2.8, bc: 45, cd: true, de: 11. },
    { a: Odin, b: "Pia", c: "Quon", ab: 3.6, bc: 56, cd: false, de: 7. },
    { a: Ravi, b: "Sia", c: "Taro", ab: 4.9, bc: 67, cd: true, de: 5. },
    { a: Uma, b: "Vian", c: "Wren", ab: 5.3, bc: 78, cd: false, de: 6. },
    { a: Xela, b: "Yuri", c: "Zora", ab: 6.7, bc: 89, cd: true, de: 13. },
    { a: Aris, b: "Bea", c: "Cain", ab: 7.1, bc: 90, cd: false, de: 3. },
    { a: Demi, b: "Evan", c: "Finn", ab: 8.6, bc: 11, cd: true, de: 8. },
    { a: Gale, b: "Hugh", c: "Isla", ab: 9.2, bc: 22, cd: false, de: 10. },
    { a: Jade, b: "Kane", c: "Lior", ab: 0.3, bc: 33, cd: true, de: 6. },
    { a: Milo, b: "Nia", c: "Orla", ab: 1.6, bc: 44, cd: false, de: 4. },
    { a: Pia, b: "Quin", c: "Rey", ab: 2.7, bc: 55, cd: true, de: 15. },
    { a: Sion, b: "Tess", c: "Umar", ab: 3.5, bc: 66, cd: false, de: 1. },
    { a: Vira, b: "Walt", c: "Xena", ab: 4.8, bc: 77, cd: true, de: 12. },
    { a: Yani, b: "Ziv", c: "Alia", ab: 5.4, bc: 88, cd: false, de: 2. },
    { a: Bane, b: "Cira", c: "Dove", ab: 6.5, bc: 99, cd: true, de: 7. },
    { a: Fira, b: "Gio", c: "Hana", ab: 7.9, bc: 13, cd: false, de: 9. },
    { a: Ivo, b: "Juno", c: "Kai", ab: 8.1, bc: 24, cd: true, de: 5. },
    { a: Lira, b: "Mara", c: "Nico", ab: 9.4, bc: 35, cd: false, de: 14. },
    { a: Ola, b: "Pier", c: "Quin", ab: 0.8, bc: 46, cd: true, de: 8. },
    { a: Ria, b: "Seth", c: "Tia", ab: 1.9, bc: 57, cd: false, de: 10. },
    { a: Uri, b: "Vin", c: "Wyn", ab: 2.5, bc: 68, cd: true, de: 6. },
    { a: Xan, b: "Yas", c: "Zed", ab: 3.8, bc: 79, cd: false, de: 3. },
    { a: Alar, b: "Ben", c: "Cia", ab: 4.2, bc: 80, cd: true, de: 11. },
    { a: Dara, b: "Emi", c: "Fel", ab: 5.7, bc: 91, cd: false, de: 1. },
    { a: Gio, b: "Hara", c: "Ian", ab: 6., bc: 12, cd: true, de: 4. },
    { a: Jari, b: "Kel", c: "Lys", ab: 7.4, bc: 23, cd: false, de: 5. },
    { a: Mara, b: "Nel", c: "Oto", ab: 8.7, bc: 34, cd: true, de: 9. },
    { a: Pere, b: "Quor", c: "Rin", ab: 9.1, bc: 45, cd: false, de: 12. },
    { a: Sami, b: "Ton", c: "Uli", ab: 0.6, bc: 56, cd: true, de: 2. },
    { a: Vina, b: "Wes", c: "Xio", ab: 1.8, bc: 67, cd: false, de: 13. },
    { a: Yul, b: "Zara", c: "Aron", ab: 2.9, bc: 78, cd: true, de: 7. },
    { a: Bila, b: "Cato", c: "Dio", ab: 3.3, bc: 89, cd: false, de: 4. },
    { a: Filo, b: "Gavi", c: "Hilo", ab: 4.6, bc: 90, cd: true, de: 10. },
    { a: Isen, b: "Jovi", c: "Kei", ab: 5.1, bc: 11, cd: false, de: 8. },
    { a: Lino, b: "Mano", c: "Navi", ab: 6.8, bc: 22, cd: true, de: 3. },
    { a: Orin, b: "Peli", c: "Quen", ab: 7.6, bc: 33, cd: false, de: 5. },
    { a: Rilo, b: "Sami", c: "Tavi", ab: 8.3, bc: 44, cd: true, de: 9. },
    { a: Una, b: "Vito", c: "Wilo", ab: 9.7, bc: 55, cd: false, de: 11. },
    { a: Xavi, b: "Yani", c: "Zilo", ab: 0.2, bc: 66, cd: true, de: 1. },
    { a: Aden, b: "Bri", c: "Cin", ab: 1.4, bc: 77, cd: false, de: 6. },
    { a: Dion, b: "Eni", c: "Fro", ab: 2.1, bc: 88, cd: true, de: 4. },
    { a: Goro, b: "Hani", c: "Iro", ab: 3.2, bc: 99, cd: false, de: 7. },
    { a: Jiro, b: "Kimo", c: "Liro", ab: 4.5, bc: 13, cd: true, de: 15. },
    { a: Miko, b: "Nero", c: "Oro", ab: 5., bc: 24, cd: false, de: 2. },
    { a: Piro, b: "Quin", c: "Roro", ab: 6.2, bc: 35, cd: true, de: 8. },
    { a: Silo, b: "Toro", c: "Uro", ab: 7.5, bc: 46, cd: false, de: 3. },
    { a: Voro, b: "Wiro", c: "Xoro", ab: 8., bc: 57, cd: true, de: 10. },
    { a: Yoro, b: "Ziro", c: "Aro", ab: 9.3, bc: 68, cd: false, de: 12. },
    { a: Boro, b: "Coro", c: "Dro", ab: 0.1, bc: 79, cd: true, de: 9. },
    { a: Faro, b: "Goro", c: "Horo", ab: 1.7, bc: 80, cd: false, de: 5. },
    { a: Iaro, b: "Jaro", c: "Karo", ab: 2.6, bc: 91, cd: true, de: 13. },
    { a: Laro, b: "Maro", c: "Naro", ab: 3.4, bc: 12, cd: false, de: 2. },
    { a: Oaro, b: "Paro", c: "Qaro", ab: 4., bc: 23, cd: true, de: 4. },
    { a: Raro, b: "Saro", c: "Taro", ab: 5.8, bc: 34, cd: false, de: 11. },
    { a: Uaro, b: "Varo", c: "Waro", ab: 6.6, bc: 45, cd: true, de: 1. },
    { a: Xaro, b: "Yaro", c: "Zaro", ab: 7.2, bc: 56, cd: false, de: 8. },
    { a: Aki, b: "Ben", c: "Cai", ab: 8.9, bc: 67, cd: true, de: 15. },
    { a: Dai, b: "Eli", c: "Fai", ab: 9.5, bc: 78, cd: false, de: 2. },
    { a: Gai, b: "Hui", c: "Iai", ab: 0.7, bc: 89, cd: true, de: 3. },
    { a: Jai, b: "Kai", c: "Lai", ab: 1.1, bc: 90, cd: false, de: 7. },
    { a: Mai, b: "Nai", c: "Oai", ab: 2., bc: 11, cd: true, de: 12. },
    { a: Pai, b: "Qi", c: "Rai", ab: 3., bc: 22, cd: false, de: 9. },
    { a: Sai, b: "Tai", c: "Uai", ab: 4.4, bc: 33, cd: true, de: 10. },
    { a: Vai, b: "Wai", c: "Xai", ab: 5.5, bc: 44, cd: false, de: 6. },
    { a: Yai, b: "Zai", c: "Aei", ab: 6.1, bc: 55, cd: true, de: 4. },
    { a: Bei, b: "Cei", c: "Dei", ab: 7., bc: 66, cd: false, de: 13. },
    { a: Fei, b: "Gei", c: "Hei", ab: 8.5, bc: 77, cd: true, de: 2. },
    { a: Iei, b: "Jei", c: "Kei", ab: 9., bc: 88, cd: false, de: 5. },
    { a: Lei, b: "Mei", c: "Nei", ab: 0.9, bc: 99, cd: true, de: 15. },
    { a: Oei, b: "Pei", c: "Qei", ab: 1.3, bc: 13, cd: false, de: 3. },
    { a: Rei, b: "Sei", c: "Tei", ab: 2.2, bc: 24, cd: true, de: 6. },
    { a: Uei, b: "Vei", c: "Wei", ab: 3.1, bc: 35, cd: false, de: 9. },
    { a: Xei, b: "Yei", c: "Zei", ab: 4.3, bc: 46, cd: true, de: 8. },
    { a: Ato, b: "Bto", c: "Cto", ab: 5.9, bc: 57, cd: false, de: 4. },
    { a: Dto, b: "Eto", c: "Fto", ab: 6.4, bc: 68, cd: true, de: 12. },
    { a: Gto, b: "Hto", c: "Ito", ab: 7.8, bc: 79, cd: false, de: 1. },
    { a: Jto, b: "Kto", c: "Lto", ab: 8.2, bc: 80, cd: true, de: 7. },
    { a: Mto, b: "Nto", c: "Oto", ab: 9.6, bc: 91, cd: false, de: 11. },
    { a: Pto, b: "Qto", c: "Rto", ab: 0., bc: 12, cd: true, de: 3. },
    { a: Sto, b: "Tto", c: "Uto", ab: 1., bc: 23, cd: false, de: 6. },
    { a: Vto, b: "Wto", c: "Xto", ab: 2.4, bc: 34, cd: true, de: 2. },
    { a: Yto, b: "Zto", c: "Avo", ab: 3.7, bc: 45, cd: false, de: 14. },
    { a: Bvo, b: "Cvo", c: "Dvo", ab: 4.1, bc: 56, cd: true, de: 8. },
    { a: Fvo, b: "Gvo", c: "Hvo", ab: 5.6, bc: 67, cd: false, de: 9. },
    { a: Ivo, b: "Jvo", c: "Kvo", ab: 6.9, bc: 78, cd: true, de: 5. },
    { a: Lvo, b: "Mvo", c: "Nvo", ab: 7.3, bc: 89, cd: false, de: 10. },
    { a: Ovo, b: "Pvo", c: "Qvo", ab: 8.4, bc: 90, cd: true, de: 1. },
    { a: Rvo, b: "Svo", c: "Tvo", ab: 9.8, bc: 11, cd: false, de: 12. },
    { a: Uvo, b: "Vvo", c: "Wvo", ab: 0.4, bc: 22, cd: true, de: 13. },
    { a: Xvo, b: "Yvo", c: "Zvo", ab: 1.5, bc: 33, cd: false, de: 6. },
    { a: Ala, b: "Bla", c: "Cla", ab: 2.8, bc: 44, cd: true, de: 4. },
    { a: Dla, b: "Ela", c: "Fla", ab: 3.6, bc: 55, cd: false, de: 15. },
    { a: Gla, b: "Hla", c: "Ila", ab: 4.9, bc: 66, cd: true, de: 7. },
    { a: Jla, b: "Kla", c: "Lla", ab: 5.3, bc: 77, cd: false, de: 2. },
    { a: Mla, b: "Nla", c: "Ola", ab: 6.7, bc: 88, cd: true, de: 11. },
    { a: Pla, b: "Qla", c: "Rla", ab: 7.1, bc: 99, cd: false, de: 3. },
    { a: Sla, b: "Tla", c: "Ula", ab: 8.6, bc: 13, cd: true, de: 10. },
    { a: Vla, b: "Wla", c: "Xla", ab: 9.2, bc: 24, cd: false, de: 8. },
    { a: Yla, b: "Zla", c: "Ama", ab: 0.3, bc: 35, cd: true, de: 5. },
    { a: Bma, b: "Cma", c: "Dma", ab: 1.6, bc: 46, cd: false, de: 9. },
    { a: Fma, b: "Gma", c: "Hma", ab: 2.7, bc: 57, cd: true, de: 15. },
    { a: Ima, b: "Jma", c: "Kma", ab: 3.5, bc: 68, cd: false, de: 2. },
    { a: Lma, b: "Mma", c: "Nma", ab: 4.8, bc: 79, cd: true, de: 14. },
    { a: Oma, b: "Pma", c: "Qma", ab: 5.4, bc: 80, cd: false, de: 1. },
    { a: Rma, b: "Sma", c: "Tma", ab: 6.5, bc: 91, cd: true, de: 6. },
    { a: Uma, b: "Vma", c: "Wma", ab: 7.9, bc: 12, cd: false, de: 4. },
    { a: Xma, b: "Yma", c: "Zma", ab: 8.1, bc: 23, cd: true, de: 7. },
    { a: Ama, b: "Bna", c: "Cna", ab: 9.4, bc: 34, cd: false, de: 12. },
    { a: Dna, b: "Ena", c: "Fna", ab: 0.8, bc: 45, cd: true, de: 9. },
    { a: Gna, b: "Hna", c: "Ina", ab: 1.9, bc: 56, cd: false, de: 10. },
    { a: Jna, b: "Kna", c: "Lna", ab: 2.5, bc: 67, cd: true, de: 3. },
    { a: Mna, b: "Nna", c: "Ona", ab: 3.8, bc: 78, cd: false, de: 8. },
    { a: Pna, b: "Qna", c: "Rna", ab: 4.2, bc: 89, cd: true, de: 11. },
    { a: Sna, b: "Tna", c: "Una", ab: 5.7, bc: 90, cd: false, de: 5. },
    { a: Vna, b: "Wna", c: "Xna", ab: 6., bc: 11, cd: true, de: 2. },
    { a: Yna, b: "Zna", c: "Apa", ab: 7.4, bc: 22, cd: false, de: 15. }
    ];
    |}]
;;

let%expect_test "fails on duplicate variable name" =
  try Entry.entry_point "fail_dupe_variable.sexp" with
  | Failure msg ->
    print_endline msg;
    [%expect {| variable thing already set |}]
;;

let%expect_test "fails on duplicate spreadsheet name" =
  try Entry.entry_point "fail_dupe_sheet_name.sexp" with
  | Failure msg ->
    print_endline msg;
    [%expect {| variable spreadsheet_123 already set |}]
;;

let%expect_test "fails on duplicate interface name" =
  try Entry.entry_point "fail_dupe_interface.sexp" with
  | Failure msg ->
    print_endline msg;
    [%expect {| variable SomeType already set |}]
;;

let%expect_test "fails on duplicate imported modules" =
  try Entry.entry_point "fail_dupe_import.sexp" with
  | Failure msg ->
    print_endline msg;
    [%expect {| variable SomeEnum already set |}]
;;
