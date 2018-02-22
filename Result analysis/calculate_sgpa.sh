#!/bin/bash
# converting pdf to text
$(pdftotext -layout s1result.pdf)
$(pdftotext -layout s2result.pdf)

# Removing space, comma, special characters
$(tr -d '\040\011\012\015\014\054'< s1result.txt > temp)
# Adding newline character
$(sed -i "s/MDL16/\nMDL16/g" temp)
$(sed -i "s/ELECTRONICS/\nELECTRONICS/g" temp)
# Extract only CS
$(grep "MDL16CS" temp > result_table)

# MA101 PH100 BE110 BE101 BE103 EE100 PH110 EE110 CS110
$(sed -i "s/MA101(/ /g" result_table)
$(sed -i "s/PH100(/ /g" result_table)
$(sed -i "s/BE110(/ /g" result_table)
$(sed -i "s/BE10105(/ /g" result_table)
$(sed -i "s/BE103(/ /g" result_table)
$(sed -i "s/EE100(/ /g" result_table)
$(sed -i "s/PH110(/ /g" result_table)
$(sed -i "s/EE110(/ /g" result_table)
$(sed -i "s/CS110(/ /g" result_table)
$(sed -i "s/)//g" result_table)

# Replacing grades with points
$(sed -i "s/O/10/g" result_table)
$(sed -i "s/A+/9/g" result_table)
$(sed -i "s/A/8/g" result_table)
$(sed -i "s/B+/7/g" result_table)
$(sed -i "s/B/6/g" result_table)
$(sed -i "s/C/5/g" result_table)
$(sed -i "s/P/4/g" result_table)
$(sed -i "s/F/0/g" result_table)

file=result_table
while read line; do 	
	arr=($line) # contains each line with register no. and grades
	MA=`expr ${arr[1]} \* 4`
	PH=`expr ${arr[2]} \* 4`
	BE=`expr ${arr[3]} \* 3`
	BEE=`expr ${arr[4]} \* 3`
	BEEE=`expr ${arr[5]} \* 3`
	EE=`expr ${arr[6]} \* 3`
	ANS=`expr $MA + $PH + $BE + $BEE + $BEEE + $EE + ${arr[7]} + ${arr[8]} + ${arr[9]}`
	$(echo "${arr[0]}" $(printf "%.1f" "$(echo "$ANS/23" | bc -l;)") >> result_final.txt)
done < result_table

$(rm temp result_table s1result.txt s2result.txt)


