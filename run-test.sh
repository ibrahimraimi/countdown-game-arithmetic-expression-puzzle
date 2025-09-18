#!/bin/bash

# Source the solution file
source ./solution.sh

# Test evaluate function
test_evaluate() {
    echo "Testing evaluate function..."
    
    # Test basic arithmetic
    [ "$(evaluate '2 + 2')" = "4" ] && echo "✓ Basic addition passed" || echo "✗ Basic addition failed"
    [ "$(evaluate '10 * 5')" = "50" ] && echo "✓ Basic multiplication passed" || echo "✗ Basic multiplication failed"
    [ "$(evaluate '15 / 3')" = "5" ] && echo "✓ Basic division passed" || echo "✗ Basic division failed"
    
    # Test parentheses
    [ "$(evaluate '(2 + 3) * 4')" = "20" ] && echo "✓ Parentheses test 1 passed" || echo "✗ Parentheses test 1 failed"
    [ "$(evaluate '2 + (3 * 4)')" = "14" ] && echo "✓ Parentheses test 2 passed" || echo "✗ Parentheses test 2 failed"
    
    # Test invalid expressions
    [ "$(evaluate '2 + + 2')" = "error" ] && echo "✓ Invalid expression test passed" || echo "✗ Invalid expression test failed"
    [ "$(evaluate '5 / 0')" = "error" ] && echo "✓ Division by zero test passed" || echo "✗ Division by zero test failed"
}

# Test containsElement function
test_containsElement() {
    echo -e "\nTesting containsElement function..."
    local array=(1 2 3 4 5)
    
    containsElement 3 "${array[@]}"
    [ $? -eq 0 ] && echo "✓ Element found test passed" || echo "✗ Element found test failed"
    
    containsElement 6 "${array[@]}"
    [ $? -eq 1 ] && echo "✓ Element not found test passed" || echo "✗ Element not found test failed"
}

# Test generate_expressions function
test_generate_expressions() {
    echo -e "\nTesting generate_expressions function..."
    numbers=(3 8 11 19 25 75)
    result=$(generate_expressions "${numbers[@]}")
    
    # Check if result is not empty
    [ -n "$result" ] && echo "✓ Expression generated" || { echo "✗ No expression generated"; return 1; }
    
    # Verify result evaluates to target (462)
    evaluated=$(evaluate "$result")
    diff=$(echo "scale=10; x=$evaluated-462; if(x<0) -x else x" | bc)
    [ "$(echo "$diff < 0.0000001" | bc -l)" -eq 1 ] && echo "✓ Expression evaluates to target" || echo "✗ Expression does not evaluate to target"
}

# Test main function
test_main() {
    echo -e "\nTesting main function..."
    # Create temporary directory
    tmp_dir=$(mktemp -d)
    mkdir -p "$tmp_dir/app"
    
    # Run main function in temporary directory
    (cd "$tmp_dir" && main)
    
    # Check output file
    [ -f "$tmp_dir/app/output.txt" ] && echo "✓ Output file created" || { echo "✗ Output file not created"; return 1; }
    
    # Verify output
    result=$(cat "$tmp_dir/app/output.txt")
    evaluated=$(evaluate "$result")
    diff=$(echo "scale=10; x=$evaluated-462; if(x<0) -x else x" | bc)
    [ "$(echo "$diff < 0.0000001" | bc -l)" -eq 1 ] && echo "✓ Output is correct" || echo "✗ Output is incorrect"
    
    # Cleanup
    rm -rf "$tmp_dir"
}

# Run all tests
echo "Running all tests..."
test_evaluate
test_containsElement
test_generate_expressions
test_main
