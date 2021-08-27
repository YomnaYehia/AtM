import 'dart:io';

class Account {
  int accountNumber = 5523636;
  String ownerName = 'Yomna';
  double balance = 3000;

  Account.NamedConstructor() {
    details();
  }

  Account() {
    accountNumber;
    ownerName;
    balance;
  }

  // ignore: always_declare_return_types
  details() {
    print('Account number = $accountNumber');
    print('Hello $ownerName,  you balance = $balance');
  }
}

abstract class Tranaction extends Account {
  var transaction;

  double excute();
}

var currbalance;

class Deposite extends Tranaction {
  var amount;
  Deposite() {
    excute();
  }
  @override
  double excute() {
    print('enter amount you want to  deposite');
    amount = double.parse(stdin.readLineSync()!);

    currbalance = amount! + super.balance;

    print('your current balance = $currbalance');
    return currbalance;
  }
}

class WithDrow extends Tranaction {
  var amount;
  WithDrow() {
    excute();
  }

  @override
  double excute() {

    print('enter amount you want to  withdraw');
    amount = double.parse(stdin.readLineSync()!);

    if (amount <= currbalance) {
      currbalance = currbalance - amount;
      print('You can withdrow that amount, your balance = $currbalance');
    } else {
      print(
          'your balance is less than what you want, your balance = $currbalance');
    }
    return currbalance;
  }
}

class BalanceInQuery extends Tranaction {
  var currencyType;
  BalanceInQuery() {
    excute();
  }

  @override
  double excute() {
    print('enter U for USD or E for Euro');
    currencyType = stdin.readLineSync()!;

    switch (currencyType) {
      case 'U':
        currencyType = 'USD';
        break;
      case 'E':
        currencyType = 'Euro';
        break;
      default:
        print('Invalid');
    }
    print('Your balance = $currbalance  $currencyType');
    return currbalance;
  }
}

class RollBack extends WithDrow {
  RollBack() {
    cancel();
  }

  void cancel() {
    currbalance = currbalance + amount;
    print(
        'The last transaction has been canceled, your current balance = $currbalance');
  }
}

class Tester
    implements Account, Tranaction, BalanceInQuery, WithDrow, Deposite, RollBack
    {
  int num = int.parse(stdin.readLineSync()!);

  void options() {
    for (num = 1; num <= 6; num++) {
      if (num == 1) {
        Account.NamedConstructor();
      }
      if (num == 2) {
        Deposite();
      }
      if (num == 3) {
        WithDrow();
      }
      if (num == 4) {
        BalanceInQuery();
      }
      if (num == 5) {
        RollBack();
      }
      if (num == 6) {
        break;
      }
    }
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  print(' press 1 to enter accunt details \n '
      'Press 2 to deposit \n '
      'Press 3 to withdraw \n'
      ' Press 4 to show current balance \n'
      ' Press 5 to cancel last transaction \n '
      'Press 6 to exit');
  var t1 = Tester();
  t1.options();
}
