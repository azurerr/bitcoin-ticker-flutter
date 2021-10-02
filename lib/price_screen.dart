import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'CAD';
  //String coin = 'BTC';
  String price = '?';
  Map<String, String> coinPrices = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrice();
  }

  void getPrice() async {
    CoinData coinData = CoinData();
    //print(price);
    try {
      var priceData = await coinData.getCurrency(currency: selectedCurrency);
      setState(() {
        for (String crypto in cryptoList) {
          coinPrices['$crypto'] =
              priceData['$crypto']['$selectedCurrency'].toStringAsFixed(1);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItems = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItems);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getPrice();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    // for (int i = 0; i < currenciesList.length ; i++ )
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {
        selectedCurrency = currenciesList[value];
        print(selectedCurrency);
        getPrice();
      },
      children: pickerItems,
    );
  }

  Column coinCards() {
    List<Card> cards = [];
    for (String crypto in cryptoList) {
      cards.add(Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = ${coinPrices[crypto]} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cards,
    );
  }

  // Widget getPicker() {
  //   if (Platform.isIOS) {
  //     return iOSPicker();
  //   } else if (Platform.isAndroid) {
  //     return androidDropdown();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: coinCards(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
