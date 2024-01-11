import math
 
user = input("are you using sin cos or tan? ")
user_3 = input("which side is unknown? ")
 
if user == 'sin' and user_3 == 'opposite':
    user_1 = float(input("what is the hypotenuse? "))
    ang_1 = float(input("what's your angle ?: "))
    the_divided_num = float(180 / ang_1)
    x_1 = math.sin(math.pi / the_divided_num)
    answer1 = (x_1 / user_1)
    print(answer1)
 
if user_3 == 'hypotenuse' and user == 'sin':
    user_1 = float(input("what is the opposite? "))
    ang = float(input("what's your angle ?: "))
    the_divided_num = float(180 / ang)
    x = math.sin(math.pi / the_divided_num)
    answer = (x / user_1)
    print(answer)
 

 
if user_3 == 'hypotenuse' and user == 'cos':
    result_9 = float(input("what is the angle"))
    result_7 = float(input("what is is the ajecent"))
    result_6 = math.cos(math.radians(result_9))
    answer_6 = (result_7 / result_6)
    print(answer_6)
   
   
if user_3 == 'ajecent' and user == 'cos':
    result_77 = float(input("what is the angle "))
    result_99 = float(input("what is is the hypotenuse "))
    result_66 = math.cos(math.radians(result_77))
    answer_66 = (result_66 * result_99)
    print(answer_66)



if user_3 == 'opposite' and user == 'tan':
    result_999 = float(input("what is the angle "))
    result_777 = float(input("what is is the ajecent "))
    result_666 = math.tan(math.radians(result_999))
    answer_666 = (result_777 * result_666)
    print(answer_666)
   
if user_3 == 'ajecent' and user == 'tan':
    result_99_ = float(input("what is the angle "))
    result_77_ = float(input("what is is the opposite "))
    result_66_ = math.tan(math.radians(result_99_))
    answer_66_ = (result_77_ / result_66_)
    print(answer_66_)
