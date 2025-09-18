# Arithmetic Expression Puzzle Solver

This project implements a solver for an arithmetic expression puzzle that finds a valid expression using given numbers and operations to reach a target value.

## Author Information

| Author Name   | Email                       |
| ------------- | --------------------------- |
| Ibrahim Raimi | ibrahimraimi.tech@gmail.com |

## Problem Description

Given the set of numbers **[3, 8, 11, 19, 25, 75]** and the **target number 462**, the solver constructs an arithmetic expression that:

- Uses each of the numbers at most once
- Uses only the operations `+`, `-`, `*`, `/`
- Can include parentheses as needed
- Evaluates exactly to the target number

## Getting Started

### Prerequisites

- Docker
- Bash 4.0+ (if running locally)
- bc (basic calculator) for arithmetic operations
- Python 3.6+ (for running Python tests)
- pytest (for running Python tests)

### Using Docker (Recommended)

1. Build the Docker image:

   ```bash
   docker build -t arithmetic-puzzle .
   ```

2. Run the container:
   ```bash
   docker run -v ${PWD}:/app arithmetic-puzzle
   ```

The solution will be written to `output.txt` in the current directory.

### Local Development

1. Install dependencies (Ubuntu/Debian):

   ```bash
   sudo apt-get update
   sudo apt-get install -y bc python3 python3-pip
   pip install pytest
   ```

   For other distributions, use the appropriate package manager.

2. Make the solver executable:

   ```bash
   chmod +x solution.sh
   ```

3. Run the solver:
   ```bash
   ./solution.sh
   ```

## Running Tests

The project includes multiple testing approaches for comprehensive validation:

### Bash Tests

For testing individual functions and the complete solution:

```bash
bash run-test.sh
```

This will test:

- Basic arithmetic evaluation
- Parentheses handling
- Invalid expressions
- Element containment
- Expression generation
- Output file creation

### Python Tests

For validating the final output and expression correctness:

```bash
pytest tests/test_outputs.py
```

The Python tests verify:

1. Output file existence
2. Expression syntax (valid characters only)
3. Number usage (only allowed numbers used once)
4. Expression evaluation (equals target value 462)

## Solution Approach

The solver uses a combination of:

1. Pattern-based expression generation for common arithmetic structures
2. Built-in Bash arithmetic and bc for precise calculations
3. Systematic testing of operator combinations
4. Smart pattern matching for efficient solution search

## Notes

- Uses bc for precise floating-point arithmetic
- Handles division by zero and invalid expressions gracefully
- Implements a systematic search through possible expression patterns
- Solution is output as a single-line expression to `/app/output.txt`
- All arithmetic operations are POSIX-compliant
