import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io'
    show
        Platform; // THIS PACKAGE IS USED FOR SPECIFIC IOS IN PLATFORM.DART FILE
// SHOW IS USED TO INTEGRATE THAT FILE ONLY FROM PACKAGE IN OUR MAIN FILE

// import 'dart:io' hide Platform; hide is used to integrate all files from the package in the maine file except that file
class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropdownItems =
        []; // dropdownItems is a list which contain DropdownMenuItem widget which will contain strings as their child
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
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

  // List<DropdownMenuItem<String>> getDropDownItem() {
  //   List<DropdownMenuItem<String>> dropdownItems =
  //       []; // dropdownItems is a list which contain DropdownMenuItem widget which will contain strings as their child
  //   for (int i = 0; i < currenciesList.length; i++) {
  //     String currency = currenciesList[i];
  //     var newItem = DropdownMenuItem(
  //       child: Text(currency),
  //       value: currency,
  //     );
  //     dropdownItems.add(newItem);
  //   }
  //   return dropdownItems;
  // USING FOR IN LOOP
  //   // for (String currency in currenciesList) {
  //   //
  //   //   var newItem = DropdownMenuItem(
  //   //     child: Text(currency),
  //   //     value: currency,
  //   //   );
  //   //   dropdownItems.add(newItem);
  //   // }
  //   // return dropdownItems;
  // }
  CupertinoPicker iOSPicker() {
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

  // List<Text> getPickerItems() {
  //   List<Text> pickerItems = [];
  //   for (String currency in currenciesList) {
  //     pickerItems.add(Text(currency));
  //   }
  //   return pickerItems;
  // }
  // Widget? getPicker() {
  //   if (Platform.isAndroid) {
  //     return androidDropDown();
  //   } else if (Platform.isIOS) {
  //     return iOSPicker();
  //   }
  // }

  Map<String, String> coinValues = {};
  bool isWaiting = false;
  void getData() async {
    isWaiting = true;
    try {
      CoinData coindata = CoinData();
      var ValueInFiat = await coindata.getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = ValueInFiat;
      });
    } catch (e) {
      print(e);
    }
  }

  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoValueInFiat: isWaiting ? '?' : coinValues[crypto],
          selectedCurrency: selectedCurrency,
          cryptoCurrency: crypto,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
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
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          makeCards(),
          // [
          //   CryptoCard(
          //       cryptoValueInFiat: isWaiting ? '?' : coinValues['BTC'],
          //       selectedCurrency: selectedCurrency,
          //       cryptoCurrency: 'BTC'),
          //   CryptoCard(
          //       cryptoValueInFiat: isWaiting ? '?' : coinValues['ETH'],
          //       selectedCurrency: selectedCurrency,
          //       cryptoCurrency: 'ETH'),
          //   CryptoCard(
          //       cryptoValueInFiat: isWaiting ? '?' : coinValues['LTH'],
          //       selectedCurrency: selectedCurrency,
          //       cryptoCurrency: 'LTC'),
          // ],

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard(
      {required this.cryptoValueInFiat,
      required this.selectedCurrency,
      required this.cryptoCurrency});

  final String? cryptoValueInFiat;
  final String? selectedCurrency;
  final String? cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $cryptoValueInFiat $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
// BELOW IS THE WORKING CORRECTED CODE
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'coin_data.dart';
// import 'dart:io' show Platform;
//
// class PriceScreen extends StatefulWidget {
//   @override
//   _PriceScreenState createState() => _PriceScreenState();
// }
//
// class _PriceScreenState extends State<PriceScreen> {
//   String? selectedCurrency = 'AUD';
//
//   DropdownButton<String> androidDropdown() {
//     List<DropdownMenuItem<String>> dropdownItems = [];
//     for (String currency in currenciesList) {
//       var newItem = DropdownMenuItem(
//         child: Text(currency),
//         value: currency,
//       );
//       dropdownItems.add(newItem);
//     }
//
//     return DropdownButton<String>(
//       value: selectedCurrency,
//       items: dropdownItems,
//       onChanged: (value) {
//         setState(() {
//           selectedCurrency = value;
//           getData();
//         });
//       },
//     );
//   }
//
//   CupertinoPicker iOSPicker() {
//     List<Text> pickerItems = [];
//     for (String currency in currenciesList) {
//       pickerItems.add(Text(currency));
//     }
//
//     return CupertinoPicker(
//       backgroundColor: Colors.lightBlue,
//       itemExtent: 32.0,
//       onSelectedItemChanged: (selectedIndex) {
//         setState(() {
//           selectedCurrency = currenciesList[selectedIndex];
//           getData();
//         });
//       },
//       children: pickerItems,
//     );
//   }
//
//   Map<String, String> coinValues = {};
//   bool isWaiting = false;
//
//   void getData() async {
//     isWaiting = true;
//     try {
//       var data = await CoinData().getCoinData(selectedCurrency!);
//       isWaiting = false;
//       setState(() {
//         coinValues = data;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Column makeCards() {
//     List<CryptoCard> cryptoCards = [];
//     for (String crypto in cryptoList) {
//       cryptoCards.add(
//         CryptoCard(
//           cryptoCurrency: crypto,
//           selectedCurrency: selectedCurrency,
//           value: isWaiting ? '?' : coinValues[crypto],
//         ),
//       );
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: cryptoCards,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('🤑 Coin Ticker'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           makeCards(),
//           Container(
//             height: 150.0,
//             alignment: Alignment.center,
//             padding: EdgeInsets.only(bottom: 30.0),
//             color: Colors.lightBlue,
//             child: Platform.isIOS ? iOSPicker() : androidDropdown(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CryptoCard extends StatelessWidget {
//   const CryptoCard({
//     this.value,
//     this.selectedCurrency,
//     this.cryptoCurrency,
//   });
//
//   final String? value;
//   final String? selectedCurrency;
//   final String? cryptoCurrency;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//       child: Card(
//         color: Colors.lightBlueAccent,
//         elevation: 5.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//           child: Text(
//             '1 $cryptoCurrency = $value $selectedCurrency',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 20.0,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
