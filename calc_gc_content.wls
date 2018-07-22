#!/usr/bin/env wolframscript -cloud
(* Copyright 2018 Yoshihiro Tanaka *)
(* Licensed under the Apache License, Version 2.0 (the "License"); *)
(* you may not use this file except in compliance with the License. *)
(* You may obtain a copy of the License at *)

(*   http://www.apache.org/licenses/LICENSE-2.0 *)

(* Unless required by applicable law or agreed to in writing, software *)
(* distributed under the License is distributed on an "AS IS" BASIS, *)
(* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. *)
(* See the License for the specific language governing permissions and *)
(* limitations under the License. *)

(* Author: Yoshihiro Tanaka <contact@cordea.jp> *)
(* date  : 2018-07-22 *)

url := ""

fasta := URLDownload[url]
lines = Import[fasta, {"FASTA", "LabeledData"}]

gcContent = Map[Module[{map = Counts[Characters[Last[#]]]}, First[#] -> Interpreter["PercentFraction"][N[(map["G"] + map["C"]) / Total[map]]]] &, lines]

Do[Print[First[x], ": ", Last[x]], {x, gcContent}]
(* Do[Echo[Last[x], First[x] <> ": "], {x, gcContent}] *)
