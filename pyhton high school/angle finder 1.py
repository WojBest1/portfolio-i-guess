import time

user_1=input("hi what is your name")
print("hi "+ user_1 +" welcome to the angle finder")
print("")
print("loading")
time.sleep(3)
print("")
user=input("what type of angle would you like to calculate     on a straight line      in a square     on a point   in a triangle")
if user == 'straight line':
    print("ok insert all the angles that you know if you dont know type in 0 ")
    angle_1=int(input("what is the first angle"))
    angle_2=int(input("what is the second angle"))
    angle_3=int(input("what is the third angle"))
    angle_4=int(input("what is the fourth angle"))
    angle_5=int(input("what is the fith angle"))
   
    answer=(angle_1+angle_2+angle_3+angle_4+angle_5)
    answer_1=(180-answer)
    print("your missing angle is")
    print("answer_1")
   
elif user == 'in a square':
    print("ok you must type in 3 angles if you type in 0 you will find out what you are missing all thoughther")
    square_angle_1=int(input("what is the first angle"))
    square_angle_2=int(input("what is the second angle"))
    square_angle_3=int(input("what is the third angle"))
   
    answer_2=(square_angle_1+square_angle_2+square_angle_3)
    answer_3=(360-answer_2)
    print("your missing angle is")
    print(answer_3)
   
elif user == 'on a point':
    print("ok insert all the angles that you know if you dont know the angle type in 0 ")
    point_angle_1=int(input("what is the first angle"))
    point_angle_2=int(input("what is the second angle"))
    point_angle_3=int(input("what is the third angle"))
    point_angle_4=int(input("what is the fourth angle"))
    point_angle_5=int(input("what is the fith angle"))
    point_angle_6=int(input("what is the sixth angle"))
   
    answer_4=(point_angle_1+point_angle_2+point_angle_3+point_angle_4+point_angle_5+point_angle_6)
    answer_5=(360-answer_4)
    print("your missing angle is")
    print(answer_5)
   
elif user == 'in a triangle':
    print("ok you must type in 2 angles if you type in 0 you will find out what you are missing all thoughther")
    triangle_angle_1=int(input("what is the first angle"))
    triangle_angle_2=int(input("what is the second angle"))
    answer_6=(triangle_angle_1+triangle_angle_2)
    answer_7=(180-answer_6)
    print("your missing angle is")
    print(answer_7)
   
else:
    print("that is not an option type in the 4 options which are      on a straight line      in a square     on a point   in a triangle")