#! /usr/bin/env bash


. ./utils.sh

main () {

    getparams $@
    # echo "Sample input: '$use_sample_input'"

    getInput $0 $use_sample_input
    # echo "Get input from $input_file"

    read line < $input_file
    
    declare -a count0s count1s

    for (( i=0; i<${#line}; i++ ))
    do
        count0s[i]=0
        count1s[i]=0
    done


    while read line || [[ -n "$line" ]]
    do
        # echo $line
        for (( i=0; i<${#line}; i++))
        do
            case ${line:i:1} in
                0) (( count0s[i]++ ));;
                1) (( count1s[i]++ ));;
                *) echo "Line error: '${line[i]}'. Only 0 or 1 expected"; exit;;
            esac
        done
    done < $input_file

    declare -i gama_rate=0
    declare -i epsilon_rate=0
    declare pw=1

    for (( i=${#count0s[@]} - 1; i>=0; i = i - 1 ))
    do
        if [[ ${count1s[i]} > ${count0s[i]} ]]
        then
            (( gama_rate += pw ))
            # echo "Gama $gama_rate"
        else
            (( epsilon_rate += pw ))
            # echo "Epsilon $epsilon_rate"
        fi
        (( pw *= 2 ))
    done

    echo "Power consumtion (First star): $(($gama_rate * $epsilon_rate))"
}

main $@
