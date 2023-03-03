
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
mkdir student-submission
git clone $1 student-submission
echo 'Finished cloning'
cd student-submission
if [[ -e ListExamples.java ]]
then 
    echo 'File found'
else
    echo 'ListExamples.java not found'
    exit 1
fi 

cp ../TestListExamples.java .
#cp ListExamples.java student-submission/
cp -r ../lib .
javac -cp $CPATH *.java 2> javac-errors.txt
if [[ $? -ne 0 ]]
then 
    cat javac-errors.txt
fi
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > grades.txt
grepresults1=`grep "OK (2 tests)" grades.txt`
grepresults2=`grep "Failures: 1" grades.txt`
if [[ $grepresults1 == "OK (2 tests)" ]]
then
    echo "You passed all tests. Grade- 2/2"
elif [[ $grepresults == "Failures: 1" ]]
then
    echo "You failes one test. Grade- 1/2"
else 
    echo "You failed the tests. Grade- 0/2"
fi