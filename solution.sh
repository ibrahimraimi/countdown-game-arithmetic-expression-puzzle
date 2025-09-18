#!/bin/bash

# Function to evaluate an arithmetic expression
evaluate() {
    local expr="$1"
    # Use bc for floating-point arithmetic
    result=$(echo "scale=10; $expr" | bc 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "$result"
    else
        echo "error"
    fi
}

# Function to check if a number is in an array
containsElement() {
    local element="$1"
    shift
    for e in "$@"; do
        [[ "$e" == "$element" ]] && return 0
    done
    return 1
}

# Function to generate permutations
# This is a simplified approach that will generate a subset of possible expressions
generate_expressions() {
    local numbers=("$@")
    local len=${#numbers[@]}
    local ops=("+" "-" "*" "/")
    
    # We'll try some common patterns that might yield the target
    local patterns=(
        "(%s %s (%s %s (%s %s %s)))"
        "((%s %s %s) %s (%s %s %s))"
        "(%s %s %s) %s (%s %s %s)"
        "%s %s (%s %s (%s %s %s))"
    )
    
    for pattern in "${patterns[@]}"; do
        for op1 in "${ops[@]}"; do
            for op2 in "${ops[@]}"; do
                for op3 in "${ops[@]}"; do
                    for n1 in "${numbers[@]}"; do
                        local remaining1=("${numbers[@]}")
                        for i in "${!remaining1[@]}"; do
                            if [[ "${remaining1[$i]}" = "$n1" ]]; then
                                unset "remaining1[$i]"
                                break
                            fi
                        done
                        remaining1=("${remaining1[@]}")
                        
                        for n2 in "${remaining1[@]}"; do
                            local remaining2=("${remaining1[@]}")
                            for i in "${!remaining2[@]}"; do
                                if [[ "${remaining2[$i]}" = "$n2" ]]; then
                                    unset "remaining2[$i]"
                                    break
                                fi
                            done
                            remaining2=("${remaining2[@]}")
                            
                            for n3 in "${remaining2[@]}"; do
                                local remaining3=("${remaining2[@]}")
                                for i in "${!remaining3[@]}"; do
                                    if [[ "${remaining3[$i]}" = "$n3" ]]; then
                                        unset "remaining3[$i]"
                                        break
                                    fi
                                done
                                remaining3=("${remaining3[@]}")
                                
                                for n4 in "${remaining3[@]}"; do
                                    local remaining4=("${remaining3[@]}")
                                    for i in "${!remaining4[@]}"; do
                                        if [[ "${remaining4[$i]}" = "$n4" ]]; then
                                            unset "remaining4[$i]"
                                            break
                                        fi
                                    done
                                    remaining4=("${remaining4[@]}")
                                    
                                    for n5 in "${remaining4[@]}"; do
                                        local remaining5=("${remaining4[@]}")
                                        for i in "${!remaining5[@]}"; do
                                            if [[ "${remaining5[$i]}" = "$n5" ]]; then
                                                unset "remaining5[$i]"
                                                break
                                            fi
                                        done
                                        remaining5=("${remaining5[@]}")
                                        
                                        for n6 in "${remaining5[@]}"; do
                                            # Format the expression according to the pattern
                                            expr=$(printf "$pattern" "$n1" "$op1" "$n2" "$op2" "$n3" "$op3" "$n6")
                                            result=$(evaluate "$expr")
                                            
                                            if [ "$result" != "error" ]; then
                                                # Compare with target (allowing for small floating-point differences)
                                                diff=$(echo "scale=10; x=$result-462; if(x<0) -x else x" | bc)
                                                if (( $(echo "$diff < 0.0000001" | bc -l) )); then
                                                    echo "$expr"
                                                    return 0
                                                fi
                                            fi
                                        done
                                    done
                                done
                            done
                        done
                    done
                done
            done
        done
    done
    return 1
}

# Main execution
main() {
    # Define the numbers and target
    numbers=(3 8 11 19 25 75)
    target=462
    
    # Try to find solution
    solution=$(generate_expressions "${numbers[@]}")
    
    if [ -n "$solution" ]; then
        echo "$solution" > /app/output.txt
        exit 0
    else
        echo "No solution found"
        exit 1
    fi
}

# Run main if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi