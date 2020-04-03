import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dollar_Euro_Prices/currency_data.dart';

class ShowCurrency extends StatefulWidget {
  @override
  _ShowCurrencyState createState() => _ShowCurrencyState();
}

class _ShowCurrencyState extends State<ShowCurrency> {
  String selectedCurrency = 'EUR';
  DollarData dollarData = DollarData();

  final TextEditingController userRecievedInput = new TextEditingController();
  double result = 0.0;

  String currencyPrice = 'getting..';

  Future getData() async {
    var data = await dollarData.getData(selectedCurrency);
    try {
      setState(() {
        double price = data['quotes']['USD$selectedCurrency'];
        currencyPrice = price.toStringAsFixed(2);
      });
    } catch (e) {
      print(e);
      setState(() {
        currencyPrice = 'getting..';
      });
    }
  }

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
          result=0.0;
         // userRecievedInput.text='';
          userRecievedInput.clear();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0a0d12),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh,color: Colors.white,),
            onPressed: (){
              getData();
            },
          )
        ],
        centerTitle: true,
        backgroundColor: Color(0xFF0f161e),
        title: Text('Dollar Price'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                color: Color(0xFF192636),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                  child: Text(
                    '1 Dollar = $currencyPrice $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              color: Color(0xFF192636),
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                autofocus: false,
                                controller: userRecievedInput,
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 20.0),
                                decoration: InputDecoration(
                                  hintText: 'amount',
                                  hintStyle: TextStyle(
                                    color: Colors.lightBlue,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide.none

                                  )
                                ),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Text(
                              'USD',
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.white),
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Text(
                              '-->',
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.white),
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Text(
                              '$selectedCurrency',
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.white),
                            ),
                          ),

//                   Container(
//                     margin: EdgeInsets.all(20.0),
//                     color: Colors.lightBlue,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text('Eur',
//                         style: TextStyle(fontSize: 20.0,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
                        ],
                      ),
                    ),
                    Text('${result.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 17),),
                    RaisedButton(
                      child: Text('Convert'),
                      onPressed: (){
                     try{
                        setState(() {
                          double w = double.parse(currencyPrice);
                          double ww = double.parse(userRecievedInput.text);
                          result = w*ww;
                          print(w);
                          print(ww);

                          print(result.toStringAsFixed(2));
                        });

                     }catch(e){
                       print('enter amount');
                     }
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 120.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Color(0xFF192636),
              child:
                  Platform.isIOS ? iOSCupertinoPicker() : androidDropdownButton(),
            ),
          ],
        ),
      ),
    );
  }
}
