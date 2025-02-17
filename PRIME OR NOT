A shell program to find whether a number is prime or not.
#/bin/bash
# Suvra ranjan
, 24mca011
echo "Enter a number:
read num
if [ $num -le 1 ]; then echo "$num is Not Prime"
exit
for ((i=2; i*i < num; i#*)); do if [ $( (num % i)) -eq 0 ]; then echo "$num is Not Prime"
exit fi
done
echo "$num is Prime"
