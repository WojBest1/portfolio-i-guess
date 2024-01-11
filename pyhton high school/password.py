user_1="woj" 
pw_1="paswd" 
tries = "3" 
#created veriables
while tries_1 < 0:    
    user1=input("what would you like to do log in or sign up")
if user1 == "sign up":
    
    passwd=input("enter the password")    
    specialsym = ['$' , '@' , '#' , '%']    
if len(passwd) < 6:
    print('length should be at least 6')
    #val=false

if not any(char.isdigit()for char in passwd):
    print('password should have atleast 1 number')
    #val=false

if len(passwd) > 20:
    print('length should be not greater than 8')
    #val=false

if not any(char.isupper()for char in passwd):
    print('password should have atleast uppercase')
    #val=false

if not any(char.islower()for char in passwd):
    print('password should have atleast lowercase')
    #val=false

if not any(char in specialsym()for char in passwd):
    print('password should have atleast 1 of these # % @ $')
    #val=false
#if val:
    #return val

#created diffrent checks
if user1 == "login":
    user = input("what is the user name ") 
pw=input("what is the password") 
if  user == user_1 and pw == pw_1: 
    print("valid") 
break
  #prints valid      
else: 
     print("incorect ")
tries_1 = ((int(tries) - 1)) 
print(tries_1) 
#takes away tries
