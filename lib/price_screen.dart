import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropdownValue = currenciesList[0];
  String btcValue = '?';
  String ethValue = '?';
  String ltcValue = '?';

  void getData() async {
    try {
      double btcData = await CoinData().getCoinData("BTC", dropdownValue);
      double ethData = await CoinData().getCoinData("ETH", dropdownValue);
      double ltcData = await CoinData().getCoinData("LTC", dropdownValue);
      setState(() {
        btcValue = btcData.toStringAsFixed(0);
        ethValue = ethData.toStringAsFixed(0);
        ltcValue = ltcData.toStringAsFixed(0);
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CoinToCurrencyContainer(
                  coinName: 'BTC',
                  coinValue: btcValue,
                  dropdownValue: dropdownValue),
              CoinToCurrencyContainer(
                  coinName: 'ETH',
                  coinValue: ethValue,
                  dropdownValue: dropdownValue),
              CoinToCurrencyContainer(
                  coinName: 'LTC',
                  coinValue: ltcValue,
                  dropdownValue: dropdownValue),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              items: currenciesList.map((e) {
                return DropdownMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList(),
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value;
                });
                getData();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CoinToCurrencyContainer extends StatelessWidget {
  const CoinToCurrencyContainer({
    Key key,
    @required this.coinName,
    @required this.coinValue,
    @required this.dropdownValue,
  }) : super(key: key);

  final String coinName;
  final String coinValue;
  final String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coinName = $coinValue $dropdownValue',
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
