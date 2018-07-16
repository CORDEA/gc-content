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

function calc_gc_content(arr) {
    sum = 0
    for (i in arr) {
        sum += arr[i]
    }
    gc = ((arr["G"] + arr["C"]) / sum) * 100
    return gc
}
function print_gc_content(gc_content) {
    printf("%s%0.2f\n", "gc%: ", gc_content)
}
function update_arr(arr) {
    char = substr($0, i, 1)
    if (char in arr) {
        ++arr[char]
    }
}
{
    if ($0~/^>/) {
        if (length(arr) > 0) {
            print_gc_content(calc_gc_content(arr))
        }
        print $0
        for (i=1; i<=4; ++i) {
            arr[substr("ATGC", i, 1)] = 0
        }
    }
    else {
        for (i=1; i<=length($0); ++i) {
            update_arr(arr)
        }
    }
}
END {
    print_gc_content(calc_gc_content(arr))
}
