#!/bin/bash
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
# date: 2014-10-08

flag=false
lines=$(wc -l $1 | sed -e 's/^  *//g' | cut -d ' '  -f 1)
j=1
for line in `cat $1`;
    do
        if [ `echo $line | grep ">"` ]; then
            if $flag; then
                echo $seq
                for val in ${array[@]}; do
                    let sum+=$val
                done
                echo "gc%: $(echo "scale=4; ((${array[2]}+${array[3]}) / $sum) * 100" | bc | cut -c 1-5)"
                sum=0
                array=()
            fi
            seq=$line
            flag=true
        else
            tmp=($(echo $line | sed -e 's/\(.\)/\1\n/g' | grep "[ATGC]" | sort | uniq -c | sed -e 's/^  *//g' | cut -d ' ' -f 1))
            i=1
            for val in ${tmp[@]}; do
                let result=${array[$i]}+$val
                array[$i]=$result
                let i++
            done
            if [ $lines -eq $j ]; then
                for val in ${array[@]}; do
                    let sum+=$val
                done
                echo $seq
                echo "gc%: $(echo "scale=4; ((${array[2]}+${array[3]}) / $sum) * 100" | bc | cut -c 1-5)"
            fi
        fi
        let j++
    done
