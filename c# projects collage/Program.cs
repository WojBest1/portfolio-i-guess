using System.Media;
using System.ComponentModel;
using System.Data;
using System.Reflection;
using System.Runtime.ConstrainedExecution;
using System.Runtime.Serialization.Formatters;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Threading;
using System;
using System.Windows;
class Program



{



    public static int consoleWidth = Console.WindowWidth;
    public static int consoleHeight = Console.WindowHeight;
    public static int ballX = consoleWidth / 2;
    public static int ballY = consoleHeight / 2;
    public static int scoreX2 = (int)Math.Round(consoleWidth * 0.80);
    public static int scoreY2 = (int)Math.Round(consoleHeight * 0.15);
    public static int scoreX1 = (int)Math.Round(consoleWidth * 0.20);
    public static int scoreY1 = (int)Math.Round(consoleHeight * 0.15);
    public static int score1 = 0;
    public static int score2 = 0;
    public static bool stop = false;
    public static int move = 0;
    public static int Player1X = 0;
    public static int Player1Y = 0;
    public static int Player2X = consoleWidth - 1;
    public static int Player2Y = 0;
    public static bool winProtocol = false;
    public static int colorIndex = 0;
    public static int bot = consoleHeight - 13;
    static void Main()
    {
        Console.ReadKey(false);
        Console.CursorVisible = false;
     
        PlayMusic("Original Tetris theme (Tetris Soundtrack).wav");
        int hold1 = 0;
        bool dontgotop1 = false;
        bool dontgobot1 = false;
        bool dontgotop2 = false;
        bool dontgobot2 = false;

        Timer timer = new Timer(TimerCallback, null, 0, 20);

        drawScore();
        while (!stop)
        {




            ConsoleKeyInfo key = Console.ReadKey();

            if (key.Key == ConsoleKey.F1 && dontgotop1 == false)
            {
                Player1Y--;
                hold1++;
            }
            if (key.Key == ConsoleKey.F2 && dontgobot1 == false)
            {
                Player1Y++;
                hold1++;
            }
            if (key.Key == ConsoleKey.UpArrow && dontgotop2 == false)
            {
                Player2Y--;

            }
            if (key.Key == ConsoleKey.DownArrow && dontgobot2 == false)
            {
                Player2Y++;
            }

            if (winProtocol == false)
            {

                Console.SetCursorPosition(Player1X, Player1Y);


                Console.WriteLine("@");
                Console.WriteLine("@");
                Console.WriteLine("@");
                Console.WriteLine("@");
                Console.WriteLine("@");
                Console.WriteLine("@");
                Console.WriteLine("@");
                Console.WriteLine("@");
                Console.WriteLine("@");
                Console.WriteLine("@");
                Console.WriteLine("@");



                if (Player1Y > 0)
                {
                    Console.SetCursorPosition(Player1X, Player1Y - 1);
                    Console.WriteLine(' ');
                }
                if (Player1Y < consoleHeight - 1)
                {
                    Console.SetCursorPosition(Player1X, Player1Y + 11);
                    Console.WriteLine(' ');

                }




                Console.SetCursorPosition(Player2X, Player2Y);
                string text = "@@@@@@@@@@@";

                foreach (char c in text)
                {
                    try
                    {
                        Console.Write(c);
                        Console.SetCursorPosition(Player2X, Console.CursorTop + 1);

                    }
                    catch (ArgumentOutOfRangeException)
                    {

                        Console.Write(c);
                        Console.SetCursorPosition(Player2X, Console.CursorTop + 1);

                    }
                }


                if (Player2Y > 0)
                {
                    Console.SetCursorPosition(Player2X, Player2Y - 1);
                    Console.WriteLine(' ');
                }

                if (Player2Y < consoleHeight - 1)
                {
                    Console.SetCursorPosition(Player2X, Player2Y + 11);
                    Console.WriteLine(' ');

                }
            }
            if (Player1Y == 0)
            {
                dontgotop1 = true;

            }
            if (Player1Y > 0)
            {

                dontgotop1 = false;
            }

            if (Player1Y == bot)
            {
                dontgobot1 = true;

            }
            if (Player1Y < bot)
            {

                dontgobot1 = false;
            }





            if (Player2Y == 0)
            {
                dontgotop2 = true;

            }
            if (Player2Y > 0)
            {

                dontgotop2 = false;
            }

            if (Player2Y == bot)
            {
                dontgobot2 = true;

            }
            if (Player2Y < bot)
            {

                dontgobot2 = false;
            }





        }



    }
    public static void PlayMusic(string filepath)
    {
    
        SoundPlayer player = new SoundPlayer();
        player.SoundLocation = filepath;
        player.PlayLooping();

    }
    static void drawScore()
    {


        if (score1 == 0 && winProtocol == false)
        {

            Console.SetCursorPosition(scoreX1, scoreY1 - 8);
            Console.WriteLine("|-----|");
            Console.SetCursorPosition(scoreX1, scoreY1 - 7);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX1, scoreY1 - 6);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX1, scoreY1 - 5);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX1, scoreY1 - 4);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX1, scoreY1 - 3);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX1, scoreY1 - 2);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX1, scoreY1 - 1);
            Console.WriteLine("|_____|");



        }


        if (score2 == 0 && winProtocol == false)
        {
            Console.SetCursorPosition(scoreX2, scoreY2 - 8);
            Console.WriteLine("|-----|");
            Console.SetCursorPosition(scoreX2, scoreY2 - 7);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX2, scoreY2 - 6);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX2, scoreY2 - 5);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX2, scoreY2 - 4);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX2, scoreY2 - 3);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX2, scoreY2 - 2);
            Console.WriteLine("|     |");
            Console.SetCursorPosition(scoreX2, scoreY2 - 1);
            Console.WriteLine("|_____|");
        }

        if (score1 == 1 && winProtocol == false)
        {
            Console.SetCursorPosition(scoreX1, scoreY1 - 8);
            Console.WriteLine("   /|   ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 7);
            Console.WriteLine("  / |   ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 6);
            Console.WriteLine(" /  |   ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 5);
            Console.WriteLine("    |   ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 4);
            Console.WriteLine("    |   ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 3);
            Console.WriteLine("    |   ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 2);
            Console.WriteLine("    |   ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 1);
            Console.WriteLine(" ___|___");







        }

        if (score2 == 1 && winProtocol == false)
        {

            Console.SetCursorPosition(scoreX2, scoreY2 - 8);
            Console.WriteLine("   /|   ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 7);
            Console.WriteLine("  / |   ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 6);
            Console.WriteLine(" /  |   ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 5);
            Console.WriteLine("    |   ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 4);
            Console.WriteLine("    |   ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 3);
            Console.WriteLine("    |   ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 2);
            Console.WriteLine("    |   ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 1);
            Console.WriteLine(" ___|___");




        }

        if (score1 == 2 && winProtocol == false)
        {
            Console.SetCursorPosition(scoreX1, scoreY1 - 8);
            Console.WriteLine(@"      /-----\          ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 7);
            Console.WriteLine("     /      /    ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 6);
            Console.WriteLine("    /      /    ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 5);
            Console.WriteLine("   /      /    ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 4);
            Console.WriteLine("         /    ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 3);
            Console.WriteLine("        /     ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 2);
            Console.WriteLine("       /      ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 1);
            Console.WriteLine("      /_______");

        }
        if (score2 == 2 && winProtocol == false)
        {
            Console.SetCursorPosition(scoreX2, scoreY2 - 8);
            Console.WriteLine(@"      /-----\          ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 7);
            Console.WriteLine("     /      /    ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 6);
            Console.WriteLine("    /      /    ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 5);
            Console.WriteLine("   /      /    ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 4);
            Console.WriteLine("         /    ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 3);
            Console.WriteLine("        /     ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 2);
            Console.WriteLine("       /      ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 1);
            Console.WriteLine("      /_______");

        }

        if (score1 == 3 && winProtocol == false)
        {
            

            Console.SetCursorPosition(scoreX1, scoreY1 - 8);
            Console.WriteLine(@"______  ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 7);
            Console.WriteLine(@"      \ ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 6);
            Console.WriteLine(@"      | ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 5);
            Console.WriteLine("      /  ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 4);
            Console.WriteLine(@"______\ ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 3);
            Console.WriteLine(@"      | ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 2);
            Console.WriteLine("      |  ");
            Console.SetCursorPosition(scoreX1, scoreY1 - 1);
            Console.WriteLine("______/  ");

        }
        if (score2 == 3 && winProtocol == false)
        {


            Console.SetCursorPosition(scoreX2, scoreY2 - 8);
            Console.WriteLine(@"______  ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 7);
            Console.WriteLine(@"      \ ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 6);
            Console.WriteLine(@"      | ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 5);
            Console.WriteLine("      /  ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 4);
            Console.WriteLine(@"______\ ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 3);
            Console.WriteLine(@"      | ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 2);
            Console.WriteLine("      |  ");
            Console.SetCursorPosition(scoreX2, scoreY2 - 1);
            Console.WriteLine("______/  ");

        }
        if (score1 == 4)
        {
            int m = 40;
            if (winProtocol == false)
            {
                Console.Clear();
            }
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 16);
            Console.WriteLine(@"  ______      _                __     \\     //       ||--------    ||----              /|                                     ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 15);
            Console.WriteLine(@" |  __  \    | |              /  \      \\ //         ||            ||    \            / |                                     ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 14);
            Console.WriteLine(@" | |__)  |   | |             / /\ \     |   |         ||________    ||     /          /  |                                     ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 13);
            Console.WriteLine(@" |  ___/     | |            / ____ \    |   |         ||            ||-----              |                                     ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 12);
            Console.WriteLine(@" | |         | |____       / /    \ \   |   |         ||            ||      \            |                                     ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 11);
            Console.WriteLine(@" |_|         |_______|   /_/      \_\   |___|         ||_________   ||       \       ---------                                 ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 10);
            Console.WriteLine(@"                                                                                                                                                                                                                                   ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 9);
            Console.WriteLine(@"                                                                                                                               ");

            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 8);
            Console.WriteLine(@"\\                                  //     _____________         ||\\          ||     ___________                               ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 7);
            Console.WriteLine(@" \\             //\\              //             |               ||  \\        ||     /           \                            ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 6);
            Console.WriteLine(@"  \\          //    \\          //               |               ||    \\      ||     \                                        ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 5);
            Console.WriteLine(@"   \\\      //        \\      //                 |               ||      \\    ||      -----------                             ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 4);
            Console.WriteLine(@"    \\    //            \\   //                  |               ||        \\  ||                 /                            ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 3);
            Console.WriteLine(@"      \\//                \\//             ______________        ||          \\||      ____________                           ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 2);
            Console.WriteLine(@"                                                                                                                                                                                                                                   ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 1);


            winProtocol = true;



        }

        if (score2 == 4)
        {
            int m = 40;

            if (winProtocol == false)
            {
                Console.Clear();
            }
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 16);
            Console.WriteLine(@"  ______      _                __     \\     //       ||--------    ||----           /-----\                                ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 15);
            Console.WriteLine(@" |  __  \    | |              /  \      \\ //         ||            ||    \         /     /                                   ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 14);
            Console.WriteLine(@" | |__)  |   | |             / /\ \     |   |         ||________    ||     /       /     /                                     ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 13);
            Console.WriteLine(@" |  ___/     | |            / ____ \    |   |         ||            ||-----             /                                     ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 12);
            Console.WriteLine(@" | |         | |____       / /    \ \   |   |         ||            ||      \          /                                      ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 11);
            Console.WriteLine(@" |_|         |_______|   /_/      \_\   |___|         ||_________   ||       \        ---------                               ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 10);
            Console.WriteLine(@"                                                                                                                                                                                                                                   ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 9);
            Console.WriteLine(@"                                                                                                                              ");

            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 8);
            Console.WriteLine(@"\\                                  //     _____________         ||\\          ||     ___________                             ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 7);
            Console.WriteLine(@" \\             //\\              //             |               ||  \\        ||     /           \                           ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 6);
            Console.WriteLine(@"  \\          //    \\          //               |               ||    \\      ||     \                                       ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 5);
            Console.WriteLine(@"   \\\      //        \\      //                 |               ||      \\    ||      -----------                            ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 4);
            Console.WriteLine(@"    \\    //            \\   //                  |               ||        \\  ||                 /                           ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 3);
            Console.WriteLine(@"      \\//                \\//             ______________        ||          \\||      ____________                           ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 2);
            Console.WriteLine(@"                                                                                                                                                                                                                                   ");
            Console.SetCursorPosition(consoleWidth / 2 - m, consoleHeight / 2 - 1);


            winProtocol = true;



        }
    }



    static void TimerCallback(object state)
    {

        if (DateTime.Now.Second % 0.5 == 0)
        {

            //top 1
            //top2 2
            //bottom 3
            //bottom2 4
            //left 5
            //left2 6
            //right 7
            //right2 8
            if (ballY == 0)
            {
                if (winProtocol == false)
                {
                    Console.Clear();
                }
                drawScore();
                if (move == 3 || move == 5 || move == 7)//top
                {
                    move = 1;

                }
                else
                {
                    move = 2;
                }
            }


            if (ballY == consoleHeight - 1)//bottom
            {



                if (move == 8 || move == 1 || move == 6 || move == 0)
                {

                    move = 3;
                }
                else
                {
                    move = 4;

                }



            }
            ////////////////////////
            //top 1
            //top2 2
            //bottom 3
            //bottom2 4
            //left 5
            //left2 6
            //right 7
            //right2 8

            if (ballX == 0)//left
            {

                if (ballY > Player1Y + 11 || ballY < Player1Y - 1)
                {
                    if (!winProtocol)
                    {
                        score2++;
                    }
                    drawScore();


                }
                if (move == 1)
                {
                    move = 5;

                }

                else
                {


                    move = 6;
                }
            }



            if (ballX == consoleWidth - 1)//right
            {

                if (ballY > Player2Y + 11 || ballY < Player2Y - 1)
                {
                    if (!winProtocol)
                    {
                        score1++;
                    }
                    drawScore();


                }
                if (move == 2)
                {
                    move = 8;

                }
                else
                {
                    move = 7;
                }
            }




            if (move == 0)
            {
                ballY--;
                ballX++;
                if (ballX > 0 && ballY > 0)
                {

                    Console.SetCursorPosition(ballX - 1, ballY + 1);
                    if (winProtocol == false)
                    {
                        Console.Write(' ');
                    }



                }

            }
            /////////////////////////////
            if (move == 1)
            {
                ballX--;
                ballY++;
                if (ballX > 0 && ballY > 0)
                {
                    Console.SetCursorPosition(ballX + 1, ballY - 1);
                    if (winProtocol == false)
                    {
                        Console.Write(' ');
                    }
                }
            }
            if (move == 2)
            {
                ballY++;
                ballX++;
                if (ballX > 0 && ballY > 0)
                {
                    Console.SetCursorPosition(ballX - 1, ballY - 1);
                    if (winProtocol == false)
                    {
                        Console.Write(' ');
                    }
                }

            }
            if (move == 3)
            {


                ballX--;
                ballY--;
                if (ballX > 0 && ballY > 0)
                {
                    Console.SetCursorPosition(ballX + 1, ballY + 1);
                    if (winProtocol == false)
                    {
                        Console.Write(' ');
                    }
                }

            }
            if (move == 4)
            {


                ballX++;
                ballY--;
                if (ballX > 0 && ballY > 0)
                {
                    Console.SetCursorPosition(ballX - 1, ballY + 1);
                    if (winProtocol == false)
                    {
                        Console.Write(' ');
                    }
                }

            }


            if (move == 5)
            {
                ballY++;
                ballX++;
                if (ballX > 0 && ballY > 0)
                {
                    Console.SetCursorPosition(ballX - 1, ballY - 1);
                    if (winProtocol == false)
                    {
                        Console.Write(' ');
                    }
                }

            }
            if (move == 6)
            {
                ballY--;
                ballX++;
                if (ballX > 0 && ballY > 0)
                {
                    Console.SetCursorPosition(ballX - 1, ballY + 1);
                    if (winProtocol == false)
                    {
                        Console.Write(' ');
                    }
                }
            }


            if (move == 7)
            {
                ballY--;
                ballX--;
                if (ballX > 0 && ballY > 0)
                {
                    Console.SetCursorPosition(ballX + 1, ballY + 1);
                    if (winProtocol == false)
                    {
                        Console.Write(' ');
                    }

                }

            }
            if (move == 8)
            {
                ballX--;
                ballY++;
                if (ballX > 0 && ballY > 0)
                {
                    Console.SetCursorPosition(ballX + 1, ballY - 1);
                    if (winProtocol == false)
                    {
                        Console.Write(' ');
                    }
                }
            }






            //top 1
            //top2 2
            //bottom 3
            //bottom2 4
            //left 5
            //left2 6
            //right 7
            //right2 8












            if (winProtocol == false)
            {
                Console.SetCursorPosition(ballX, ballY);
                Console.Write("o");

            }

            int[] colors = { 91, 93, 94, 96, 97, 98, 99, 100, 101, 102, 103, 104,105,106,107,108,109,110};

            if (winProtocol == true)
            {
                // Set the text color using ANSI escape codes
                Console.SetCursorPosition(ballX, ballY);

                Console.Write($"\u001b[{colors[colorIndex]}m"); // Set foreground color only

                Console.Write(winProtocol);

                // Reset color to default (if needed)
                Console.ResetColor();

                // Increment the color index for the next character
                colorIndex = (colorIndex + 1) % colors.Length;
            }

        }
    }
}

