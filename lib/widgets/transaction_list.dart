import 'package:flutter/material.dart';
import '../classes/transaction.dart';
import '../widgets/transaction_single_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _removeTransaction;
  const TransactionList(this._transactions, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, container) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transaction added yet!',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: container.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return TransactionSingleItem(
                  transaction: _transactions[index],
                  removeTransaction: _removeTransaction);
            },
            itemCount: _transactions.length,
          );
  }
}
