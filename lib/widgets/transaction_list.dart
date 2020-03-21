import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {

    final List<Transaction> userTransaction;
    final Function  deleteTransaction;
    TransactionList(this.userTransaction, this.deleteTransaction);

    @override
    Widget build(BuildContext context) {

      return userTransaction.isEmpty ? LayoutBuilder(builder: (context, constraints) {

        return Column(

          children: [

            Text(

              'No Transactions added yet',
              style: Theme.of(context).textTheme.title,

            ),
            // used to separate two widgets
            const SizedBox(

              height: 10,

            ),

            Container(

              height: constraints.maxHeight * 0.6,
              child: Image.asset(

                'assets/images/waiting.png',
                fit: BoxFit.cover,

              )

            )

          ]

        );

      })
      :
            ListView.builder(

            itemBuilder: (ctx, index) {

              return TransactionItem(transaction: userTransaction[index], deleteTransaction: deleteTransaction);

            },

            itemCount: userTransaction.length,

        );


  }

}

