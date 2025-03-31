#! /usr/bin/env bash

function getparams() {

    use_sample_input=false

    while getopts :s option
    do
        case $option in
            s) use_sample_input=true;;
            ?) echo -e "Unsupported option \033[031m$OPTARG\033[0m";;
        esac
    done

}


function getInput() {

    # declare -i num # no... not here...

    # Declare variable inside, use them outside:
    if [[ $1 =~ ([[:digit:]]+).sh ]]
    # if [[ $0 =~ ([0-9]+).sh ]]
    then
        num=${BASH_REMATCH[1]}
    else
        echo "Could not determine the input file"
        return
    fi

    if [[ ($# > 1) && $2 = true ]]
    then
        input_file="$(pwd)/inputs/${num}Sample.txt"
    else
      
        input_file="$(pwd)/inputs/$num.txt"
    fi
}
