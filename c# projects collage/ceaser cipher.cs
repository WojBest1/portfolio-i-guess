

class Program
{
    


    static void menu()
    {
        Console.WriteLine("1: encrypt");
        Console.WriteLine("2: decrypt");
        Console.WriteLine("3: exit");
    }
    static void encrypt()
    {
        char[] alphabett = new char[53] { ' ', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'n', 'm', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'n', 'm', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };
        Console.WriteLine("ener jump");
        int jump = (Convert.ToInt16(Console.ReadLine()));
        Console.WriteLine("enter sentence");
        string sentence = Console.ReadLine();
        int um = 0;
        bool enogh = false;
     
        while (um < sentence.Length)
        {
            for (int i = 0; i <= 27; i++)
            {
                if (i == 27 && um < sentence.Length)
                {
                    um++;
                    i = 0;
                    enogh = false;
                }
                if (um < sentence.Length)
                {
                    if (alphabett[0] == sentence[um] && enogh == false)
                    {
                        Console.Write(' ');
                        enogh = true;
                    }

                    if (alphabett[i] == sentence[um] && alphabett[0] != sentence[um])
                    {
                        char ll = alphabett[i + jump];
                        Console.Write(ll);
                    }



                }
            }
        }
        
    }
    static void decrypt()
    {
        char[] reversealphabett = new char[53] { ' ', 'z', 'y', 'x', 'w', 'v', 'u', 't', 's', 'r', 'q', 'p', 'o', 'n', 'm', 'l', 'k', 'j', 'i', 'h', 'g', 'f', 'e', 'd', 'c', 'b', 'a', 'z', 'y', 'x', 'w', 'v', 'u', 't', 's', 'r', 'q', 'p', 'o', 'n', 'm', 'l', 'k', 'j', 'i', 'h', 'g', 'f', 'e', 'd', 'c', 'b', 'a' };

        Console.WriteLine("ener jump");
        int jump = (Convert.ToInt16(Console.ReadLine()));
        Console.WriteLine("enter sentence");
        string sentence = Console.ReadLine();
        int um = 0;
        bool enogh = false;
        while (um < sentence.Length)
        {
            for (int i = 0; i <= 27; i++)
            {
                if (i == 27 && um < sentence.Length)
                {
                    um++;
                    i = 0;
                    enogh = false;
                }
                if (um < sentence.Length)
                {
                    if (reversealphabett[0] == sentence[um] && enogh == false)
                    {
                        Console.Write(' ');
                        enogh = true;
                    }

                    if (reversealphabett[i] == sentence[um] && reversealphabett[0] != sentence[um])
                    {
                        char ll = reversealphabett[i + jump];
                        Console.Write(ll);
                    }



                }
            }
        }
    }


    static void Main(string[] args)
    {
        menu();
        int oneOrtwo = (Convert.ToInt16(Console.ReadLine()));
        do
        {
            if (oneOrtwo == 1)
            {
                encrypt();

            }
            if (oneOrtwo == 2)
            {
                decrypt();
            }
            else 
            {
                Console.WriteLine("Invalid response");
                Console.ReadKey();
            }

        } while (oneOrtwo != 3);
        

    }

}
 


