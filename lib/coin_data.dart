import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(selectedCurrency) async {
    Map<String, String> coinprices = {};
    for (String crypto in cryptoList) {
      http.Response coinrate = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=92A5D8A4-32D2-4FC7-B064-BDBFCD98B838'));
      if (coinrate.statusCode == 200) {
        String data = coinrate.body;
        var lastPrice = jsonDecode(data)['rate'];
        coinprices[crypto] = lastPrice
            .toStringAsFixed(0); // for specifying no. of fraction digits
      } else {
        print(coinrate.statusCode);
      }
    }
  }
}
// BELOW IS THE WORKING CORRECTED CODE
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// const List<String> currenciesList = [
//   'AUD',
//   'BRL',
//   'CAD',
//   'CNY',
//   'EUR',
//   'GBP',
//   'HKD',
//   'IDR',
//   'ILS',
//   'INR',
//   'JPY',
//   'MXN',
//   'NOK',
//   'NZD',
//   'PLN',
//   'RON',
//   'RUB',
//   'SEK',
//   'SGD',
//   'USD',
//   'ZAR'
// ];
//
// const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];
//
// const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
// const apiKey = '92A5D8A4-32D2-4FC7-B064-BDBFCD98B838';
//
// class CoinData {
//   Future getCoinData(String selectedCurrency) async {
//     Map<String, String> cryptoPrices = {};
//     for (String crypto in cryptoList) {
//       String requestURL =
//           '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
//       http.Response response = await http.get(Uri.parse(requestURL));
//       if (response.statusCode == 200) {
//         var decodedData = jsonDecode(response.body);
//         double price = decodedData['rate'];
//         cryptoPrices[crypto] = price.toStringAsFixed(0);
//       } else {
//         print(response.statusCode);
//         throw 'Problem with the get request';
//       }
//     }
//     return cryptoPrices;
//   }
// }
