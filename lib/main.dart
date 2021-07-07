import 'dart:io';
import 'package:flutter/cupertino.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './classes/transaction.dart';

void main() {
  runApp(MyApp());
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomePage(),
        title: 'Expanses App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.purple,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor),
              button: TextStyle(color: Colors.white)),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showChart = false;
  final List<Transaction> transactions = [];
  List<Transaction> get _recentTransactions {
    return transactions.where((singleTransaction) {
      return singleTransaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addTransaction(String title, double amount, DateTime selectedDate) {
    final Transaction newTranscation = Transaction(
        id: selectedDate.toString(),
        name: title,
        amount: amount,
        date: selectedDate);
    setState(() {
      transactions.add(newTranscation);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      transactions.removeWhere((singleTransaction) {
        return singleTransaction.id == id;
      });
    });
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Widget> _buildLandScapeMode(
      MediaQueryData mediaQuery, AppBar appBar, Container transactionList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Show Chart', style: Theme.of(context).textTheme.bodyText1),
          Switch.adaptive(
              value: _showChart,
              onChanged: (value) {
                setState(() {
                  _showChart = value;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.6,
              child: Chart(_recentTransactions))
          : transactionList
    ];
  }

  List<Widget> _buildPortrateMode(
      MediaQueryData mediaQuery, AppBar appBar, Container transactionList) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      transactionList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Expenses App'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => startNewTransaction(context)),
            ]))
        : AppBar(
            title: const Text('Expenses App'),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => startNewTransaction(context))
            ],
          );
    final transactionList = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(transactions, _removeTransaction));
    final widgetBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandScape)
            ..._buildLandScapeMode(mediaQuery, appBar, transactionList),
          if (!isLandScape)
            ..._buildPortrateMode(mediaQuery, appBar, transactionList),
        ],
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: widgetBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: widgetBody,
            floatingActionButton: Platform.isAndroid
                ? FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => startNewTransaction(context))
                : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
