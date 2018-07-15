#!/usr/bin/env python
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

__Author__ =  "Yoshihiro Tanaka <contact@cordea.jp>"
__date__   =  "2014-10-09"

import sys
infile = open(sys.argv[1], "r")
lines = infile.readlines()
infile.close()
atgc = ['A', 'T', 'G', 'C']
fflag = False
lst = []
for l in range(len(lines)):
    line = lines[l]
    if ">" in line:
        if fflag:
            sys.stdout.write(seq)
            print("gc%: " + str( (lst[2]+lst[3]) / float(sum(lst)) ))
            lst = []
        seq = line
        fflag = True
    else:
        for i in range(len(atgc)):
            try:
                lst[i] += line.count(atgc[i])
            except:
                lst.append(line.count(atgc[i]))
sys.stdout.write(seq)
print("gc%: " + str( (lst[2]+lst[3]) / float(sum(lst)) ))
