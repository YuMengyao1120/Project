using System;
using System.IO;
using System.Collections.Generic;

namespace S10205696_MyBankApp
{
    class Program
    {
        static void Main(string[] args)
        {
            //Q3-part a
            List<SavingsAccount> savingsAccList = new List<SavingsAccount>();
            initSavingsAccList(savingsAccList);

            int option;
            while (true)
            {
                //Q3-part b Diplay the menu
                DisplayMenu();
                Console.WriteLine("Enter option : ");
                option = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine("\n");

                if (option == 1)
                {
                    DisplayAll(savingsAccList);
                }

                else if (option == 2)
                {
                    Console.WriteLine("Enter the Account Number: ");
                    string accNo = Console.ReadLine();
                    SavingsAccount s = SearchAcc(savingsAccList, accNo);
                    if (s is null)
                    {
                        Console.WriteLine("Unable to find account number. Please try again.");
                    }
                    else
                    {
                        Console.WriteLine("Amount to deposit: ");
                        double amt = Convert.ToDouble(Console.ReadLine());
                        s.Deposit(amt);
                        Console.WriteLine("${0} deposited successfully", amt);
                        Console.WriteLine(s.ToString());
                    }
                    Console.WriteLine("\n");
                }

                else if (option == 3)
                {
                    Console.WriteLine("Enter the Account Number: ");
                    string accNo = Console.ReadLine();
                    SavingsAccount s = SearchAcc(savingsAccList, accNo);
                    if (s is null)
                    {
                        Console.WriteLine("Unable to find account number. Please try again.");
                    }
                    else
                    {
                        Console.WriteLine("Amount to withdraw: ");
                        double amt = Convert.ToDouble(Console.ReadLine());

                        if (s.Withdraw(amt) == true)
                        {
                            Console.WriteLine("${0} withdrawn successfully", amt);
                            Console.WriteLine(s.ToString());
                        }
                        else
                        {
                            Console.WriteLine("Insufficient funds.");
                        }
                    }
                    Console.WriteLine("\n");
                }

                else if (option == 4)
                {
                    Console.WriteLine("{0,-10 }  {1,-10 }  {2,-10 }  {3,-10 }  {4,-10}"
                        , "Acc No", "Acc Name", "Balance", "Rate", "Interest Amt");
                    for (int i = 0; i < savingsAccList.Count; i++)
                    {
                        SavingsAccount c = savingsAccList[i];
                        Console.WriteLine("{0,-10 }  {1,-10 }  {2,-10 }  {3,-10 }  {4,-10}"
                        , c.AccNo, c.AccName, c.Balance, c.Rate, c.CalculateInterest());
                    }
                    Console.WriteLine("\n");
                }

                else if (option == 0)
                {
                    Console.WriteLine("---------");
                    Console.WriteLine("Goodbye!");
                    Console.WriteLine("---------");
                    break;
                }

                else
                {
                    Console.WriteLine("Please enter the valid command. Try again.\n");
                }
            }
        }
        static void initSavingsAccList(List<SavingsAccount> sList)
        {
            string[] csvLines = File.ReadAllLines("savings_account.csv");
            for (int i = 1; i < csvLines.Length; i++)
            {
                string[] data = csvLines[i].Split(',');
                sList.Add(new SavingsAccount(data[0], data[1], Convert.ToDouble(data[2]), Convert.ToDouble(data[3])));
            }
        }
        static void DisplayMenu()
        {
            Console.WriteLine("Menu");
            Console.WriteLine("[1] Diaplay all accounts");
            Console.WriteLine("[2] Deposit");
            Console.WriteLine("[3] Withdraw");
            Console.WriteLine("[4] Display details");
            Console.WriteLine("[0] Exit");
        }
        static void DisplayAll(List<SavingsAccount> sList)
        {
            for (int i = 0; i < sList.Count; i++)
            {
                Console.WriteLine(sList[i].ToString());
            }
            Console.WriteLine("\n");
        }
        static SavingsAccount SearchAcc(List<SavingsAccount> sList, string accNo)
        {
            for (int i = 0; i < sList.Count; i++)
            {
                if (accNo == sList[i].AccNo)
                {
                    return sList[i];
                }
            }
            return null;
        }
    }
}
