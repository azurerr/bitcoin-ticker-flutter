import 'networking.dart';

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

const coinUrl = 'https://min-api.cryptocompare.com/data/pricemulti';
const apiKey =
    'f4d692b72830ade9d398a27c34c8501adce7835e9f6bba6418080ca1f8f61254';

//https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR

class CoinData {
  Future<dynamic> getCurrency({String coin, String currency}) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$coinUrl?fsyms=${cryptoList[0]},${cryptoList[1]},${cryptoList[2]}&tsyms=$currency&api_key=$apiKey');
    var data = await networkHelper.getData();
    print(data);
    return data;
  }
}
