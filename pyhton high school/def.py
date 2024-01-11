score= 0
def conversation():
    print("Welcome to my conversation program")
    print()
    print("Do you like cycling? Answer yes or no")
    answer = input()
    if answer == "yes":
        print("That's good - you will get very fit")
    else:
        print("Perhaps you like some other sport. ")
    print("Goodbye")
 

def sport():
    print("welcome to the quetion")
    print()
    print("how fast did usain bolt do 100 m")
    print("A  12sec")
    print("B  8.76sec")
    print("C  9.58sec")
    fast=input("")
    if fast == "b" or "B":
        print("correct")
        score = score + 1
    else:
        print("stupid")
    
    print("welcome to the second quetion quetion")
    print()
    print("what is the most goals scored in a football game")
    print("A  157")
    print("B  10")
    print("C  149")
    goal=input("")
    if goal == "c" or "C":
        print("correct")
        score = score + 1
    else:
        print("its ok not to know")

    print("welcome to the thrid quetion quetion")
    print()
    print("how many rackets sports are there")
    print("A  more than 30 ")
    print("B  less than 15")
    print("C  exactly 17")
    racket=input("")
    if racket == "a" or "A":
        print("correct")
        score = score + 1
    else:
        print("u stupid")

    print("your final score is")
    print(score)
