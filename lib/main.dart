import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

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

    Transaction(id: DateTime.now().toIso8601String(), title: 'ndd', amount: 44, date: DateTime.now()),
    Transaction(id: DateTime.now().toIso8601String(), title: 'ndd', amount: 44, date: DateTime.now()),
    Transaction(id: DateTime.now().toIso8601String(), title: 'ndd', amount: 44, date: DateTime.now()),
    Transaction(id: DateTime.now().toIso8601String(), title: 'ndd', amount: 44, date: DateTime.now()),
    Transaction(id: DateTime.now().toIso8601String(), title: 'ndd', amount: 44, date: DateTime.now()),
    Transaction(id: DateTime.now().toIso8601String(), title: 'ndd', amount: 44, date: DateTime.now()),
    Transaction(id: DateTime.now().toIso8601String(), title: 'ndd', amount: 44, date: DateTime.now()),
    Transaction(id: DateTime.now().toIso8601String(), title: 'ndd', amount: 44, date: DateTime.now()),
    Transaction(id: DateTime.now().toIso8601String(), title: 'ndd', amount: 44, date: DateTime.now()),


  ];

  bool _showChart = false;

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

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {

    return [Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

        Text('Show Chart', style: Theme.of(context).textTheme.title,),
        Switch.adaptive(

          activeColor: Theme.of(context).accentColor,
          value: _showChart,
          onChanged: (value) {

            setState(() {
              _showChart = value;
            });

          },

        ),

      ],

    ), _showChart
    ? Container(

      height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
      child: Chart(_recentTransaction)

    )
    : txListWidget];

  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {

    return [Container(

        height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.3,
        child: Chart(_recentTransaction)

    ), txListWidget];

  }

  Widget _navigationbar()  {

    return Platform.isIOS
    ? CupertinoNavigationBar(

      middle: Text('Personal Expenses'),
      trailing: Row(

        mainAxisSize: MainAxisSize.min,
        children: [
        // make own button
        GestureDetector(

          child: Icon(CupertinoIcons.add),
          onTap: () => _startAddNewTransaction(context),

        )

      ]),

    )

    : AppBar(

      title: Text('Personal Expenses'),
      actions: <Widget>[

        IconButton(

          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),

        )

      ],

    );

  }


///*********************************************BUILD****************************************************/

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final isLandScape = (mediaQuery.orientation == Orientation.landscape);

    final PreferredSizeWidget appBar =  _navigationbar();

    final txListWidget  = Container(

        height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.82,
        child: TransactionList(_userTransaction, _deleteTransaction)

    );

    final pageBody = SafeArea(

      child: SingleChildScrollView(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            // use spread operator as children accepts widget not list
            if(isLandScape) ..._buildLandscapeContent(mediaQuery, appBar, txListWidget),

            if(!isLandScape) ..._buildPortraitContent(mediaQuery, appBar, txListWidget),

          ],

        ),

      ));

    return Platform.isIOS
    ? CupertinoPageScaffold(

      child: pageBody,
      navigationBar: appBar,

    )

    : Scaffold(

      appBar: appBar,
      body: pageBody,


      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
        ? ''

        : FloatingActionButton(

        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),

       ),

    );

  }

}