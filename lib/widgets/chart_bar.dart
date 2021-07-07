import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String title;
  final double amount,spendingPercentageOfTotal;
  const ChartBar(this.title,this.amount,this.spendingPercentageOfTotal);
  @override
  Widget build(BuildContext context) {
    print(spendingPercentageOfTotal);
    return LayoutBuilder(builder: (context,container){
      return Column(
        children: <Widget>[
          Container(height: container.maxHeight*0.15,child: FittedBox(child: Text('${amount.toStringAsFixed(0)}\$',style: TextStyle(color: Theme.of(context).primaryColor),))),
          SizedBox(height: container.maxHeight*0.05,),
          Container(
            height: container.maxHeight*0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentageOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: container.maxHeight*0.05,),
          Container(height: container.maxHeight*0.15,child: FittedBox(child: Text(title,style: TextStyle(color: Theme.of(context).primaryColor)))),
        ],
    );
    },
    ); 

  }
}