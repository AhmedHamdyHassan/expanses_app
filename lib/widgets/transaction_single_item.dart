import 'package:flutter/material.dart';
import '../classes/transaction.dart';
import 'package:intl/intl.dart';

class TransactionSingleItem extends StatelessWidget {
  const TransactionSingleItem({
    Key key,
    @required Transaction transaction,
    @required Function removeTransaction,
  })  : _transaction = transaction,
        _removeTransaction = removeTransaction,
        super(key: key);

  final Transaction _transaction;
  final Function _removeTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.purple,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  "${_transaction.amount.toStringAsFixed(2)}\$",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
        title: Text(
          _transaction.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          DateFormat().format(_transaction.date),
        ),
        trailing: MediaQuery.of(context).orientation == Orientation.landscape
            ? FlatButton.icon(
                onPressed: () => _removeTransaction(_transaction.id),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _removeTransaction(_transaction.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
