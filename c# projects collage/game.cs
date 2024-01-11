int up = 5;
int level = 0;  
int lives = 100;
int points = 0;
bool correct = false;
do
{
    Random random = new Random();
    int loh = random.Next(10);
    Console.WriteLine("is the number higher than 5 or lower");
    string input = Console.ReadLine();
    
    if (loh < 5 && input == "l")
    {
        Console.WriteLine("Correct +1 point");
        points++;
        Console.WriteLine("the number was{0}", loh);
        correct = true;
    }
    
    if (loh >= 5 && input == "h")
    {
        Console.WriteLine("Correct +1 point");
        points++;
        correct = true;
        Console.WriteLine("the number was {0}", loh);
    }
    if (points == up)
    {
        Console.WriteLine("level up");
        level++;
        up += 5;
    }
    if (correct == false)
    {
        Console.WriteLine("incorrect life lost");
        Console.WriteLine("the number was{0}", loh);
        lives--;

    }
    correct = false;
    if (lives == 0)
    {
        Console.WriteLine("Game Over");
        Console.WriteLine("you got to {0} ", level);
    }
    if (points == 5)
    {
        Console.WriteLine("Game Complete");
    }
} while (lives > 0 || points != 5);