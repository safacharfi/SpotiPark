import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'User.dart';
import 'UserLinking.dart';
import 'editprofile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _status = true;
  late UserController contactController;
  late List<User> users;
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    contactController = Provider.of<UserController>(context, listen: true);
    users = contactController.users;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(3, 100, 176, 65),
                ],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: _height / 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/user.jpg'),
                            radius: _height / 5,
                          ),
                          SizedBox(height: _height / 30),
                          Text(
                            'Welcome ${users.isNotEmpty ? users[users.length-1].name : ""}',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: _height / 2.2,
                    ),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: _height / 2.6,
                      left: _width / 20,
                      right: _width / 20,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 2.0,
                                offset: Offset(0.0, 2.0),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: _height / 20),
                          child: Column(
                            children: <Widget>[
                              infoChild(
                                _width,
                                Icons.person,
                                'Name: ${users.isNotEmpty ? users[0].name : ""}',
                              ),
                              infoChild(
                                _width,
                                Icons.phone,
                                'Phone Number: ${users.isNotEmpty ? users[0].phone : ""}',
                              ),
                              infoChild(_width, Icons.directions_car, 'Show all Vehicles'),
                              Padding(
                                padding: EdgeInsets.only(top: _height / 30),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserEditScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: _width / 3,
                                    height: _height / 20,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(3, 100, 176, 65),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(_height / 40),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black87,
                                          blurRadius: 2.0,
                                          offset: Offset(0.0, 1.0),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 3, // Index of the current page in the bottom navigation bar
        onTap: (int index) {
          // Handle navigation when a bottom navigation item is tapped
          setState(() {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/booking');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/balance');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/profile');
                break;
            }
          });
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


Widget _buildInfoField(String label, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF201658), // Changer la couleur du texte
                ),
              ),
            ],
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: TextFormField(
              initialValue: value,
              enabled: !_status,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: value,
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(
                  icon,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  

  Widget headerChild(String header, int value) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(header),
          new SizedBox(
            height: 8.0,
          ),
          new Text(
            '$value',
            style: new TextStyle(
                fontSize: 14.0,
                color: const Color.fromRGBO(3, 100, 176, 65),
                fontWeight: FontWeight.bold),
          )
        ],
      ));

  Widget infoChild(double width, IconData icon, data) => new Padding(
        padding: new EdgeInsets.only(bottom: 8.0),
        child: new InkWell(
          child: new Row(
            children: <Widget>[
              new SizedBox(
                width: width / 10,
              ),
              new Icon(
                icon,
                color:const Color.fromRGBO(3, 100, 176, 65),
                size: 36.0,
              ),
              new SizedBox(
                width: width / 20,
              ),
              new Text(data)
            ],
          ),
          onTap: () {
            print('Info Object selected');
          },
        ),
      );
      

      
}
