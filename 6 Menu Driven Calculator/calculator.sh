clear
sum=0
i="y"

while [ $i = "y" ]
do

echo "Enter num1 : "
read n1
echo "Enter num2 : "
read n2

echo "1. Addition"
echo "2. Subtraction"
echo "3. Dvision"
echo "4. Multiplication"
echo "Choice ?"
read choice

case $choice in
 1) ans=`expr $n1 + $n2`;;
 2) ans=`expr $n1 - $n2`;;
 3) ans=`expr $n1 / $n2`;;
 4) ans=`expr $n1 \* $n2`;;
 *) echo "Invalid choice";;
esac

echo "Answer : $ans"
echo "Do you want to continue ?"
read i
if [ $i != "y" ]
then
 exit
fi
done
