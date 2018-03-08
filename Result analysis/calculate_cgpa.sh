#!/bin/bash
s1="$1"
s2="$2"

$(paste $s1 $s2 > temp)

$(echo -n > tempresult)

while read line; do 	
	arr=($line)
	cgpa=$(printf "%.1f" "$(echo "((${arr[1]} * 23) + (${arr[3]} * 24))/47" | bc -l)")
	$(echo "${arr[0]} ${arr[1]} ${arr[3]} $cgpa" >> tempresult)	
done < temp

# clearing temp file
$(echo -n > temp)
# moving only MDL roll numbers
$(cat c4b.txt | grep MDL > temp) 

# clearing RESULT file
$(echo -n > res)
while read line; do 
	# reading each row from class
	arr=($line)
	student=($(cat tempresult | grep "${arr[5]}"))
	$(echo -e "${arr[5]} | ${arr[6]} ${arr[7]} ${arr[8]} | ${student[1]} | ${student[2]} | ${student[3]}" >> res)
done < temp

# cleaning up the result
$(cat res | column -t -s "|" > RESULT.txt)

# cleaning up
$(rm -f temp tempresult res)
