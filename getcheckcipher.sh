#!/bin/bash

# Usage: getcheckciper.sh "urn:without:checkcipher-fobarbaz"

get_checkcipher() {

    weight=1
    sum=0

    get_charcode() {
      LC_CTYPE=C printf '%d' "'$1"
    }

    urnncs=$(printf '%s\n' ${1} | awk '{ print toupper($0) }')

    code="3947450102030405060708094117############1814191516212223242542262713282931123233113435363738########43"

    for (( i=0; i<${#urnncs}; i++ )); do
      
      codeposi=$(($(get_charcode ${urnncs:$i:1})-45))
      
      sum1=${code:$(($codeposi*2)):1}
      sum2=${code:$(($codeposi*2+1)):1}

      if [ $sum1 -eq 0 ]
      then
        sum=$(($sum+$sum2*$weight))
        weight=$(($weight+1))
      else
        sum=$(($sum+$sum1*$weight))
        weight=$(($weight+1))
        sum=$(($sum+$sum2*$weight))
        weight=$(($weight+1))
      fi
    
    done

    float=$(awk -v a="$sum" -v b="$sum2" 'BEGIN {print a / b }')
    
    echo $((${float%%.*} % 10))
}

get_checkcipher $1
