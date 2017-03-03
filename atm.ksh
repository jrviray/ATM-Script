#Viray, Joshua
#CS 260 Raheja
#!/bin/ksh 
#Name: ATM
#Script that mimics the operations of an ATM

pin(){
printf "*** Welcome to Cal Poly Pomona's ATM ***\n"
echo "Please enter your PIN: "
read pin
attempts=0
while [ true ];do
	if [ $pin -eq 111 ];then
		break
	fi
	if [ $attempts -eq 2 ];then
		echo "Too many illegal PIN's. Try again later."
		exit
	else
		((attempts++))
		clear
		echo "Invalid PIN."
		echo "Please enter your PIN: "
		read pin
	fi
done
}

atm(){
	printf "***Welcome to Cal Poly Pomona's ATM System***\n"
	echo "(1) Transfer from checking account to savings account"
	echo "(2) Transfer from savings account to checking account"
	echo "(3) Savings account balance"
	echo "(4) Checkings account balance"
	echo "(5) Withdraw cash from either account"
	echo "(6) Exit"
	read option
	case $option in
		1)
		op1 $savings $checking
		atm
		;;
		2)
		op2 $savings $checking
		atm
		;;
		3)
		op3 $savings
		atm
		;;
		4)
		op4 $checking
		atm
		;;
		5)
		op5 $savings $checking
		atm
		;;
		6)
		exit
		;;
		*)
		clear
		echo "Invalid input"
		atm
	esac
}

noFunds(){
	printf "\nTransaction not completed."
	echo "Insufficeint funds."
}

op1(){
	echo "How much would you like to transfer: "
	read amount
	if [ $amount -gt $checking ];then
		noFunds
		op4 $checking
	else
		((checking=$checking - $amount))
		((savings=$savings + $amount))
		op4 $checking
		op3 $savings
	fi
}

op2(){  
	echo "How much would you like to transfer: "
	read amount	
	if [ $amount -gt $savings ];then   
		noFunds
		op4 $savings
      	 else    
	 	((savings=$savings - $amount))
		((checking=$checking + $amount))        
		op4 $savings
		op3 $checking
	fi
}

op3(){
	printf "\nCurrent savings balance: $savings\n\n"
}

op4(){
	printf "\nCurrent checking balance: $checking\n\n"
}

op5(){
	echo "Which account would you like to withdraw from?"
	echo "(1) Savings"
	echo "(2) Checking"
	read account
	while [ $account -ne 1 -a $account -ne 2 ];do
	echo "Which account would you like to withdraw from?"
	echo "(1) Savings"
	echo "(2) Checking"
	read account
	done
	echo "How much would you like to withdraw: "
	read amount
	if [ $account -eq 1 ];then
		if [ $amount -gt $savings ];then
			noFunds
			op3 $savings
		else
			((savings=$savings - $amount))
			op3 $savings
		fi
	elif [ $account -eq 2 ];then
		if [ $amount -gt $savings ];then
			noFunds
			op4 $checking
		else
			((checking=$checking - $amount))
			op4 $checking
		fi
	fi
}

main(){
savings=1000
checking=1000
pin
atm $savings $checking
}

main
