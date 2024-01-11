import math
user=input("what are you trying to work out or if you forget the names of the sides write help i forgot")

if user == 'hypotenuse':
    user_1=int(input("what is a"))
    user_2=int(input("what is b"))

    answer_1 = (user_1 * user_1)
    answer_2 = (user_2 * user_2)
    answer_3 = (answer_1 + answer_2)
    answer_4 = (math.sqrt(answer_3))
    print(answer_4)



if user == 'help i forgot':
    print("                        /|")
    print("                       / |")
    print("                      /  |")
    print("                     /   |")
    print("                    /    |")
    print("                   /     |")
    print("                  /      |")
    print(" hypotenuse      /       |    b")
    print("                /        |   leg")
    print("               /         |")
    print("              /          |")
    print("             /           |")
    print("            /            |")
    print("           /             |")
    print("          /           ___|")
    print("         /           |   |")
    print("        /____________|___|")
    print("               a          ")
    print("              leg         ")
   
elif user == 'b':
    user_3=int(input("what is the hypotenuse"))
    user_4=int(input("what is a"))

    answer_5 = (user_3 * user_3)
    answer_6 = (user_4 * user_4)
    answer_7 = (answer_5 - answer_6)
    answer_8 = (math.sqrt(answer_7))
    print(answer_8)
   
elif user == 'a':
    user_5=int(input("what is the hypotenuse"))
    user_6=int(input("what is b"))

    answer_9 = (user_5 * user_5)
    answer_10 = (user_6 * user_6)
    answer_11 = (answer_9 - answer_10)
    answer_12 = (math.sqrt(answer_11))
    print(answer_8)
   
#else:
    #print("that is not an option please write a b or hypotenuse")