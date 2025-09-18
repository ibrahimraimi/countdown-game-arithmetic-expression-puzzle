#!/usr/bin/env bats

setup() {
    load "./solution.sh"
}

@test "evaluate function handles basic arithmetic" {
    result=$(evaluate "2 + 2")
    [ "$result" = "4" ]
    
    result=$(evaluate "10 * 5")
    [ "$result" = "50" ]
    
    result=$(evaluate "15 / 3")
    [ "$result" = "5" ]
}

@test "evaluate function handles parentheses" {
    result=$(evaluate "(2 + 3) * 4")
    [ "$result" = "20" ]
    
    result=$(evaluate "2 + (3 * 4)")
    [ "$result" = "14" ]
}

@test "evaluate function handles invalid expressions" {
    result=$(evaluate "2 + + 2")
    [ "$result" = "error" ]
    
    result=$(evaluate "5 / 0")
    [ "$result" = "error" ]
}

@test "containsElement function works correctly" {
    array=(1 2 3 4 5)
    run containsElement 3 "${array[@]}"
    [ "$status" -eq 0 ]
    
    run containsElement 6 "${array[@]}"
    [ "$status" -eq 1 ]
}

@test "generate_expressions finds valid solution" {
    numbers=(3 8 11 19 25 75)
    result=$(generate_expressions "${numbers[@]}")
    # Verify that result is not empty
    [ -n "$result" ]
    # Verify that result evaluates to target (462)
    evaluated=$(evaluate "$result")
    diff=$(echo "scale=10; x=$evaluated-462; if(x<0) -x else x" | bc)
    [ "$(echo "$diff < 0.0000001" | bc -l)" -eq 1 ]
}

@test "main function creates output file" {
    # Create temporary directory for test
    tmp_dir=$(mktemp -d)
    mkdir -p "$tmp_dir/app"
    
    # Run main function
    (cd "$tmp_dir" && main)
    
    # Check if output file exists and contains valid expression
    [ -f "$tmp_dir/app/output.txt" ]
    result=$(cat "$tmp_dir/app/output.txt")
    evaluated=$(evaluate "$result")
    diff=$(echo "scale=10; x=$evaluated-462; if(x<0) -x else x" | bc)
    [ "$(echo "$diff < 0.0000001" | bc -l)" -eq 1 ]
    
    # Cleanup
    rm -rf "$tmp_dir"
}