import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';


class TransactionItem extends StatelessWidget {

  const TransactionItem({

    Key key,
    @required this.transaction,
    @required this.deleteTransaction,

  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(

        elevation: 5,
        margin: EdgeInsets.symmetric(

          vertical: 8,
          horizontal: 5,

        ),

        child: ListTile(leading: CircleAvatar(

          radius: 30,
          child: Padding(

            padding: const EdgeInsets.all(10),
            child: FittedBox(

              child: Text(

                '\$${transaction.amount}',

              )

            )

          ),

        ),

        title: Text(

          transaction.title,
          style: Theme.of(context).textTheme.title,

        ),

        subtitle: Text(

          DateFormat.yMMMd().format(transaction.date),

        ),

        trailing: MediaQuery.of(context).size.width > 460 ?
        FlatButton.icon(

          icon: const Icon(Icons.delete),
          // using const it will not recreate Text object
          label: const Text('Delete'),
          textColor: Theme.of(context).errorColor,
          onPressed: () => deleteTransaction(transaction.id),

        )

        : IconButton(

          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTransaction(transaction.id),

        ),

      ),

    );

  }
  
}
