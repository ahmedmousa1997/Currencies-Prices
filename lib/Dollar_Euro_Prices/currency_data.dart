import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'BHD',
  'CAD',
  'DZD',
  'EUR',
  'EGP',
  'GBP',
  'INR',
  'IDR',
  'JOD',
  'JPY',
  'KWD',
  'KRW',
  'LBP',
  'MAD',
  'OMR',
  'PLN',
  'QAR',
  'RUB',
  'SAR',
  'SYP',
  'SDG',
  'TND',
  'XOF',

];

const key = 'c292d228ccc7b1c0ac6a5a7bfb094867';
const KApi = 'http://api.currencylayer.com/live';

class DollarData{
  
 Future getData(selectedCurrency) async {
    http.Response response = await http.get('$KApi?access_key=$key&currencies=$selectedCurrency&format=1');

    if(response.statusCode == 200){
      var decodedData = jsonDecode(response.body);
      return decodedData;
    }else{
      return print('error ${response.statusCode}');
    }
  }
  
}