import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'User.dart';
import 'UserLinking.dart';
import 'Profile.dart';

class UserEditScreen extends StatefulWidget {
  final User? user;

  UserEditScreen({Key? key, this.user}) : super(key: key);

  @override
  _UserEditScreenState createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  late UserController contactsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.name ?? '');
    _passwordController =
        TextEditingController(text: widget.user?.password ?? '');
    _phoneController = TextEditingController(text: widget.user?.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> handleSaveNote() async {
    if (widget.user == null) {
      await contactsController.addUser(
        User(
          '0',
          name: _nameController.text,
          password: _passwordController.text,
          phone: _phoneController.text,
        ),
      );
    } else {
      await contactsController.editUser(
        User(
          widget.user!.id,
          name: _nameController.text,
          password: _passwordController.text,
          phone: _phoneController.text,
        ),
      );
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => MyHomePage(title: 'Profile Page')),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    contactsController = Provider.of<UserController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: handleSaveNote,
                      child: Text('Save'),
                    ),
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MyHomePage(title: 'Profile Page')),
                          (route) => false,
                        );
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
}
