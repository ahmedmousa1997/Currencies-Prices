import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'EUR',
  'GBP',
  'IDR',
  'JPY',
  'PLN',
  'RUB',
  'USD',
];

 List<String> currencyIconImage = [

       'images/b.png',
       'images/e.png',
       'images/l.png',

];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'YOUR-API-KEY-HERE';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          'https://api.cryptonator.com/api/ticker/$crypto-$selectedCurrency';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        String cryptoPrice = decodedData['ticker']['price'];
        double price = double.parse(cryptoPrice);
        cryptoPrices[crypto] = price.toStringAsFixed(2);
      } else {
        print(response.statusCode);

        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}