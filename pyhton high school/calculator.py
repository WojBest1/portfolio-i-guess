first_number=int(input("what is your first number "))

print("+")
print("-")
print("/")
print("*")
sign_choise= input("what sign will")


second_number=int(input("what is your second number"))


if sign_choise == '+':
    answer_1=(first_number + second_number)
    print("this is your output is" (answer_1))
  
    
elif sign_choise == '-':
    answer_2 = (first_number-second_number)
    print("this is your output is")
    print(answer_2)

elif sign_choise == '/':
    answer_3=(first_number / second_number)
    print("this is your output is")
    print(answer_3)

elif sign_choise == '*':
    answer_4=(first_number*second_number)
    print("this is your output is")
    print(answer_4)

else:
    print("that is not a option write a number and a sign")

