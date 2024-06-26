import '/User/booking/ContractLinking.dart';
import '/User/booking/StatusList.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tcard/tcard.dart';
import '/User/Authentification/Profile.dart';
import '/User/balance/balance.dart';


List<String> assetsImages = List.filled(20, "assets/park.png");


List catsNames = [
  "A-01",
  "A-02",
  "A-03",
  "A-04",
  "A-05",
  "A-06",
  "A-07",
  "A-08",
  "A-09",
  "A-10",
  "A-11",
  "A-12",
  "A-13",
  "A-14",
  "A-15",
  "A-16",
  "A-17",
  "A-18",
  "A-19",
  "A-20",
];


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TCardController _controller = TCardController();

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Book your Spot now"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(    Icons.list,

),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatusList()));
              })
        ],
      ),
      body: Container(
        child: Center(
          child: contractLink.isLoading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 490,
                        child: TCard(
                          //cards: cards,
                          cards: List.generate(assetsImages.length,
                              (index) => catCard(index, context)),
                          controller: _controller,
                          onForward: (index, info) {
                            _index = index;
                            //print(info.direction);
                            setState(() {});
                          },
                        
                          onEnd: () {
                            print('end');
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                _controller.back();
                              }),
                          IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                _controller.forward();
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            _index == catsNames.length ?   const Color.fromRGBO(3, 100, 176, 65)
 :   const Color.fromRGBO(3, 100, 176, 65)
,
        onPressed: () {
          _controller.reset();
        },
        //child: Text(_index.toString()),
        child: Icon(Icons.refresh),
      ), bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
          currentIndex: 1, // Index of the current page in the bottom navigation bar
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


  Widget catCard(int index, context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Container(
      decoration: BoxDecoration(
        color:   const Color.fromRGBO(3, 100, 176, 65),
        borderRadius: BorderRadius.circular(26.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 23.0,
            spreadRadius: -13.0,
            color: Colors.black54,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Name - ${catsNames[index]}",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Image(image: AssetImage(assetsImages[index])),
          ElevatedButton(
              onPressed: () async {
                var adopter = "${await contractLink.getAdopter(index)}";
                adopter == "0x0000000000000000000000000000000000000000"
                    ? adoptCatDialog(context, index, "${catsNames[index]}")
                    : showToast("It is already booked.", context);
              },
              child: Text("Book"))
        ],
      ),
    );
  }

  adoptCatDialog(context, int index, String catName) {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    TextEditingController accountAddr = TextEditingController();
        TextEditingController duration = TextEditingController();
                TextEditingController startTime = TextEditingController();


    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Adopt $catName",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18.0, bottom: 8.0),
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
                  padding: EdgeInsets.only(top: 18.0, bottom: 8.0),
                  child: TextField(
                    controller: duration,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "duration",
                        hintText: "Enter the duration..."),
                  ),
                ),
                  Padding(
                  padding: EdgeInsets.only(top: 18.0, bottom: 8.0),
                  child: TextField(
                    controller: startTime,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "startTime",
                        hintText: "Enter the StartTime..."),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: ElevatedButton(
                          onPressed: () {
contractLink.adoptFunc(
  index, 
  accountAddr.text, 
  duration.text,
  startTime.text // Access text from duration TextEditingController and parse to int
);
                            showToast("Thanks For Booking $catName.", context);
                            Navigator.pop(context);
                          },
                          child: Text("Book")),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  showToast(String message, BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor:  const Color.fromRGBO(3, 100, 176, 65),

      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      fontSize: 20,
    );
  }
}
