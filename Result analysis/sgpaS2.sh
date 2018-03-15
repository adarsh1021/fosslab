#!/bin/bash
# get result file as argument
result="$1"

# converting pdf to text
$(pdftotext -layout $result)
txtfile="${result%.*}.txt"
resultfile="SGPA_${result%.*}.txt"

# Removing space, comma, special characters
$(tr -d '\040\011\012\015\014\054'< $txtfile > temp)
# Adding newline character
$(sed -i "s/MDL16/\nMDL16/g" temp)
$(sed -i "s/TCE/\nTCE/g" temp)
# Extract only CS
$(grep "MDL16CS" temp > result_table)

# MA101 PH100 BE110 BE101 BE103 EE100 PH110 EE110 CS110
$(sed -i "s/CY100(/ /g" result_table)
$(sed -i "s/BE100(/ /g" result_table)
$(sed -i "s/EC100(/ /g" result_table)
$(sed -i "s/CY110(/ /g" result_table)
$(sed -i "s/EC110(/ /g" result_table)
$(sed -i "s/MA102(/ /g" result_table)
$(sed -i "s/BE102(/ /g" result_table)
$(sed -i "s/CS100(/ /g" result_table)
$(sed -i "s/CS120(/ /g" result_table)
$(sed -i "s/)//g" result_table)

# Replacing grades with points
$(sed -i "s/O/10/g" result_table)
$(sed -i "s/A+/9/g" result_table)
$(sed -i "s/A/8.5/g" result_table)
$(sed -i "s/B+/8/g" result_table)
$(sed -i "s/B/7/g" result_table)
$(sed -i "s/C/6/g" result_table)
$(sed -i "s/P/5/g" result_table)
$(sed -i "s/F/0/g" result_table)

# clearing the contents of the file incase it exists
$(echo -n > $resultfile)

while read line; do 	
	arr=($line) # contains each line with register no. and grades
	CY100=$(bc <<< "scale=2; (${arr[1]})*4")
	BE100=$(bc <<< "scale=2; (${arr[2]})*4")
	EC100=$(bc <<< "scale=2; (${arr[3]})*3")
	CY110=$(bc <<< "scale=2; (${arr[4]})*1")
	EC110=$(bc <<< "scale=2; (${arr[5]})*1")
	MA102=$(bc <<< "scale=2; (${arr[6]})*4")
	BE102=$(bc <<< "scale=2; (${arr[7]})*3")
	CS100=$(bc <<< "scale=2; (${arr[8]})*3")
	CS120=$(bc <<< "scale=2; (${arr[9]})*1")
	ANS=$(bc <<< "scale=2; ($CY100)+($BE100)+($EC100)+($CY110)+($EC110)+($MA102)+($BE102)+($CS100)+($CS120)")
	$(echo "${arr[0]}" $(printf "%.1f" "$(echo "$ANS/24" | bc -l;)") >> $resultfile)
done < result_table

$(sed -i "s/MDL166S/MDL16CS/g" $resultfile)

# cleaning up
$(rm -f temp result_table)


