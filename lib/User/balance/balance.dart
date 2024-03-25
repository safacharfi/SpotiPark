import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/User/balance/BalanceLinking.dart';
import 'package:provider/provider.dart';
import '/User/booking/Home.dart';
import '/User/Authentification/Profile.dart';

class balance extends StatelessWidget {
  const balance({Key? key}) : super(key: key);

  showToast(String message, BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      fontSize: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: contractLink.isLoading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 300,
                        height: 350,
                        child: Image(
                          image: AssetImage("assets/6.gif"),
                        ),
                      ),
                    
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
 // #201658
), // Change the primary color here
                            icon: const Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                            ),
                            label: const Text("Check Balance"),
                            onPressed: () {
                              balanceDialog(context);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
), // Change the primary color here
                            icon: const Icon(
                              Icons.money,
                              color: Colors.black,
                            ),
                            label: const Text("Add Money to Card"),
                            onPressed: () {
                              mintCoinDialog(context);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: 350,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
), // Change the primary color here
                            icon: const Icon(
                              Icons.offline_share,
                              color: Colors.black,
                            ),
                            label: const Text("Send Money"),
                            onPressed: () {
                              sendCoinDialog(context);
                                                     },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
          bottomNavigationBar: BottomNavigationBar(
               currentIndex: 2, // Index of the current page in the bottom navigation bar
        onTap: (int index) {
          // Handle navigation when a bottom navigation item is tapped
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) =>  Home(),
  ),
);                break;
            case 2:
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const balance(),
  ),
);              break;
            case 3:
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const MyHomePage(title: 'profile'),
  ),
);              break;
          }
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book_online_rounded,
              color: Colors.black38,
              size: 25,
            ),
            label: "Booking",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.black38,
              size: 30,
            ),
            label: "Balance",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_rounded,
              color: Colors.black38,
              size: 30,
            ),
            label: "Profile",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromRGBO(3, 100, 176, 65),
      ),
    );
  }

  balanceDialog(context) {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    TextEditingController accountAddr = TextEditingController();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Check Balance",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: accountAddr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Account Address",
                        hintText: "Enter Your Account Address..."),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            String balance =
                                await contractLink.getBalance(accountAddr.text);
                            print(balance);
                            showToast(
                                "${accountAddr.text.substring(0, 5)}XXXX has $balance Coins.",
                                context);
                            //Navigator.pop(context);
                          },
                          child: const Text("Balance")),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  mintCoinDialog(context) {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    TextEditingController accountAddr = TextEditingController();
    TextEditingController coinsAmount = TextEditingController();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add Money to Card",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
                  child: TextField(
                    controller: accountAddr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Account Address",
                        hintText: "Enter Account Address..."),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: coinsAmount,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Coins Amount",
                        hintText: "Enter Coins Amount To Mint..."),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            contractLink.mintCoins(
                                accountAddr.text, int.parse(coinsAmount.text));
                            showToast(
                                "Coins ${coinsAmount.text} minted to ${accountAddr.text.substring(0, 5)}XXXX",
                                context);
                            Navigator.pop(context);
                          },
                          child: const Text("Mint")),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  sendCoinDialog(context) {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    TextEditingController senderAddr = TextEditingController();
    TextEditingController receiverAddr = TextEditingController();
    TextEditingController coinsAmount = TextEditingController();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            scrollable: true,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Send Coins",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
                  child: TextField(
                    controller: senderAddr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Sender Account Addr...",
                        hintText: "Enter Sender Account Address..."),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: receiverAddr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Receiver Account Addr...",
                        hintText: "Enter Receiver Account Address..."),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: coinsAmount,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Coins To Transfer",
                        hintText: "Enter Coins Amount To Send..."),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            contractLink.sendCoins(senderAddr.text,
                                receiverAddr.text, int.parse(coinsAmount.text));
                            showToast(
                                "Transferred ${coinsAmount.text} from ${senderAddr.text.substring(0, 5)}XXXX to ${receiverAddr.text.substring(0, 5)}XXXX",
                                context);
                            Navigator.pop(context);
                          },
                          child: const Text("Send")),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
