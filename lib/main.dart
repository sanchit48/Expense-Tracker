import 'package:expense_tracker/widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Personal Expenses',
      theme: ThemeData(

        primarySwatch:  Colors.brown,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(

          title: TextStyle(

            fontFamily: 'QuickSand',
            fontWeight: FontWeight.bold,
            fontSize: 18,

          ),

          button: TextStyle(color: Colors.white)

        ),

        appBarTheme: AppBarTheme(

          textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(

            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,

            ),
          ),
        )

      ),
      home: MyHomePage(),
    );
  }
}

// widget class
class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

// state class
class _MyHomePageState extends State<MyHomePage> {

   final List<Transaction> _userTransaction = [

     Transaction(id: 't1', title: 'New Shoes', amount: 999.99, date: DateTime.now()),
     Transaction(id: 't2', title: 'New Shirt', amount: 599.99, date: DateTime.now()),
     Transaction(id: 't3', title: 'New Phone', amount: 9999.99, date: DateTime.now()),

  ];

  List<Transaction> get _recentTransaction {

    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days:7)
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {

    setState(() {
        _userTransaction.add(Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: chosenDate));
    });
  }

  void _deleteTransaction(String id) {

    setState(() {

      _userTransaction.removeWhere((tx) {

        return tx.id == id;

      });

    });

  }

  void _startAddNewTransaction(BuildContext ctx) {

    showModalBottomSheet(context: ctx, builder: (_) {

      return GestureDetector(
        onTap: () {},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );

    },);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text('Personal Expenses'),
        actions: <Widget>[

          IconButton(

            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),

          )

        ],

      ),

      body: SingleChildScrollView(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Chart(_recentTransaction),

            TransactionList(_userTransaction, _deleteTransaction),

          ],

        ),

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(

        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),

       ),

    );

  }

}