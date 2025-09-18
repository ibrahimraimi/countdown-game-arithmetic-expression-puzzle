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
- BATS (Bash Automated Testing System) for running tests

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
   sudo apt-get install -y bc bats
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

The project includes a comprehensive test suite using BATS (Bash Automated Testing System). To run the tests:

```bash
bats tests/test_solver.bats
```

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
