# Autograde #

The purpose of autograde is to simplify the "automatable" part of grading user submissions.  The automatable part is comparing the user submissions against a reference implementation for a series of input files.

## Usage ##

The basic usage of autograde is as simple as:

    ./autograde.sh <dir>

With this invocation, the script does the following:

1. Finds the reference implementation in the `reference/` directory
    1. Builds the reference implementation using the user provided `Makefile`
2. Runs the reference implementation through all the files in the `input/` directory
3. Builds, tests, and diffs all the user submissions in the `submissions` directory

The full command is:

    ./autograde.sh [-nsb] DIR [submission1 ... submissionN]

Where the `-n` option maintains the `output/` directory from previous runs, `-s` skips running the reference implementation (and implies the `-n` option), and `-b` skips building all the user submissions from source (if you've added new tests, for example).

The `submission1 ... submissionN` portion allows you to re-run specific user submissions without running through the entire `submissions/` directory.

## Details ##

Since the execution patterns of programs varies on a case-by-case basis, you must create an `executor` command in the directory to "grade."  This command can be as simple as:

    #/bin/bash
    INPUT=$1
    ./executor < $INPUT

This command will be used from the base directory of the reference implantation and the base directory for each user submission.  It can be a very simple script or a more complex program that formats the output.  The `output/` directory will be populated with the output of this command (which should be the direct output of the submission).

Once the output directory is filled with the reference implementation's ("correct") solutions, the script begins running through each sub-directory in the submission directory.  Once a submission is built, it is executed the same way as the reference implementation and the
output is compared to the "correct" solution.  The resulting output is stored in the `output/<name>/` directory and a diff against the reference implementation is stored at `output/<name>.diff`.

Once the diffs are generated you can easily view them and perform the subjective "close enough" test if the two implementations did not match.

## Other Notes ##

During the build process, autograde attempts to use a provided Makefile.  If one does not exist it then attempt to use a default Makefile (`Makefile.default` in the top-level grading directory).

At least one input file must exist in the `input/` directory.

Two examples are provided in the `ex_simple/` and `ex_happy-primes/` directories.  

* The `ex_simple/` example is a simple "Hello, world!" application which demonstrates a simple `executor` script and a user-provided `Makefile` in one of the submissions.  One submission also prints "hello world!" instead of the required "Hello, world!" which will be seen in the diff for subjective grading.
* The `ex_happy-primes/` example is a much more complicated example.  Implementations are written in several languages (from ruby to clojure to C), so the `executor` function detects the input language, decides how it should execute the program (if a `args` file exists in the directory input is provided as a command line argument instead of through `stdin`), and runs the program.  Since many submissions are  scripting languages, the default Makefile does nothing.  When a submission requires building, a Makefile describes how to build the file as one would expect.

