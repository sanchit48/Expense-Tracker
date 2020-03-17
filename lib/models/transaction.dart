import 'package:flutter/material.dart';

class Transaction {

  // Runtime constant, get their value when transaction is created but afterwards never change
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  // Named aruguments
  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date
  });
}
