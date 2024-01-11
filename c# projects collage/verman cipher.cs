using System.Security.Cryptography;
using System.Text;
using System.Transactions;
using System.Xml.Linq;

namespace Verman_cipher
{
    internal class Program
    {
        static void menu()
        {
            Console.WriteLine("1:encrypt");
            Console.WriteLine("2:decrypt");
        }



        static void key()
        {
            Console.WriteLine("Enter words");
            string words = Console.ReadLine();

            string name = "";
            for (int i = 0; i < words.Length; i++)
            {
                name += Convert.ToString(words[i], 2).PadLeft(7, '0');
            }

            string key = "";
            Random rnd = new Random();
            for (int i = 0; i < words.Length; i++)
            {
                char randomChar = (char)rnd.Next(34, 127);
                key += randomChar;
            }

            string binaryEquivalentofKey = "";
            for (int i = 0; i < words.Length; i++)
            {
                binaryEquivalentofKey += Convert.ToString(key[i], 2).PadLeft(7, '0');
            }
            int t = words.Length * 7;
            string xor = "";


            for (int ii = 0; ii < t; ii++)
            {
                if (binaryEquivalentofKey[ii] == name[ii])
                {
                    xor += '0';
                }
                if (binaryEquivalentofKey[ii] != name[ii])
                {
                    xor += '1';
                }
            }


            double bits = 0;
            int ik = 7 * words.Length;

            double[] finalnum = new double[ik];
            int up = 0;
            double calc;
            int ahh = ik - 1;

            int iii = 0;
            int donetimes = 0;
            double gofy = 0;


            for (int ii = iii; ii < ik; ii++)
            {

                if (ahh > -1)
                {

                    calc = Math.Pow(2, bits);


                    if (xor[ahh] == '1')
                    {

                        finalnum[up] += calc;
                        gofy += calc;
                        up++;
                    }
                    if (up == 17)
                    {
                        Console.WriteLine("");
                    }



                    bits++;
                    if (bits == 7)
                    {
                        iii += 8;

                        iii = 0;
                        calc = 0;
                        bits = 0;
                        donetimes++;
                        if (ahh != -1)
                        {
                            finalnum[up] += 255;
                            up++;
                        }

                    }


                }
                if (ahh > -1)
                {
                    ahh--;
                }

            }




            int oy = 0;
            int omg = 0;
            double[] idkarray = new double[ik];
            double numbs = 0;
            for (int u = 0; u < ik; u++)
            {
                if (finalnum[u] != 0)
                {
                    omg++;
                }

            }
            int omg1 = omg - 2;
            for (int i = omg1; i > -1; i--)
            {
                if (finalnum[i] != 255)
                {
                    numbs += finalnum[i];
                }
                if (i == 0)
                {
                    idkarray[oy] += numbs;


                }
                if (finalnum[i] == 255)
                {

                    idkarray[oy] += numbs;

                    oy++;
                    numbs = 0;

                }

            }
            Console.WriteLine("the key is {0} ", key);
            Console.WriteLine("---------------------------------");
            Console.WriteLine("the message to bee sent is ");
            StreamWriter writer = new StreamWriter("lastsession.txt");
            for (int o = 0; o < words.Length; o++)
            {
                if (idkarray[o] > 34)
                {
                    int k = Convert.ToInt32(idkarray[o]);

                    char asciiChar = Convert.ToChar(k);

                    Console.Write(asciiChar);


                }
                if (idkarray[o] <= 34)
                {


                    Console.Write("!{0}!", idkarray[o]);

                }



            }


        }



        static void Decrypt()
        {



            Console.WriteLine("ENTER MESSAGE");
            string message = Console.ReadLine();
            Console.WriteLine("ENTER KEY");
            string key = Console.ReadLine();

            int up = 0;
            string messageBin = "";
            string temp = "";


            int t = key.Length * 8;

            double bits = 0;
            double[] finalnum = new double[t];

            double calc;


            int iii = 0;
            int donetimes = 0;
            double gofy = 0;
            int uu = 0;
            int ik = 7 * key.Length;






            for (int m = 0; m < message.Length; m++)
            {
                if (message[m] == '!')
                {
                    uu++;
                }


            }
      ;

            for (int i = 0; i != -1; i++)
            {

                if (message.Length == up)
                {
                    i = -2;
                }


                if (message.Length != up)
                {
                    if (message[up] != '!')
                    {
                        string binary1 = Convert.ToString(message[up], 2).PadLeft(7, '0');
                        messageBin += binary1;
                    }

                    if (message[up] == '!')
                    {

                        up++;

                        while (message[up] != '!')
                        {

                            temp += message[up];

                            up++;


                        }

                        int conv = Convert.ToInt32(temp);
                        string binary = Convert.ToString(conv, 2).PadLeft(7, '0');
                        messageBin += binary;
                        temp = "";



                    }

                    up++;
                }
            }




            int bro = key.Length * 7;

            string xorde = "";
            string keyBin = "";
            foreach (char c in key)
            {
                keyBin += Convert.ToString(c, 2).PadLeft(7, '0');

            }

            for (int i = 0; i < bro; i++)
            {

                if (i == 130)
                {
                    Console.WriteLine("");
                }

                if (keyBin[i] == messageBin[i])
                {
                    xorde += '0';


                }
                if (keyBin[i] != messageBin[i])
                {
                    xorde += '1';


                }

            }



            int ahh = ik - 1;
            up = 0;
            for (int ii = iii; ii < ik; ii++)
            {

                if (ahh > -1)
                {

                    calc = Math.Pow(2, bits);


                    if (xorde[ahh] == '1')
                    {

                        finalnum[up] += calc;
                        gofy += calc;
                        up++;
                    }




                    bits++;
                    if (bits == 7)
                    {
                        bits = 0;
                        donetimes++;
                        if (ahh != -1)
                        {
                            finalnum[up] += 255;
                            up++;
                        }

                    }


                }
                if (ahh > -1)
                {
                    ahh--;
                }

            }

            int oy = 0;
            int omg = 0;
            double[] idkarray = new double[ik];
            double numbs = 0;
            for (int u = 0; u < ik; u++)
            {
                if (finalnum[u] != 0)
                {
                    omg++;
                }

            }
            int omg1 = omg - 2;
            for (int i = omg1; i > -1; i--)
            {
                if (finalnum[i] != 255)
                {
                    numbs += finalnum[i];
                }
                if (i == 0)
                {
                    idkarray[oy] += numbs;


                }
                if (finalnum[i] == 255)
                {

                    idkarray[oy] += numbs;

                    oy++;
                    numbs = 0;

                }

            }

            Console.WriteLine("the secret is ");
            for (int o = 0; o < key.Length; o++)
            {
                if (idkarray[o] > 34)
                {
                    int k = Convert.ToInt32(idkarray[o]);

                    char asciiChar = Convert.ToChar(k);

                    Console.Write(asciiChar);
                }
                if (idkarray[o] == 32)
                {
                    Console.Write(" ");

                }
                /*
                if (idkarray[o] <= 34)
                {
                    Console.Write(@"\{0}/", idkarray[o]);


                }
                */
            }


        }

        static void Main(string[] args)
        {

            menu();
            int input = Convert.ToInt16(Console.ReadLine());
            if (input == 1)
            {

                key();

            }
            if (input == 2)
            {

                Decrypt();
            }
        }
    }
}

//':l@s:E&c+/dF=4y_orB'<:)b8Cq[W$y0+6Rr?x3a{