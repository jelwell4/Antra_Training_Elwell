using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class Antra_Assignment_C_1
    {
        public static void Main()
        {
            Console.WriteLine("Assignment 1\n\n");

            //playingWithConsoleApp();
            //understandingTypes();
            //compositeFormatting();
            //for (; true;) ;         //-- > Infinite Loop
            //fizzBuzz();
            //weirdTest();            //--> Infinite Loop
            //randNumGame();
            //pyramid();
            //birthDateToDays();
            //greeting();
            //loopDeLoop();



            // Questions answered by hand:

            //1.What type would you choose for the following “numbers”?
            //A person’s telephone number-> int
            //A person’s height-> enum
            //A person’s age -> int
            //A person’s gender(Male, Female, Prefer Not To Answer)  enum
            //A person’s salary -> Decimal
            //A book’s ISBN -> String
            //A book’s price -> Decimal
            //A book’s shipping weight -> double
            //A country’s population -> int
            //The number of stars in the universe -> long
            //The number of employees in each of the small or medium businesses in the
            //United Kingdom(up to about 50,000 employees per business) -> int

            //2.What are the difference between value type and reference type variables? What is
            //boxing and unboxing ?

            //Value Type holds it's data, while a reference type points to an object holding the data.
            //Boxing: Take a value and put it into a reference / object
            //Unboxing: Taking a reference type and making it a value type


            //3.What is meant by the terms managed resource and unmanaged resource in .NET


            //4.Whats the purpose of Garbage Collector in .NET?
            //It is the automatic memory manager.


            //Test your Knowledge:

            //1.What happens when you divide an int variable by 0 ?
            //Runtime error unless caught by compiler, DivideByZeroException : ArithmeticException

            //2.What happens when you divide a double variable by 0 ?
            //Runtime Error unless caught by compiler, DivideByZeroException :  ArithmeticException

            //3.What happens when you overflow an int variable, that is, set it to a value beyond its
            //range?
            //runtime error, OverFlowException

            //4.What is the difference between x = y++; and x = ++y;?
            //In the first case, x will be assigned to the value y currently is, then y will be assigned to a value 1 greater(post increment)
            //In the second, both x and y will equal a value one greater then y's previous value (pre-increment)

            //5.What is the difference between break, continue, and return when used inside a loop
            //statement?
            //Break: terminates the loop that it is in
            //Continue: Skips the rest of the code block for the current loop iteration and continues to the next iteration
            //return: terminates execution of a method, may return a value

            //6.What are the three parts of a for statement and which of them are required ?
            //int variable that is initilized to some value, conditional statement(true or false), increment on variable

            //7.What is the difference between the = and == operators ?
            //= set's two values to be equal
            //== ask's if two values are equal (returns true or false)

            //8.Does the following statement compile ? for (; true;) ;
            //            Surprisingly yes.

            //9.What does the underscore _ represent in a switch expression ?
            //It is the default case

            //10.What interface must an object implement to be enumerated over by using the foreach
            //statement?
            //IEnumerable
    
    }

        // Playing with Console App
        public static void playingWithConsoleApp()
        {
            

            Console.WriteLine("Hacker Name Generator: ");

            Console.WriteLine("\nEnter your Favorite Color: ");
            String color = Console.ReadLine();

            Console.WriteLine("\nEnter your Astrology Sign: ");
            String sign = Console.ReadLine();

            Console.WriteLine("\nEnter your Street Address Number: ");
            String addressNum = Console.ReadLine();

            Console.WriteLine("\nYour Hacker Name: " + color + sign + addressNum);
        }

        // Practice Number Sizes and Ranges
        public static void understandingTypes()
        {
            // Bytes in memory, min/max values
            Console.WriteLine("sbyte:   size:   8 bits, range:  -128 to 127");
            Console.WriteLine("byte:    size:   8 bits, range: 0 to 255");
            Console.WriteLine("short:   size:  16 bits, range: -32768 to 32767");
            Console.WriteLine("ushort:  size:  16 bits, range: 0 to 65535");
            Console.WriteLine("int:     size:  32 bits, range: -2^31 through 2^31 - 1");
            Console.WriteLine("uint:    size:  32 bits, range: 0 to 4294967295");
            Console.WriteLine("long:    size:  64 bits, range: -2^63 through 2^63 - 1");
            Console.WriteLine("ulong:   size:  64 bits, range: 0 to 18446744073709551615");
            Console.WriteLine("float:   size:  32 bits, range: +/- 3.4 * 10 ^ 38");
            Console.WriteLine("decimal: size: 128 bits, range: 28 signigicant figures");
        }

        // Composit Formatting
        public static void compositeFormatting()
        {
            // Converts number of centuries to: years, days, hours, minutes, seconds, millisenconds, microseconds, nanoseconds

            Console.WriteLine("Enter number of centuries: ");
            uint cent = uint.Parse(Console.ReadLine());

            Console.WriteLine("\n" + cent + " is:");

            // Years
            uint years = cent * 100;
            Console.WriteLine("Years: " + years);

            // Days
            uint days = cent * 36500;
            Console.WriteLine("Days: " + days);

            // Hours
            ulong hours = (ulong) cent * 876000;
            Console.WriteLine("Hours: " + hours);

            // Minutes
            ulong minutes = hours * 60;
            Console.WriteLine("Minutes: " + minutes);

            // Seconds
            ulong seconds = minutes * 60;
            Console.WriteLine("Seconds: " + seconds);

            // Milliseconds
            ulong milliseconds = seconds * 1000;
            Console.WriteLine("Milliseconds: " + milliseconds);

            // Microseconds
            ulong microseconds = milliseconds * 1000;
            Console.WriteLine("Microseconds: " + microseconds);

            // Nanoseconds
            ulong nano = microseconds * 1000;
            Console.WriteLine("Nanoseconds: " + nano);
        }

        // Practice Loops and Operators

        //FizzBuzz
        public static void fizzBuzz()
        {
            for (int i = 1; i <= 100; i++)
            {
                if (i % 5 == 0 && i % 3 == 0)
                {
                    Console.WriteLine("FizzBuzz");
                }
                else if(i % 5 == 0)
                {
                    Console.WriteLine("Buzz"); 
                }
                else if(i % 3 == 0)
                {
                    Console.WriteLine("Fizz");
                }
                else
                {
                    Console.WriteLine(i);
                }
            }
        }

        // byte comparing to int Test
        public static void weirdTest()
        {
            int max = 500;
            for (byte i = 0; i < max; i++)
            {
                Console.WriteLine(i);
            }
        }

        // Random Number GuessingGame
        public static void randNumGame()
        {
            int correctNumber = new Random().Next(3) + 1;
            int guess = -1;
            Console.WriteLine("Enter a guess: 1, 2, or 3");
            while (guess != correctNumber)
            {
                
                guess = int.Parse(Console.ReadLine());

                if (guess < 1 || guess > 3)
                {
                    Console.WriteLine("\nInvalid guess, guess again: ");
                }
                else if (guess == correctNumber)
                {
                    Console.WriteLine("Correct! You win!");
                }
                else if (guess < correctNumber)
                {
                    Console.WriteLine("Incorrect, Too Low");
                }
                else
                {
                    Console.WriteLine("Incorrect, Too High");
                }
            }
        }

        // Print a pyramid
        public static void pyramid()
        {
            int starCount = 1;
            for (int i = 0; i < 5; i++)
            {
                for (int j = 4 - i; j > 0; j--)
                {
                    Console.Write(" ");
                }

                for (int j = 0; j < starCount; j++)
                {
                    Console.Write("*");
                }
                starCount++;
                starCount++;
                Console.WriteLine();

            }
        }

        // Birthdate to days
        public static void birthDateToDays()
        {
            Console.WriteLine("Enter your birthdate:\n");

            Console.WriteLine("Month: ");
            int month = int.Parse(Console.ReadLine());

            Console.WriteLine("Day: ");
            int day = int.Parse(Console.ReadLine());

            Console.WriteLine("Year: ");
            int year = int.Parse(Console.ReadLine());

            // Rough Estimate ignoring special Cases

            int daysOld = month * 30 + day + year * 365;

            Console.WriteLine("You are about " + daysOld + " days old!");

        }

        // Greeting based on time of day
        public static void greeting()
        {
            DateTime today = DateTime.Now;

            if (today.Hour < 11)
            {
                Console.WriteLine("Good Morning!");
            }
            else if (today.Hour < 4)
            {
                Console.WriteLine("Good Afternoon!");
            }
            else if (today.Hour < 9)
            {
                Console.WriteLine("Good Evening!");
            }
            else
            {
                Console.WriteLine("Good Night!");
            }
        }

        // Loop in a Loop in a Loop
         public static void loopDeLoop()
        {
            for (int i = 1; i <= 4 ; i++)
            {
                for (int j = 0; j <= 24; j++)
                {
                    if (j != 24)
                        Console.Write(j + ", ");
                    else
                        Console.Write(j);

                    j += +i - 1;
                }
                Console.WriteLine();

            }
            
        }


    }
}
