import '../Widgets/adaptive_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class NewTransaction extends StatefulWidget {
  final Function transaction;

  NewTransaction(this.transaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final title=TextEditingController();
  final amount=TextEditingController();
  DateTime selectedDate;
  void getDataFromUser(){
    if(title.text.isEmpty||amount.text.isEmpty||selectedDate==null){
      return;
    }
    final checkAmount=double.parse(amount.text);
    if(checkAmount<=0){
      return;
    }
    widget.transaction(title.text,checkAmount,selectedDate);
    Navigator.of(context).pop();
  }

  void _showPickedDateDialog(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate:DateTime(DateTime.now().year) ,
      lastDate: DateTime.now()
    ).then(
      (pickedDate){
        setState(() {
          selectedDate=pickedDate;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
              elevation: 10,
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom+10
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: title,
                      onSubmitted:(_)=>getDataFromUser(),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "Amount"),
                      controller: amount,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onSubmitted:(_)=>getDataFromUser(),
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        Container(width:(MediaQuery.of(context).size.width-20)*0.4 ,child: FittedBox(child: Text(selectedDate==null?'No date chosen!':'Picked date: ${DateFormat.yMd().format(selectedDate)}'))),
                        Container(width:(MediaQuery.of(context).size.width-10)*0.4,child: FittedBox(child: AdaptiveFlatButton('Choose date', _showPickedDateDialog)))
                      ],)
                    ),
                    RaisedButton(
                      onPressed: getDataFromUser, 
                      child: const Text('Add Transaction'),
                      color: Theme.of(context).accentColor ,
                      textColor: Theme.of(context).textTheme.button.color,
                    ),
                  ],
                ),
              )
            ),
    );
  }

}