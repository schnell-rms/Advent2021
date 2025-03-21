#! /usr/bin/env bash

# set -x

solution() {

    echo "Use $1"

    declare -a numbers

    while read line  || [[ -n "$line" ]]
    do
        numbers+=($line)
    done < $1

    # Part 1
    declare -i counter=0
    for ((i=1; i<${#numbers[@]}; i++))
    do
        if (( ${numbers[$i]} > ${numbers[$i-1]}))
        then
            (( counter++ ))
            # or:
            # counter+=1
        fi
    done

    echo -e "Part 1: $red $counter $stop"

    # Part 2
    declare -i sum3=0
    declare -i counter3=0
    declare -i prevSum=32000
    for ((i=0; i<${#numbers[@]}; i++))
    do
        if (( i >= 3 ))
        then
            prevSum=$sum3
            (( sum3-=${numbers[$i-3]} ))
        fi

        (( sum3+=${numbers[$i]} ))

        if (( sum3 > prevSum ))
        then
            counter3+=1
        fi
    done

    echo -e "Part 2: $red $counter3 $stop"
}

main() {

    useSampleInput=false

    red="\033[31m"
    stop="\033[0m"

    while getopts :s option
    do
        case $option in
            s) useSampleInput=true;;
            ?) echo "unsupported option $red $OPTARG $stop";;
        esac
    done


    sol_number=$(echo $0 | sed "s/[^0-9]//g")

    filename="inputs/$sol_number.txt"
    if $useSampleInput
    then
        filename="inputs/${sol_number}Sample.txt"
    fi
    
    solution $filename
}

main $@
