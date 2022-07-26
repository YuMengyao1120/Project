using System;
using System.Collections.Generic;
using System.Text;

namespace S10205696_MyBankApp
{
    class BankAccount
    {
        private string accNo;
        private string accName;
        private double balance;
        public string AccNo
        {
            get { return accNo; }
            set { accNo = value; }
        }
        public string AccName
        {
            get { return accName; }
            set { accName = value; }
        }
        public double Balance
        {
            get { return balance; }
            set { balance = value; }
        }
        public BankAccount() { }
        public BankAccount(string a, string n, double b)
        {
            AccNo = a;
            AccName = n;
            Balance = b;
        }
        public void Deposit(double amt)
        {
            Balance = Balance + amt;
        }
        public bool Withdraw(double amt)
        {
            if (amt <= Balance)
            {
                Balance = Balance - amt;
                return true;
            }
            else
            {
                return false;
            }
        }
        public override string ToString()
        {
            return "Acc No: " + AccNo + "\tAcc Name: " + AccName + "\tBalance: " + Balance;
        }
    }
}
