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

__Author__ = "Yoshihiro Tanaka <contact@cordea.jp>"
__date__ = "2014-10-09"

import sys


class Nucleobase:
    def __init__(self):
        self.reset()

    def update(self, char):
        self.can_calculate = True
        if char.lower() == 'a':
            self.__adenine += 1
        elif char.lower() == 't':
            self.__thymine += 1
        elif char.lower() == 'g':
            self.__guanine += 1
        elif char.lower() == 'c':
            self.__cytosine += 1
        else:
            self.__other += 1

    def reset(self):
        self.__adenine = 0
        self.__thymine = 0
        self.__guanine = 0
        self.__cytosine = 0
        self.__other = 0
        self.can_calculate = False

    def calculate(self):
        return (self.__guanine + self.__cytosine) / float(
            self.__adenine + self.__thymine + self.__guanine + self.__cytosine)


infile = open(sys.argv[1], "r")
lines = infile.readlines()
infile.close()

base = Nucleobase()
fflag = False
lst = []

for l in range(len(lines)):
    line = lines[l]
    if ">" in line:
        if base.can_calculate:
            print("gc%: " + str(base.calculate()))
            base.reset()
        sys.stdout.write(line)
    else:
        for char in line:
            base.update(char)

print("gc%: " + str(base.calculate()))
