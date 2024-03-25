import 'dart:convert';

import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
 final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545";
  final String _privateKey =
      "0xb70eaaea76b97751a1f11ff8526e4fd53d690e542eca43e6f4bf8005aef3b58c";

  late Web3Client _client;
  late String _abiCode;
  late EthereumAddress _contractAddress;
  late Credentials _credentials;

  late DeployedContract _contract;
  late ContractFunction _minterAddr;
  late ContractFunction _balanceGet;
  late ContractFunction _mintFunc;
  late ContractFunction _sendFunc;
  late ContractEvent _sentEvent;
  bool isLoading = true;

  late String minterAddress;

  ContractLinking() {
    initialSetUp();
  }

  initialSetUp() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/contracts/SmartParking.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    // print(_abiCode);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  void getCredentials() {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "SmartParking"), _contractAddress);
    _minterAddr = _contract.function("minter");
    _balanceGet = _contract.function("balance");
    _mintFunc = _contract.function("mint");
    _sendFunc = _contract.function("send");
    _sentEvent = _contract.event("Sent");
    getMinterAddr();
  }

  getMinterAddr() async {
    final _minterAddress = await _client
        .call(contract: _contract, function: _minterAddr, params: []);
    minterAddress = "${_minterAddress.first}";
     print("User Addresss is $minterAddress");
    isLoading = false;
    notifyListeners();
  }

  getBalance(String addr) async {
    final _balance = await _client.call(
        contract: _contract,
        function: _balanceGet,
        params: [EthereumAddress.fromHex(addr)]);
    print("$_balance");
    isLoading = false;
    notifyListeners();
    return "${_balance.first}";
  }

  mintCoins(String receiver, int amount) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _mintFunc,
        parameters: [EthereumAddress.fromHex(receiver), BigInt.from(amount)],
         maxGas: 1000000),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);
    
     print("Coins $amount minted to $receiver");
    getMinterAddr();
  }

  sendCoins(String sender, String receiver, int amount) async {
    isLoading = true;
    notifyListeners();

    // listen for the Sent event when it's emitted by the contract above
    final subscription = _client
        .events(FilterOptions.events(contract: _contract, event: _sentEvent))
        .take(1)
        .listen((event) {
      final decoded = _sentEvent.decodeResults(event.topics!, event.data!);

      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as BigInt;

     print('$from sent $value Coins to $to');
    });

    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _sendFunc,
            parameters: [
              EthereumAddress.fromHex(sender),
              EthereumAddress.fromHex(receiver),
              BigInt.from(amount),
            ],
               maxGas: 1000000),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    print("Coins Transferred Successfully");
    getMinterAddr();

    await subscription.asFuture();
    await subscription.cancel();
  }
}
