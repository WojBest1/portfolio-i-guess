import turtle

def drawtriangle():
    turtle.pendown()
    turtle.pencolor(color_of_shape)
    for i in range(2):
        turtle.forward(size)
        turtle.left(120)
        turtle.forward(size)
        turtle.left(120)


def drawsquare():
    turtle.pendown()
    turtle.pencolor(color_of_shape)
    for i in range(1):
        turtle.forward(size)
        turtle.right(90)
        turtle.forward(size)
        turtle.right(90)
        turtle.forward(size)
        turtle.right(90)
        turtle.forward(size)
        turtle.right(90)
   
def drawhexagon():
    turtle.pendown()
    turtle.pencolor(color_of_shape)
    for i in range(3):
        turtle.forward(size)
        turtle.right(60)
        turtle.forward(size)
        turtle.right(60)
        

        
shape = input("select a shape from theses 3 traingle square hexagon")
color_of_shape = input("select a color")
size = int(input("select a size recomended 300-500"))



if shape =='triangle':
    drawtriangle()
    
elif shape == 'square':
    drawsquare()
    
elif shape == 'hexagon':
    drawhexagon()





