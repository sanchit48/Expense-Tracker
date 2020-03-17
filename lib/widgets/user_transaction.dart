import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {

 
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
        NewTransaction(_addNewTransaction),

          // Wrap with container in case of problems in size

        TransactionList(_userTransaction),
      ],
    );
  }
}