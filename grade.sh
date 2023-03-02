CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

if [[ -f ./student-submission/ListExamples.java ]]
then
    echo 'ListExamples.java found'
else
    echo 'ListExamples.java not found. Please try again.'
    exit 1
fi

cp ./student-submission/ListExamples.java ./

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java 2>compile-err.txt

if [[ $? -ne 0 ]]
then
    echo 'Error compiling. Please try again.'
    exit 1
fi

java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > res.txt

FAILREP=`grep "Failures: " res.txt`

NUMFAILS=${FAILREP:25:1}

echo --------

if [ -z "$NUMFAILS" ]
then
    echo "You passed all the tests."
else
    echo "$NUMFAILS failure(s) found."
    echo --------
    echo "Because there was $NUMFAILS failure(s), you failed."
fi