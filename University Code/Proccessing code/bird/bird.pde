    PImage image1,image2,image3;     //creates a variable to store an image file -a Class
    int birdX,birdY;
    int imageCounter;
    int countDirection = 0;
void setup()
{
 size(500,500);
     image1 = loadImage("bird1.jpg");   //loads an image from file and stores in the variable
     image1.resize(50,50);     //resize the image
     image2 = loadImage("bird2.jpg");   //loads an image from file and stores in the variable
     image2.resize(50,50);     //resize the image
     image3 = loadImage("bird3.jpg");   //loads an image from file and stores in the variable
     image3.resize(50,50);     //resize the image
    imageMode(CENTER); //draw images from centre position
}
void draw()
{
  background(200);
  if(imageCounter >= 0 && imageCounter < 10)
    image(image1, width/2, height/2);  //displays the image variable at an x,y
   if(imageCounter >= 10 && imageCounter < 20)
       image(image2, width/2, height/2);  //displays the image variable at an x,y
       else if(imageCounter >= 20 && imageCounter < 30)
           image(image3, width/2, height/2);  //displays the image variable at an x,y
           
        imageCounter+= countDirection ;
           if(imageCounter <=0)
       countDirection = 1;
        
        if(imageCounter >=29)
       countDirection = -1;
}
