import 'dart:convert';
import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

import 'User.dart';

class UserController extends ChangeNotifier {
  List<User> users = [];
  bool isLoading = true;
  late int count;
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545";
  final String _privateKey =
      "0xb70eaaea76b97751a1f11ff8526e4fd53d690e542eca43e6f4bf8005aef3b58c";

  late Web3Client _client;
  late String _abiCode;
  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late DeployedContract _contract;
  // Define functions
  late ContractFunction _count;
  late ContractFunction _users;
  late ContractFunction _addUser;
  late ContractFunction _deleteUser;
  late ContractFunction _editUser;
  late ContractEvent _UserAddedEvent;
  late ContractEvent _UserDeletedEvent;
  late ContractFunction _signIn;

  UserController() {
    init();
  }

  Future<void> init() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/contracts/SmartParking.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "SmartParking"), _contractAddress);
    _count = _contract.function("UserCount");
    _users = _contract.function("users");
    _addUser = _contract.function("addUser"); // Fixed function name
 _deleteUser = _contract.function("deleteUser");
    _editUser = _contract.function("editUser");

    _UserAddedEvent = _contract.event("UserAdded");
    _UserDeletedEvent = _contract.event("UserDeleted");
    await getUsers();  
    _signIn=_contract.function("signin");
  }

  Future<void> getUsers() async {
    List contactList =
        await _client.call(contract: _contract, function: _count, params: []);
    BigInt totalContacts = contactList[0];
    count = totalContacts.toInt();
    debugPrint("count $count");
    users.clear();
    for (int i = 0; i < count; i++) {
      var temp = await _client.call(
          contract: _contract, function: _users, params: [BigInt.from(i)]);
      if (temp[1] != "") {
        users.add(
          User(
            temp[0].toString(),
            name: temp[1],
            password: temp[2],
            phone: temp[3],
          ),
        );
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addUser(User user) async {
    debugPrint(
        "creating new User: name- ${user.name}");
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _addUser,
            parameters: [user.name, user.password, user.phone],
            maxGas: 1000000),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    await getUsers();
  }

  Future<void> deleteUser(int id) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _deleteUser,
            parameters: [BigInt.from(id)],
            maxGas: 1000000),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    await getUsers();
  }

  Future<void> editUser(User user) async {
    isLoading = true;
    notifyListeners();
    print(BigInt.from(int.parse(user.id)));
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _editUser,
            parameters: [
              BigInt.from(int.parse(user.id)),
              user.name,
              user.password,
              user.phone
            ],
            maxGas: 1000000),
        chainId: 1337,
        fetchChainIdFromNetworkId: false);

    ;
    await getUsers();
  }
Future<bool> signIn(String name, String password) async {
  isLoading = true;
  notifyListeners();
  
  var result = await _client.call(
    contract: _contract,
    function: _signIn,
    params: [name, password],
  );
  
  bool isAuthenticated = result[0];
  isLoading = false;
  notifyListeners();
  
  return isAuthenticated;
}

}