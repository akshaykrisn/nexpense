import 'package:nexpense/transaction.dart';
import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
    "type": "service_account",
    "project_id": "zeta-medley-326804",
    "private_key_id": "ed4b6ce33c36ada99dcb137c9733aba03c73256d",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCxtJh7wWSl6o6V\nXHBJlA1FfgQDduF1sqEWbINYosjs5N7JAylpflQuudPYASD4xUnoiouDaaJoG4EZ\nDsgpqojytcO6uCEh+LF/6BVu0zEukOFHhV9ymq096KR8fV+ZZGJA+GdQVLRuCjOU\neQvgRrlOFG8z+xUh0SqTEYj+NLhfDyP1HNKkTLSj3eWWlZlec+j6etZ4pWOCLPhD\nXgfdoDk2sty7kdNp0rOYuokue9HpIBIa4KAg9X2hAX2s/xtpN3z9QLRHbfZIdvLL\nJrcxk+PktKaOB8DGm5AOCNDTyMJTZgW5b+GQFFSCdJs6s+CS3USzFsQ+JaqUeLvj\nG7E0f2bXAgMBAAECggEAQr86pwE09LztYVyfMIPTmE6E42g7tyGpL+sCSsCaB6DP\nrWDqpR02MXbLA08pO0efQyEG1g1PWxs5mlfbBwtu9Psg0XlnuILY6Nobcs0QpBT3\nCQ4nk7xVZfOEFN5ikhMKdKzY4WtvegWK6jGtLEhkQdebDUM55MHT4/mqIxFaTxmX\nXnF+Pnr/uIo0/O3UJf2lq+HcmESFL7Hefu5eICKRO07pI0+Y8yBmA1jiPfGa4ahC\nCWP23LGDwONi0dz7LKSSSdze4WWHh0a0nSNXp5XmVssDUq7QzknSZa2in0yrPfaM\n+j+UE82I0dl5VvzNS66RWhOnqJtJShFgG+KxGEFzAQKBgQDwdYVV0Ejg4l/Vk/Id\nHsFD3/vRL/8UCyS+RK9AOjGhz44An7Ityk/x7YvepES4gEqjcddJxaoiFjQ4vaH9\n0w5VgXHqaf/TrE9zFBmrB/l/ryNVr9l219KVe47VIOgx6geBzlAALPYSR71R24Eh\nFD/Ual2E4Is5vgQV7NB4LxZO0QKBgQC9MMtat6GsHee/5lJwemq5TgAji7IRWwEX\nIGkXMPHHw1NnhoaUtKEHWX5PyH2PLw/MfYt0zNsJJrlDYgM1nSbrQ725qM2jBIC6\n1CuynHEQTARbSqYOudgHzkujinNMfqYzinv/eDvUP4SAsZVgT6a0VVFQta3jrak0\n7LJraI5VJwKBgF34z571w0V/sow5QUl4F3d7NWJPK5SdtkJVfVfQZk0iXBCKWIvk\noNGfUCY2dFTWblTpzIUcJp0jqEz0bzZPIS7xY5+ExWHn2TTUCiP4/dyUiW6XRplX\nRwj8PJm2PogjOcPU6Rboe1Ixjx9KdXCEBV3yI5ImXsK2K8qVvfL6E/HBAoGACSgn\nb4ibxpzb7qnTK6aBK97emtnUEIr7Dod/DqRLz4Ngsg4MzX3AnX5zYqEtkpSQizE4\nYrrXjyXUqbJAvYORsqlgsW++JDm/kUtbohV4U3WacGC4kNXl4trVRmEZG4a1vKDj\nR4YmPyuj2ia+OB8izm+is+lXNUHegrVCHXi+CtkCgYBZO1QMemAMzaZOyUAs1a/N\nMehjgqNz5qLEA40+SNWkFU7PbB5wWsS16nv05Xk0JbZTk9CIH/lB/Gp0RGpOE59z\nQhwDRrBjsHjTqE6BbTKSOTvYzKLryajf2Bh6xzcMUJ5gzZEqAERyILA9Vfg3wyro\nGc/0f4nnio5CZNGtCLxW+Q==\n-----END PRIVATE KEY-----\n",
    "client_email": "expty-524@zeta-medley-326804.iam.gserviceaccount.com",
    "client_id": "109481397836981222947",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/expty-524%40zeta-medley-326804.iam.gserviceaccount.com"
  }

  ''';
  // set up & connect to the spreadsheet
  static final _spreadsheetId = '12IKZEGTFbJ9TyKvun1VzeHZPPzHlKRGnm01SCZRHwQE';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<MyTransaction> currentTransactions = [];
  static bool loading = true;

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Sheet1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);
      final String transactionCategory =
          await _worksheet!.values.value(column: 4, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add(MyTransaction(
            transactionName: transactionName,
            money: transactionAmount,
            expenseOrIncome: transactionType,
            transactionCategory: transactionCategory));
      }
    }
    // this will stop the circular loading indicator
    loading = false;
  }

  // insert a new transaction
  static Future insert(
      String name, String amount, bool _isIncome, String category) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add(MyTransaction(
        transactionName: name,
        money: amount,
        expenseOrIncome: _isIncome == true ? 'income' : 'expense',
        transactionCategory: category));
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
      category,
    ]);
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i].expenseOrIncome == 'income') {
        totalIncome += double.parse(currentTransactions[i].money);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i].expenseOrIncome == 'expense') {
        totalExpense += double.parse(currentTransactions[i].money);
      }
    }
    return totalExpense;
  }
}
