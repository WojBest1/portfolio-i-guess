import random,time
loop = True
score = 0
while loop:
    print("first die is")
    die1 = random.randint(1,6)
    print(die1)
    print("second die is")
    die2 = random.randint(1,6)
    print(die2)
    
    if die1 != die2:
        final = (die1+die2)
    score=(score + final)
    print("score is")
    print(score)
    
    yyy=input("would you like another go")
    if yyy == 'yes'or'y':
        print("")
    loop = True

    if die1 == die2:
        print("_________                                    _________                          ")
        print("|                   /\         |\      /|   |                                 ")
        print("|                  /  \        | \    / |   |                              ")
        print("|                 /    \       |  \  /  |   |                            ")
        print("|                /      \      |   \/   |   |_________                                    ")
        print("|   |_____      /________\     |        |   |                              ")
        print("|   |    |     /          \    |        |   |                         ")
        print("|        |    /            \   |        |   |                        ")
        print("|________|   /              \  |        |   |_________                               ")
        
        print("___________                        ____________     _______                                           ")
        print("|         | \                  /   |               |       |                          ")
        print("|         |  \                /    |               |       |                   ")
        print("|         |   \              /     |               |       |                     ")
        print("|         |    \            /      |               |       |                      ")
        print("|         |     \          /       |___________    |_______|                                 ")
        print("|         |      \        /        |               |   \                                  ")
        print("|         |       \      /         |               |    \                            ")
        print("|         |        \    /          |               |     \                                ")
        print("|         |         \  /           |               |      \                               ")
        print("|_________|          \/            |__________     |       \                                            ")

        
        
        
        loop = False
   