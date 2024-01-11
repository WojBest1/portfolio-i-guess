namespace ConsoleApp4
{
    using System;
    using System.IO;

    internal class Program
    {
        static bool pass1 = false;

        static bool reginc = true;
        static TimeSpan calc;

        static int iff;
        static int te = 0;
        static double moneymade;
        static int startcars;
        static DateTime[] timeEntered = new DateTime[5];
        static string[] regi = new string[5];
        static string[] gone = new string[5];




        static void Menu()
        {
            wtb();
            rfb();

            if (iff < 0)
            {
                iff = 0;
                wtb();
            }
            Console.WriteLine("----------------------------------------------------------------------------");
            Console.WriteLine("1:ENTER CAR PARK");
            Console.WriteLine("2:LEAVE CAR PARK");
            Console.WriteLine("3:MANAGMENT OPTIONS");
            Console.WriteLine("4:QUIT");
            Console.WriteLine("----------------------------------------------------------------------------");

        }

        static void ClearFile(string filePath)
        {

            using (StreamWriter writer = new StreamWriter(filePath, false))
            {

            }
        }
        static void entercarpark()
        {


            rfb();
            if (iff == 5)
            {

                Console.WriteLine("full");

            }
            if (iff < 5)
            {
                do
                {
                    Console.WriteLine("----------------------------------------------------------------------------");
                    Console.WriteLine("enter registration");
                    Console.WriteLine("----------------------------------------------------------------------------");
                    string reg = Console.ReadLine().ToUpper(); ;

                    if (reg.Length == 7)
                    {
                        if (char.IsUpper(reg[0]) && char.IsUpper(reg[1]) && char.IsDigit(reg[2]) && char.IsDigit(reg[3]) && char.IsUpper(reg[4]) && char.IsUpper(reg[5]) && char.IsUpper(reg[6]))
                        {
                            reginc = false;
                        }
                    }
                    else
                    {
                        Console.WriteLine("incorect formatt bitch get it right");
                        reginc = true;
                    }
                    if (reginc == false)
                    {

                        string fileName = $"{reg}.txt";


                        Console.WriteLine("----------------------------------------------------------------------------");
                        Console.WriteLine("added");
                        Console.WriteLine("----------------------------------------------------------------------------");
                        regi[iff] = reg;
                        timeEntered[iff] = DateTime.Now;
                        te++;
                        rfb();
                        iff++;
                        wtb();
                        if (File.Exists("moneymade.bin") == false)
                        {
                            scWrite();

                        }
                        scRead();
                        startcars++;

                        scWrite();




                        fuckBinaryFilesWrite();





                    }
                }    while (reginc == true);
            }
        }
        static void mmscRead()
        {


            int trys = 0;



            for (int i = 0; i < 4; i++)
            {
                if (pass1 == false)
                {
                    Console.WriteLine("enter password");
                    string pass = Console.ReadLine();
                    if (pass == "fred")
                    {
                        pass1 = true;
                    }
                    if (pass != "fred")
                    {
                        int trys1 = 3;
                        trys1--;
                        Console.WriteLine("incorect {0} trys left before breakdown", trys1);

                        trys++;
                        if (trys > 3)
                        {
                            bool f = false;

                            for (i = 0; i < 25; i++)
                            {
                                Console.Clear();
                                Console.WriteLine("ERROR UNAUTHORIZED ACCESS ERROR UNAUTHORIZED ACCESS ERROR UNAUTHORIZED ACCESS ERROR UNAUTHORIZED ACCESS ");
                                Console.Beep();

                            }



                        }

                    }
                }
            }
            if (pass1 == true)
            {

                try
                {


                    scRead();
                }
                catch (FileNotFoundException)
                {

                    scWrite();
                    scRead();

                }
          
                Console.WriteLine("so far there have been {0} cars", startcars);
                Console.WriteLine("----------------------------------------------------------------------------");

                try
                {


                    rfb();
                }
                catch (FileNotFoundException)
                {

                    wtb();
                    rfb();

                }

                Console.WriteLine("----------------------------------------------------------------------------");
                Console.WriteLine("there are currently {0} cars ", iff);
                Console.WriteLine("----------------------------------------------------------------------------");

                try
                {


                    mmRead();
                }
                catch (FileNotFoundException)
                {
                    mmWrite();
                    mmRead();

                }
                Console.WriteLine("there has been {0} money made", moneymade);
                Console.WriteLine("----------------------------------------------------------------------------");
                Console.WriteLine("Clear logs?");
                string yon = Console.ReadLine();
                if (yon == "no")
                {


                }
                if (yon == "yes") 
                {

                    ClearFile("carTime.txt");

                    Console.WriteLine("Data in the file has been deleted.");

                }


            }






        }

        static void mmWrite()
        {


            BinaryWriter file1 = new BinaryWriter(File.Open("moneymade.bin", FileMode.Create));
            file1.Write(moneymade);
            file1.Close();


        }
        static void scWrite()
        {

            BinaryWriter file2 = new BinaryWriter(File.Open("startcars.bin", FileMode.Create));
            file2.Write(startcars);
            file2.Close();

        }

        static void mmRead()
        {
            BinaryReader file3 = new BinaryReader(File.Open("moneymade.bin", FileMode.Open));
            moneymade = file3.ReadDouble();
            file3.Close();

        }
        static void scRead()
        {
            BinaryReader file4 = new BinaryReader(File.Open("startcars.bin", FileMode.Open));
            startcars = file4.ReadInt32();
            file4.Close();
        }

        static void wtb()
        {
            BinaryWriter file = new BinaryWriter(File.Open("statecars.bin", FileMode.Create));
            file.Write(iff);
            file.Close();
        }

        static void rfb()
        {
            BinaryReader file1 = new BinaryReader(File.Open("statecars.bin", FileMode.Open));
            iff = file1.ReadInt32();

          
            file1.Close();
        }
        static void fuckBinaryFiles()
        {
            bool notparked = false;
            bool executed = false;
            using (StreamReader sr = new StreamReader("carTime.txt"))
            {
                Console.WriteLine("----------------------------------------------------------------------------");
                Console.WriteLine("enter registration number");
                Console.WriteLine("----------------------------------------------------------------------------");
                string exitreg = Console.ReadLine();
                bool iscarparked = File.Exists($"{exitreg}.txt");

                while (!sr.EndOfStream)
                {
                    string line = sr.ReadLine();
                    string[] parts = line.Split('=');

                   
                    string variableName = parts[0].Trim();
                    string variableValue = parts[1].Trim();

                    DateTime dateTimeParsed = DateTime.Parse(variableValue);
       
                    if (sr.EndOfStream == true)
                    {
                        notparked = true;
                    }
                    if (exitreg == variableName)
                    {
                        for (int i = 0; i < 5; i++)
                        {

                            if (exitreg == variableName)
                            {
                                regi[i] = gone[0];

                                if (i == 0)
                                {
                                    rfb();


                                    iff--;
                                }
                                while (exitreg == regi[i])
                                {
                                    te += i;
                                }



                            }
                        }
                    }

        
                    if (exitreg == variableName)
                    {

                        if (File.Exists($"{exitreg}recipt.txt") == true)
                        {
                            Console.WriteLine("car already left");
                        }
                        if (File.Exists($"{exitreg}recipt.txt") == false)
                        {
                            wtb();
                            rfb();

                            bool paided;
                            string fileName = $"{exitreg}recipt.txt";
                            DateTime dateTime = DateTime.Now;
                            if (variableName == exitreg)
                            {
                                TimeSpan calc = dateTime - dateTimeParsed;
                                int sec = calc.Seconds;
                                int mins = calc.Minutes;
                                int cal1 = mins * 60;
                                double payment = sec * 0.5 + cal1 * 0.5;
                                if (File.Exists("moneymade.bin") == false)
                                {
                                    mmWrite();

                                }
                                mmRead();
                                moneymade += payment;
                                mmWrite();
                                Console.WriteLine("----------------------------------------------------------------------------");
                                Console.WriteLine("you have to pay {0} £", payment);
                                Console.WriteLine("----------------------------------------------------------------------------");
                                paided = true;
                                te = 0;


                                Console.WriteLine("----------------------------------------------------------------------------");
                                Console.WriteLine("has user paid");
                                Console.WriteLine("----------------------------------------------------------------------------");
                                char paid = (Convert.ToChar(Console.ReadLine().ToLower()));

                                if (paid == 'y')
                                {
                                    animation();

                                }
                                StreamWriter exit = new StreamWriter(fileName);

                                exit.WriteLine("the regisration off the car is {0}", exitreg);
                                exit.WriteLine("\n");
                                exit.WriteLine("car entered at : {1}  car left aT {0}", dateTime, dateTimeParsed);
                                exit.WriteLine("the car payment is {0} and was paid {1}", paided, payment);
                                exit.Close();
                                Console.WriteLine("----------------------------------------------------------------------------");
                                Console.WriteLine("recipt added");
                                Console.WriteLine("----------------------------------------------------------------------------");
                                executed = true;
                            }


                        }

                    }

                }






                sr.Close();

            }
            
            
            
            
            if (notparked == true && executed == false)
            {
                Console.WriteLine("----------------------------------------------------------------------------");
                Console.WriteLine("car dose not exist get out bitch ");
                Console.WriteLine("----------------------------------------------------------------------------");
                fuckBinaryFiles();
            }

        }
        static void fuckBinaryFilesWrite()
        {

            StreamWriter sw = File.AppendText("carTime.txt");
            for (int i = 0; i < 5; i++)
            {

                if (regi[i] != null)
                {

                    sw.WriteLine("{0}={1}", regi[i], timeEntered[i]);

                }
            }
            sw.Close();

        }
        static void mange()
        {
            rfb();
            mmscRead();




        }

        static void animation()
        {
            Console.Clear();
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                           ______                                  ");
            Console.WriteLine(@"                         /|_||_\`.__                              ");
            Console.WriteLine(@"                        (  _    _   _\                            ");
            Console.WriteLine("                        =`-(_)--(_)-'        |||                   ");
            Console.WriteLine("                                                                   ");
            Thread.Sleep(500);
            Console.Clear();
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                            ______                                 ");
            Console.WriteLine(@"                          /|_||_\`.__                             ");
            Console.WriteLine(@"                         (  _    _   _\      |                    ");
            Console.WriteLine("                        =`-(_)--(_)-'        |||                   ");
            Console.WriteLine("                                                                   ");
            Thread.Sleep(500);
            Console.Clear();
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                            ______                                 ");
            Console.WriteLine(@"                          /|_||_\`.__        |                    ");
            Console.WriteLine(@"                         (  _    _   _\      |                    ");
            Console.WriteLine("                        =`-(_)--(_)-'        |||                   ");
            Console.WriteLine("                                                                   ");
            Thread.Sleep(500);
            Console.Clear();
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                           ______             |                    ");
            Console.WriteLine(@"                          /|_||_\`.__         |                   ");
            Console.WriteLine(@"                         (  _    _   _\       |                   ");
            Console.WriteLine("                        =`-(_)--(_)-'        |||                   ");
            Console.WriteLine("                                                                   ");
            Thread.Sleep(500);
            Console.Clear();
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                |                  ");
            Console.WriteLine("                            ______              |                  ");
            Console.WriteLine(@"                          /|_||_\`.__          |                  ");
            Console.WriteLine(@"                         (  _    _   _\        |                  ");
            Console.WriteLine("                         =`-(_)--(_)-'        |||                  ");
            Console.WriteLine("                                                                   ");
            Thread.Sleep(500);
            Console.Clear();
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                |                  ");
            Console.WriteLine("                              ______            |                  ");
            Console.WriteLine(@"                            /|_||_\`.__        |                  ");
            Console.WriteLine(@"                           (  _    _   _\      |                  ");
            Console.WriteLine("                           =`-(_)--(_)-'      |||                  ");
            Console.WriteLine("                                                                   ");
            Thread.Sleep(500);
            Console.Clear();
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                |                  ");
            Console.WriteLine("                               ______           |                  ");
            Console.WriteLine(@"                       -----  /|_||_\`.__      |                  ");
            Console.WriteLine(@"                       ----- (  _    _   _\    |                  ");
            Console.WriteLine("                        ----- =`-(_)--(_)-'    |||                 ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Thread.Sleep(500);
            Console.Clear();
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                                   ");
            Console.WriteLine("                                                |                  ");
            Console.WriteLine("                          -----   ______        |                  ");
            Console.WriteLine(@"                         -----  /|_||_\`.__    |                  ");
            Console.WriteLine(@"                        -----  (  _    _   _\  |                  ");
            Console.WriteLine("                                =`-(_)--(_)-'  |||                 ");
            Console.WriteLine("                                                                   ");

            Thread.Sleep(500);
            Console.Clear();
            Console.WriteLine("                                                                  ");
            Console.WriteLine("                                                                  ");
            Console.WriteLine("                                                                  ");
            Console.WriteLine("                                               |                  ");
            Console.WriteLine("                              -----   ______   |                  ");
            Console.WriteLine(@"                            -----   /|_||_\`._|_                 ");
            Console.WriteLine(@"                             ----  (  _    _  |_\                ");
            Console.WriteLine("                                   =`-(_)--(_)|||-'               ");
            Console.WriteLine("                                                                  ");
            Thread.Sleep(500);
            Console.Clear();
            Console.WriteLine("                                                                  ");
            Console.WriteLine("                                                                  ");
            Console.WriteLine("                                                                  ");
            Console.WriteLine("                                               |                  ");
            Console.WriteLine("                                  -----    ____|__                ");
            Console.WriteLine(@"                                  -----  /|_|||_\`.__            ");
            Console.WriteLine(@"                                  ----  (  _  |   _  _\          ");
            Console.WriteLine("                                         =`-(_|||)--(_)-'         ");
            Console.WriteLine("                                                                  ");
            Thread.Sleep(1000);
            Console.Clear();
            Console.WriteLine(@"            |    \/    ___                                       ");
            Console.WriteLine("             |-|  ||   |___                                       ");
            Console.WriteLine("             |_|  ||   |___                                       ");
            Console.WriteLine("                                               |                  ");
            Console.WriteLine("                                               |  --  ______      ");
            Console.WriteLine(@"                                              | --  /|_||_\`.__  ");
            Console.WriteLine(@"                                              | -- (  _    _  _\ ");
            Console.WriteLine("                                              ||| =`-(_)--(_)-'   ");
            Console.WriteLine("                                                                  ");
            Thread.Sleep(2000);
            Console.Clear();



        }




        static void Main(string[] args)
        {
          

           
              

                Console.WriteLine("----------------------------------------------------------------------------");

                bool end1 = false;

                while (!end1)
                {
                try
                {

                    Menu();
                    Console.WriteLine("Enter a number:");
                    int entered = Convert.ToInt16(Console.ReadLine());

                    if (entered >= 1 && entered <= 4)
                    {
                        switch (entered)
                        {
                            case 1:
                                entercarpark();
                                break;
                            case 2:
                                fuckBinaryFiles();
                                break;
                            case 3:
                                mange();
                                break;
                            case 4:
                                end1 = true;
                                break;
                        }
                    }
                    else
                    {
                        Console.WriteLine("Invalid input. Please enter a number between 1 and 4.");
                    }
                }
                catch (FormatException)
                {
                    Console.WriteLine("Invalid input. Please enter a valid integer.");
                }
           
                }


            
        }

    }
}