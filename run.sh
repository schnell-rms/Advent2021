#! /usr/bin/env bash

print_help() {
    echo "Advents of Code 2021"
    echo " -h       display this text."
    echo " -d <day> select the day to run."
    echo " -s       to run using the sample input."
}

main() {
    red="\033[31m"
    stop="\033[0m"

    use_sample=false
    is_no_option=true

    declare -i day=01

    while getopts :d:hs option
    do
        case $option in
            d) day=$OPTARG;;
            h) print_help;;
            s) use_sample=true;;
            ?) echo -e "Not an option: $red $OPTARG $stop";;
        esac

        is_no_option=false
    done

    if $is_no_option
    then
        print_help
        exit
    fi

    sol=$(pwd)
    sol+="/sol"
    sol+=$(printf "%02d" $day)
    sol+=".sh"

    if $use_sample
    then
        sol+=" -s"
    fi

    $sol
}

main $@
