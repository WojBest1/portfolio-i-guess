using System.ComponentModel.Design;

Console.Write("enter name 1");
string name1 = Console.ReadLine();
Console.Write("enter name2");
string name2 = Console.ReadLine();
Console.Write("enter name 3");
string name3 = Console.ReadLine();
//write 3 names it then puts them in order
if (string.Compare(name1, name2) < 0 && string.Compare(name2, name3) < 0)//&& string.Compare
{
    Console.WriteLine(" {0}{1}{2}", name1, name2, name3);
}


else if (string.Compare(name2, name1) < 0 && string.Compare(name3, name2) < 0) // && string.Compare(name3,name1) < 0)
{
    Console.WriteLine("{0} {1} {2} yes", name3, name2, name1);
}
//                 c       a                           c       b
else if (string.Compare(name3, name2) < 0 && string.Compare(name1, name2) < 0 && string.Compare(name3, name1) > 0)
{
    Console.WriteLine("{0} {1} {2} yes8", name1, name3, name2);//mod
}
else if (string.Compare(name3, name2) < 0 && string.Compare(name1, name2) < 0) // && string.Compare(name3,name1) < 0)
{
    Console.WriteLine("{0} {1} {2} yes3", name3, name1, name2);//mod
}

//                       m      z                            k       z                           m      k


//                       b       y                           b      z                            z       y       
//else if (string.Compare(name2, name3) < 0 && string.Compare(name2, name1) < 0 && string.Compare(name1, name3) < 0)// && string.Compare(name1, name3) > 0) // && string.Compare(name3,name1) < 0)
//{
//    Console.WriteLine("{0} {1} {2} yes7", name2, name3, name1);//mod
//}
//                  a       f                           A       g                            b       c   
else if (string.Compare(name2, name3) < 0 && string.Compare(name2, name1) < 0 && string.Compare(name1, name3) < 0)// && string.Compare(name1, name3) > 0) // && string.Compare(name3,name1) < 0)
{
    Console.WriteLine("{0} {1} {2} yes2", name2, name1, name3);//mod


}


else if (string.Compare(name2, name3) < 0 && string.Compare(name2, name1) < 0 && string.Compare(name3, name1) < 0)
{
    Console.WriteLine("{0} {1} {2} yes5", name2, name3, name1);// corect
}
//                    z      f                           u     f                                                         1=u 2= f 3 =z
else if (string.Compare(name3, name2) > 0 && string.Compare(name1, name2) > 0) // && string.Compare(name3,name1) < 0)
{
    Console.WriteLine("{0} {1} {2} yes6", name2, name1, name3);

}
else
    Console.WriteLine("error");
//The C# Compare() method is used to compare first string with second string lexicographically. It returns an integer value.
//If both strings are equal, it returns 0. If first string is greater than second string, it returns 1 else it returns -1 if in order.

//1 23 45 6 7 8 9 10