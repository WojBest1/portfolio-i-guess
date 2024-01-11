text1 = 'user '
text2 = 'has won '
text3 = 'pounds at the time'
text4 = 'on the day'

name = input("what is your name:")

from datetime import date 
import random

def list():


    evenlist =[2,4,6,8,10,12,14,16,18,20,22,24,26,28,30]
    multiples_of_10 =[10,20,30]
    prime_numbers =[2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

list()

for i in range(0,1):
    number = random.randint(0,30)
    user = int(input("enter a number between 1-30:"))
    user1=int(input("enter a bet:"))
    if number == user:
        print("well done you pick the right number!")
        if user in evenlist:
            user1=user1*2
        elif user in multiples_of_10:
            user1= user1*3 
        elif user in prime_numbers:
            user1= user1*5
        elif user1 <= 5:
            user1= user1*2
    else:
        print("wrong")
print("you win ",user1)

def filewrite():

    today = date.today()


    from datetime import datetime

    now = datetime.now()

    time = now.strftime("%H:%M:%S")

    f  = open("gambling.txt", "w")
    f.write(str(text1))
    f.write(' ')
    f.close()

    f  = open("gambling.txt", "a")
    f.write(str(name))
    f.write(' ')
    f.close()

    f  = open("gambling.txt", "a")
    f.write(str(text2))
    f.write(' ')
    f.close()

    f=open("gambling.txt", "a")
    f.write(str(user1,))
    f.write(' ')
    f.close()

    f  = open("gambling.txt", "a")
    f.write(str(text3))
    f.write(' ')
    f.close()

    f=open("gambling.txt", "a")
    f.write(str(time,))
    f.write(' ')
    f.close()

    f=open("gambling.txt", "a")
    f.write(str(text4))
    f.write(' ')
    f.close()


    f=open("gambling.txt", "a")
    f.write(str(today))
    f.write(' ')
    f.close()

filewrite()

#today = date.today()                       
#print("on the date:", today)
