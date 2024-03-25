import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'User.dart';
import 'UserLinking.dart';
import 'Signin.dart'; // Importez la page de connexion
import 'package:animate_do/animate_do.dart';
class SignUpPage extends StatefulWidget {
  User? user;
  SignUpPage({this.user, Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  late UserController contactsController; // Ajoutez cette ligne

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.name ?? '');
    _passwordController = TextEditingController(text: widget.user?.password ?? '');
    _phoneController = TextEditingController(text: widget.user?.phone ?? '');

    // Initialisez contactsController ici
    contactsController = UserController(); // Remplacez par l'initialisation réelle
  }


  handleCreateNote() async {
    User user = User(
      '0',
      name: _nameController.text,
      password: _passwordController.text,
      phone: _phoneController.text,
    );
    await contactsController.addUser(user);
    // Une fois l'inscription terminée, naviguez vers la page de connexion
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

 @override
  Widget build(BuildContext context) {
    UserController contactsController = Provider.of<UserController>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
 Color.fromRGBO(3, 100, 176, 65),
  Color(0xFF98ABEE), // #98ABEE
  Color(0xFFF9E8C9), // #F9E8C9
],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Create your account", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
              ),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60,),
                    FadeInUp(duration: Duration(milliseconds: 1400), child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                              color:    Color(0xFF98ABEE), // #98ABEE
 // #1D24CA
// #201658
 // #5969FF (Bleu principal)
// #5969FF (Bleu principal)

                              blurRadius: 20,
                              offset: Offset(0, 10)
                          )]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                            ),
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  hintText: "Name",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                            ),
                            child: TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                  hintText: "Phone",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(height: 40,),
                    FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Forgot Password?", style: TextStyle(color: Colors.grey),)),
                    SizedBox(height: 40,),
                    FadeInUp(duration: Duration(milliseconds: 1600), child: MaterialButton(
                      onPressed: () async {
                        if (widget.user == null) {
                          handleCreateNote();
                        } else {
                          print("hehiii");
                        }
                      },
                      height: 30,
                      minWidth: 100,
                      color:     const Color.fromRGBO(3, 100, 176, 65),
 // #1D24CA
// #201658
// #5969FF (Bleu principal)
// #137C8B

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
