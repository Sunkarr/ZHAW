"""
Prog 2
W03
P02 1.2 Bank application

Authors:
Gwendoline Vocat (Vocatgwe), Gian Gamper (Gampegia), Jonas Bratschi (Bratsjon)

Date: 16.03.2024
"""

from SavingsAccount import SavingsAccount
from YouthAccount import YouthAccount
from TaxReport import TaxReport
import datetime


# The BankApplication class is the main class that handles the bank application
class BankApplication:
    """
    A class to represent a bank application.

    Attributes:
        accounts (list): A list of account instances.
        current_account (Account): The current account being operated on.
        closed_accounts (list): A list of closed account instances.

    Methods:
        open_account(account_type): Opens a new account of the specified type.
        close_account(account_number): Closes the account with the given account number.
        check_balance(account_number): Checks the balance of the account with the given account number.
        display_menu(): Displays the application menu.
        run(): Runs the bank application.
    """

    def __init__(self):
        self.accounts = []
        self.current_account = None
        self.closed_accounts = []

    # Method to open a new account
    def open_account(self, account_type):
        """
        Opens a new account of the specified type.

        Args:
            account_type (str): The type of account to open ("savings" or "youth").
        """
        owner = input("Enter the owner's name: ")
        account_type = account_type.lower()

        # Create an instance of the appropriate account type
        if account_type == "savings":
            account = SavingsAccount(owner)

        elif account_type == "youth":
            # Ask for the date of birth and create a YouthAccount instance
            try:
                date_of_birth = input("Enter the date of birth (dd-mm-yyyy): ")
                account = YouthAccount(owner, date_of_birth)

            except ValueError:
                print("Invalid date of birth")
                return

        else:
            print("Invalid account type")
            return

        # Add the account to the list of accounts
        self.accounts.append(account)
        print(f"{account_type.capitalize()} account opened successfully")
        print("Account number: ", account.account_number)

    def close_account(self, account_number):
        """
        Closes the account with the given account number.

        Args:
            account_number (str): The account number of the account to close.
        """
        for account in self.accounts:
            if account.account_number == account_number:
                self.closed_accounts.append(account)
                self.accounts.remove(account)
                print(f"Account {account_number} closed successfully")
                return
            else:
                print(f"Account {account_number} not found")

    def check_balance(self, account_number):
        """
        Checks the balance of the account with the given account number.

        Args:
            account_number (str): The account number of the account to check the balance for.
        """
        for account in self.accounts:
            if str(account.account_number) == str(account_number):
                print(f"Account has a balance of {account.balance} {account.currency}")
                return
            else:
                print(f"Account {account_number} not found")

    # Method to display the menu
    def display_menu(self):
        """
        Displays the application menu.
        """
        print("1: Open account")
        print("2: Close account")
        print("3: Check balance")
        print("4: Deposit")
        print("5: Withdraw")
        print("8: Tax report")
        print("9: Exit")

    # Method to run the application
    def run(self):
        """
        Runs the bank application.
        """
        while True:
            self.display_menu()
            choice = input("Enter your choice: ")

            if choice == "1":
                user_input = input("1: Youth account \n2: Savings Account \nEnter account type: ")
                account_type = ""
                if user_input == "1":
                    account_type = "youth"
                elif user_input == "2":
                    account_type = "savings"
                else:
                    raise ValueError("Invalid Input")
                self.open_account(account_type)
            elif choice == "2":
                account_number = input("Enter account number: ")
                self.close_account(account_number)

            elif choice == "3":
                account_number = input("Enter account number: ")
                self.check_balance(account_number)

            elif choice == "4":
                account_number = input("Enter account number: ")
                amount = input("Enter the amount to deposit: ")
                for account in self.accounts:
                    if (account.account_number) == (account_number):
                        account.deposit(amount)
                        break
                else:
                    print(f"Account {account_number} not found")

            elif choice == "5":
                account_number = input("Enter account number: ")
                amount = input("Enter the amount to withdraw: ")
                for account in self.accounts:
                    if (account.account_number) == (account_number):
                        account.withdraw(amount)
                        break
                else:
                    print(f"Account {account_number} not found")

            elif choice == "8":
                current_year = datetime.datetime.now().year
                print(f"Tax report {current_year} for fiscal year {current_year-1}")
                print(f"Youth Accounts: {TaxReport(self.accounts).total_balance_youth()} Fr.")
                print(f"Savings Accounts: {TaxReport(self.accounts).total_balance_savings()} Fr.")

            elif choice == "9":
                print("Program terminated")
                break
            else:
                print("Invalid choice")


class TaxReport:
    """
    A class to generate tax reports for accounts.

    Attributes:
        accounts (list): A list of account instances.

    Methods:
        total_balance_savings(): Returns the total balance of all savings accounts.
        total_balance_youth(): Returns the total balance of all youth accounts.
    """

    def __init__(self, accounts):
        self.accounts = accounts

    def total_balance_savings(self):
        """
        Returns the total balance of all savings accounts.

        Returns:
            float: The total balance of all savings accounts.
        """
        balance_savings = 0
        for account in self.accounts:
            if account.type == "savings":
                balance_savings += account.get_amount()
        return balance_savings

    def total_balance_youth(self):
        """
        Returns the total balance of all youth accounts.

        Returns:
            float: The total balance of all youth accounts.
        """
        balance_youth = 0
        for account in self.accounts:
            if account.type == "youth":
                balance_youth += account.get_amount()
        return balance_youth


# Instantiate the BankApplication class and run the application
if __name__ == "__main__":
    bank_app = BankApplication()
    bank_app.run()
