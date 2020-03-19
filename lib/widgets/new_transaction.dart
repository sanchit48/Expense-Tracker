import 'dart:io';

import 'package:expense_tracker/widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './adaptive_button.dart';

import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();

}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {

    if(_amountController.text.isEmpty)
      return;

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    // establish connection  to addNewTransaction function
    widget.addNewTransaction(enteredTitle, enteredAmount,_selectedDate);

    Navigator.of(context).pop();

  }

  void _presentDatePicker() {

    showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now()

    ).then((pickedDate) {

         if(pickedDate == null)
          return;

      setState(() {
        _selectedDate = pickedDate;

      });

    });

  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

        child: Card(

        elevation: 5,
        child: Container(

          padding: EdgeInsets.only(

            top: 20,
            left: 10,
            right: 10,
            // keyboard in the way
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,

          ),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              TextField(

                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),      // submitData wants argument String so do this

              ),

              TextField(

                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),  // SubmitData wants argument String so do this

              ),

              Container(

                height: 70,
                child: Row(children: <Widget>[

                  Expanded(

                    child: Text(_selectedDate == null ? 'No Date Chosen' : DateFormat.yMd().format(_selectedDate))

                  ),

                  AdaptiveButton('Chosen Date', _presentDatePicker)

                ],),

              ),

              RaisedButton(

                color: Theme.of(context).primaryColor,
                child: Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,

              )

            ],

          ),

        ),

      ),

    );

  }

}