import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import '../CryptoCurrency/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSCupertinoPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  Map<String, String> coinValues = {};
  bool waiting = false;

  void getData() async {
    waiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      waiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  ImageProvider setImageIcon(){
    List<CryptoCard> cryptoCards = [];
    for(String image in currencyIconImage){
      cryptoCards.add(
          CryptoCard(
            iconImage:  AssetImage(
                image
            ),
          )
      );
    }
  }

  Column makeCryptoCards() {
    List<CryptoCard> cryptoCards = [];
//
//    for (String crypto in cryptoList ) {
//
//      cryptoCards.add(
//        CryptoCard(
//          cryptoCurrency: crypto,
//          selectedCurrency: selectedCurrency,
//          value: waiting ? 'getting.. ' : coinValues[crypto],
//          iconImage: setImageIcon(),
//
//
//        ),
//      );
//    }

    for(int i =0 ; i<cryptoList.length && i< currencyIconImage.length;i++){
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: cryptoList[i],
          selectedCurrency: selectedCurrency,
          value: waiting ? 'getting.. ' : coinValues[cryptoList[i]],
          iconImage: AssetImage(
              '${currencyIconImage[i]}'
          ),


        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0a0d12),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh,
            color: Colors.white ,),
          onPressed: (){
            getData();
          },)
        ],
        centerTitle: true,
        backgroundColor: Color(0xFF0f161e),
        title: Text('🤑 Coin Ticker',textAlign: TextAlign.center,),

      ),
      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            makeCryptoCards(),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Color(0xFF192636),
              child: Platform.isIOS ? iOSCupertinoPicker() : androidDropdownButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
    this.iconImage,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;
  final ImageProvider iconImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Color(0xFF192636),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: iconImage,
                height: 30,
                width: 30,
              ),
              Text(
                '1 $cryptoCurrency = $value $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}