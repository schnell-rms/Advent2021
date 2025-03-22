#! /usr/bin/env bash

sol02() {
    if [[ ! -e $1 ]]
    then
        printf "Input file $red $1 $stop not found"
        return 1
    fi

    declare -i x=0
    declare -i y=0

    declare -i aim=0
    declare -i y2=0

    while read line || [[ -n $line ]]
    do
        # echo $line
        if [[ $line =~ forward\ ([0-9]+) ]]
        then
            (( x += ${BASH_REMATCH[1]} ))
            (( y2 += $aim * ${BASH_REMATCH[1]} ))
        elif [[ $line =~ down\ ([0-9]+) ]]
        then
            (( y += ${BASH_REMATCH[1]} ))
            (( aim += ${BASH_REMATCH[1]} ))
        elif [[ $line =~ up\ ([0-9]+) ]]
        then
            (( y -= ${BASH_REMATCH[1]} ))
            (( aim -= ${BASH_REMATCH[1]} ))
        else
            printf "Unexpected line '$red$line$stop'\n"
        fi
    done < $1

    printf "Forward 1&2: $x\n"
    printf "Depth 1: %d\n" $y
    printf "Part1 %d\n" $(($x * $y))
    printf "Depth 2: %d\n" $y2
    printf "Aim 2: %d\n" $aim
    printf "Part2 %d\n" $(($x * $y2))
    return 0
}

main() {

    printf "Running $0\n"

    red="\033[31m"
    stop="\033[0m"

    use_sample_input=false
    while getopts :s option
    do
        case $option in
            s) use_sample_input=true;;
            ?) echo -e "Unknown option $red'$OPTARG'$stop";;
        esac
    done

    file_path=$(pwd)
    file_path+="/inputs/"

    # Just for the sake of exercising:
    if [[ $0 =~ ([0-9]+).sh ]]
    then
        file_path+=${BASH_REMATCH[1]}
    else
        echo "Could not determine the input file based on the script's name"
        exit
    fi

    if $use_sample_input
    then
        file_path+="Sample"
    fi

    file_path+=".txt"

    sol02 $file_path
}

main $@
