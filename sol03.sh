#! /usr/bin/env bash

. ./utils.sh

# Gets the numbers and the start bit to look for
# findRating all0s all1s startbit(0 or 1)
function findRating() {

    local -i key=$(( $1 == 0 ? 0 : 1 ))

    local -a rs=("${alllines[@]}")

    len=${#alllines[0]}
    bit=0

    while [[ $bit -lt len ]]
    do
        declare -a rKeys=() rNonKeys=()
        for ((i=0; i<${#rs[@]}; i++))
        do
            if [[ ${rs[$i]:$bit:1} == $key ]]
            then
                rKeys+=(${rs[i]})
            else
                rNonKeys+=(${rs[i]})
            fi
        done

        if [[   "${#rKeys[@]}" -ge "${#rNonKeys[@]}" && key -eq 1 ||
                "${#rKeys[@]}" -le "${#rNonKeys[@]}" && key -eq 0
            ]]
        then
            rs=("${rKeys[@]}")
        else
            rs=("${rNonKeys[@]}")
        fi

        if [[ ${#rs[@]} -eq 1 ]]
        then
            # echo "Last one: ${rs[@]}"
            # binaryToDecimal ${rs[0]}
            # echo $decimal
            # rating=$decimal
            # OR:
            binaryToDecimal ${rs[0]} rating
            break
        fi

        (( bit++ ))
    done
}

function solvePart2() {

    findRating 1
    oxigen_generator_rating=$rating #or even $decimal
    findRating 0
    co2_scrubber_rating=$rating

    echo
    echo "Oxigen: ${oxigen_generator_rating}"
    echo "CO2: $co2_scrubber_rating"
    echo "Life support rating: $(( $oxigen_generator_rating * $co2_scrubber_rating ))"
}

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

    declare -a alllines

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

        alllines+=($line)

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

# Part 2
    solvePart2
}

main $@
