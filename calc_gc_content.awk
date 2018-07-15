#!/bin/awk -f
# encoding:utf-8
#
# Copyright 2014-2018 Yoshihiro Tanaka
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
# Author: Yoshihiro Tanaka <contact@cordea.jp>
# date: 2014-10-26

function calc_gc(atgc) {
    sum = 0;
    for (i in atgc) {
        sum += atgc[i]
    }
    gc = ((atgc["G"] + atgc["C"]) / sum)*100
    return gc
}
function plus_atgc(atgc) {
    if (substr($0, i, 1) in atgc) {
        return substr($0, i, 1)
    }
}
{
    if ($0~/^>/) {
        if (length(atgc) > 0) {
            printf("%s%0.2f\n","gc%: ",calc_gc(atgc))
        }
        print $0
        for (i=1; i<=4; ++i) {
            atgc[substr("ATGC", i, 1)] = 0
        }
    }
    else {
        for (i=1; i<=length($0); ++i) {
            ++atgc[plus_atgc(atgc)]
        }
    }
}
END {
    printf("%s%0.2f\n","gc%: ",calc_gc(atgc))
}
