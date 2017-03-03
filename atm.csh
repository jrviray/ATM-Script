#Viray, Joshua
#CS 260 Raheja
#!/bin/csh 
#Name: ATM
#Script that mimics the operations of an ATM

set savings = 1000
set checking = 1000

pin:
printf "*** Welcome to Cal Poly Pomona's ATM ***\n"
echo "Please enter your PIN: "
set pin = $<
set attempts = 0
while (1)
	if ($pin == 111) then
		break
	endif

	if ($attempts == 2) then
		echo "Too many illegal PIN's. Try again later."
		exit
	else
		@ attempts++
		clear
		echo "Invalid PIN."
		echo "Please enter your PIN: "
		set pin = $<
	endif
end

atm:
	printf "***Welcome to Cal Poly Pomona's ATM System***\n"
	echo "(1) Transfer from checking account to savings account"
	echo "(2) Transfer from savings account to checking account"
	echo "(3) Savings account balance"
	echo "(4) Checkings account balance"
	echo "(5) Withdraw cash from either account"
	echo "(6) Exit"
	set option = $<
	switch ($option)
		case 1:
		goto op1
		breaksw
		case 2:
		goto op2 
		breaksw
		case 3:
		goto op3 
		breaksw
		case 4:
		goto op4 
		breaksw
		case 5:
		goto op5 
		break sw
		case 6:
		exit
		breaksw
		default:
		clear
		echo "Invalid input"
		goto atm
	endsw

op1:
	echo "How much would you like to transfer: "
	set amount = $<
	if ($amount > $checking) then
		printf "\nTransaction not completed."
		echo "Insufficeint funds."
		goto op4
	else
		@ checking = ($checking - $amount)
		@ savings = ($savings + $amount) 
		echo "Account Balance"
		printf "Checking: $checking\t Savings: $savings\n\n"
		goto atm
	endif

op2:
	echo "How much would you like to transfer: "
	set amount = $<	
	if ($amount > $savings) then   
		printf "\nTransaction not completed."
		echo "Insufficeint funds."
		goto op4 
      	 else    
	 	@ savings = ($savings - $amount)
		@ checking = ($checking + $amount)        
		echo "Account Balance"
		printf "Checking: $checking\t Savings: $savings\n\n"
		goto atm
	endif

op3:
	printf "\nCurrent savings balance: $savings\n\n"
	goto atm

op4:
	printf "\nCurrent checking balance: $checking\n\n"
	goto atm

op5:
	echo "Which account would you like to withdraw from?"
	echo "(1) Savings"
	echo "(2) Checking"
	set account = $<
	if ($account != 1 && $account != 2) then
	goto op5
	endif
	echo "How much would you like to withdraw: "
	set amount = $<
	if ($account == 1) then
		if ($amount > $savings) then
			goto noFunds
			goto op3 
		else
			@ savings = ($savings - $amount)
			goto op3 
		endif
	else if ( $account == 2) then
		if ($amount > $savings)then
			printf "\nTransaction not completed."
			echo "Insufficeint funds."
			goto op4 
		else
			@ checking = ($checking - $amount)
			goto op4
		endif
	endif

