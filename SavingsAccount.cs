using System;
using System.Collections.Generic;
using System.Text;

namespace S10205696_MyBankApp
{
    class SavingsAccount : BankAccount
    {
        private double rate;
        public double Rate
        {
            get { return rate; }
            set { rate = value; }
        }
        public SavingsAccount() : base()
        { }
        public SavingsAccount(string a, string n, double b, double r) : base(a, n, b)
        {
            Rate = r;
        }
        public double CalculateInterest()
        {
            return Balance * Rate / 100;
        }
        public override string ToString()
        {
            return "Acc No: " + AccNo + "\tAcc Name: " + AccName + "\tBalance: "
                + Balance + "\tRate: " + Rate;
        }
    }
}
