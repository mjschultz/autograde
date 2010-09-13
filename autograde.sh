#!/bin/bash

# usage: ./autograde.sh [-n] [-s] [-b] DIR [submission1 ... submissionN]
# Grades homework assignments in DIR against a reference implementation.  A
# list of submissions will only test those submissions instead of all
# submissions (this implies -n).
#  -n don't obliterate old output files
#  -s skip running reference implementation [implies -n, output must exist]
#  -b skip building submissions from source
#
# Autograde looks in a specified directory for:
#  1) Reference implementation (sub-directory: reference)
#  2) Example input files (sub-directory: input)
#  3) Student submissions (sub-directory: submissions)
#  4) A program that tests the reference/solution (filename: executor)
#
# When first executed, autograde will compile (run `make`) the reference
# implementation.  Once the refernce is completed, it will run over all the
# example input files as follows:
#  ./executor [input-file] > [output-file]
# Where input-file is a file in the input/ sub-directory and will create
# output-file in the output/reference/ sub-directory.
# The "executor" program can be as simple as:
#  #!/bin/bash
#  INPUT=$1
#  ./binary-name < $INPUT
# Allowing multiple binaries to be tested against the same input and allows
# customization to your heart's content.
#
# Once the output directory is filled with the reference implementation's
# ("correct") solutions, the script begins running through each
# sub-directory in the submission directory.  Once a submission is built,
# it is executed the same way as the reference implementation and the
# output is compared to the "correct" solution.  The resulting output and
# diff are stored in output/<name>/.

DIFF_OPTS="-wB"

PROGRAM=$0
while getopts "nsb" flag ; do
    echo $flag $OPTIND $OPTARG
    case $flag in
        n) SAVE_OUT="save" ;;
        s) SKIP_REF="skip" ; SAVE_OUT="save" ;;
        b) SKIP_BUILD="skip" ;;
        *) usage "no such argument $flag"
    esac
done
shift $(($OPTIND-1))

function error {
	echo "error: $1" 1>&2
}

function usage {
    echo "usage: ${PROGRAM} [-nsb] DIR [submission1 ... submissionN]"
    echo
    echo "Grade homework assignments in DIR against a reference implementation.  A list of"
    echo "submissions after DIR tests only those submissions instead of all submissions"
    echo "giving an implicit -n."
    echo -e "\t-n don't obliterate old output files"
    echo -e "\t-s skip running reference implementation [implies -n, output must exist]"
    echo -e "\t-b skip building submissions from source"
	if [ -n "$1" ] ; then
		echo
        error "$1"
	fi
	exit 1
}

function buildit {
    LOCATION=$1
    # Build an implementation
    pushd $LOCATION > /dev/null
    if [ -f [Mm]akefile ] ; then
        # Use provided Makefile by default
        make
    elif [ -f $DIR/Makefile.default ] ; then
        # Try to use a default Makefile
        cp $DIR/Makefile.default Makefile
        make
        rm -f Makefile
    else
        error "could not build solution (${LOCATION/*\/})"
    fi
    popd > /dev/null
}

function testit
{
    LOCATION=$1
    NAME=${LOCATION/*\/}
    pushd $LOCATION > /dev/null
    # Build up the output files
    mkdir -p $DIR/output/$NAME
    for input in $DIR/input/* ; do
        $DIR/executor $input > $DIR/output/$NAME/`basename $input` 2>&1
    done
    popd > /dev/null
}

function diffit
{
    LOCATION=$1
    NAME=${LOCATION/*\/}
    # Build up the output files
    ( echo -n "($NAME) " ; date ) > $DIR/output/$NAME.diff
    for input in $DIR/input/* ; do
        input=`basename $input`
        LEFT="$DIR/output/reference/$input"
        RIGHT="$DIR/output/$NAME/$input"
        echo "Test: $input" >> $DIR/output/$NAME.diff
        diff $DIFF_OPTS "$LEFT" "$RIGHT" >> $DIR/output/$NAME.diff 2>&1
    done
}

if [ $# -lt 1 ] ; then
	usage "missing arguments"
fi

DIR="`pwd`/$1"
shift 1
SUBMISSIONS=$@

# Make sure the correct structure is in place
if [ ! -d $DIR ] ; then
	usage "'$DIR' does not exist"
elif [ ! -d $DIR/reference ] ; then
	usage "reference directory does not exist"
elif [ ! -d $DIR/input ] ; then
	usage "input directory does not exist"
elif [ $(ls -U $DIR/input | wc -l) -lt 1 ] ; then
    usage "input directory has no input files"
elif [ ! -d $DIR/submissions ] ; then
	usage "submissions directory does not exist"
elif [ ! -x $DIR/executor ] ; then
	usage "executor program does not exist or is not executable"
fi

# Set up submissions to look through
if [ -z "$SUBMISSIONS" ] ; then
    SUBMISSIONS=$DIR/submissions/*
else
    SAVE_OUT="save"
fi

# cleanup anything from previous runs
if [ -z "$SAVE_OUT" ] ; then
    rm -rf $DIR/output
else
    echo "output saved"
fi

if [ -z "$SKIP_REF" ] ; then
    buildit $DIR/reference
    testit $DIR/reference
else
    echo "skipped reference"
fi

for submission in $SUBMISSIONS ; do
    if [ ! -d $submission ] ; then
        submission=`pwd`/$submission
    fi
    if [ ! -d $submission ] ; then
        submission=$DIR/submissions/`basename $submission`
    fi
    if [ -f $submission ] ; then
        continue
    fi
    if [ ! -d $submission ] ; then
        error "could not find `basename $submission`"
        continue
    fi
    echo $submission
    if [ -z $SKIP_BUILD ] ; then
        buildit $submission
    fi
    testit $submission
    diffit $submission
done
