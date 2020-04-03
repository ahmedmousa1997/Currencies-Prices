import 'package:flutter/material.dart';
import 'CryptoCurrency/price_screen.dart';
import 'Dollar_Euro_Prices/show_currency.dart';


class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0a0d12),
      appBar: AppBar(
        backgroundColor: Color(0xFF0f161e),
        centerTitle: true,
        title: Text(
          'Select Item',
        ),
      ),
      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SelectACard(
              text: 'Crypto Currencies Prices',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PriceScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            SelectACard(
              text: 'Dollar Price',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowCurrency(),
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}

class SelectACard extends StatelessWidget {
  SelectACard({@required this.text, @required this.onPress});
  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Card(
        color: Color(0xFF192636),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
