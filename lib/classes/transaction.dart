import 'package:flutter/foundation.dart';

class Transaction{
  final String id,name;
  final double amount;
  final DateTime date;
  const Transaction({
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.date
  });
}