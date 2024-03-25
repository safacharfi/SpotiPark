import 'package:flutter/material.dart';
import '/User/widgets/Recommendation.dart';
import '/User/widgets/hotels.dart';
import 'Authentification/UserLinking.dart';
import 'Authentification/User.dart';
import 'package:provider/provider.dart';
import '/User/Authentification/Profile.dart';
import '/User/balance/balance.dart';
import '/User/booking/Home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late UserController contactController;
  late List<User> users;
  late Size size;
  late bool showBalance = false;
  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    size = MediaQuery.of(context).size;

    contactController = Provider.of<UserController>(context, listen: true);
    users = contactController.users;
    var safearea = MediaQuery.of(context).padding.top;
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 245, 252),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: safearea,
            ),
            SizedBox(
              height: 60,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Welcome ${users.isNotEmpty ? users[0].name : ""}',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(3, 100, 176, 65),
                      ),
                    ),
                  ),
                
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: Color.fromRGBO(3, 100, 176, 65),
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Do you want to find Parkings?",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w100,
                  color: Color.fromARGB(143, 0, 0, 0),
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(213, 225, 243, 50),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search parkings...",
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Color.fromARGB(143, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(3, 100, 176, 65),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Popular parkings",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(143, 0, 0, 0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      "view all",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                        color: Color.fromARGB(143, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/archipel');
                      },
                      child: const Hotels(
                        title: "Central Parking",
                        image: "assets/parking4.jpg",
                        location: "Sousse ",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/finika');
                      },
                      child: const Hotels(
                        title: "Downtown Garage",
                        image: "assets/parking3.jpg",
                        location: "Tunisia",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/archipel');
                      },
                      child: const Hotels(
                        title: "Urban Park & Go",
                        image: "assets/parking.jpg",
                        location: "Sfax",
                      ),
                    ),
                  ],
                ),
              ),
            ),
        
            
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
   bottomNavigationBar: BottomNavigationBar(
  showSelectedLabels: false,
  showUnselectedLabels: false,
  currentIndex: _currentIndex,
  onTap: (int index) {
    setState(() {
      _currentIndex = index;
      switch (_currentIndex) {
        case 0:
          Navigator.pushReplacementNamed(context, '/');
          break;
        case 1:
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) =>  Home(),
  ),
);          break;
        case 2:
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const balance(),
  ),
);
          break;
        case 3:
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const MyHomePage(title: 'profile'),
  ),
);
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
      icon: Icon(Icons.book_online_rounded, color: Colors.black38, size: 25), // Custom icon for booking
      label: "Booking",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_balance_wallet_rounded, color: Colors.black38, size: 30), // Custom icon for balance
      label: "Balance",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline_rounded, color: Colors.black38, size: 30), // Custom icon for profile
      label: "Profile",
    ),
  ],
  type: BottomNavigationBarType.fixed,
  selectedItemColor: const Color.fromRGBO(3, 100, 176, 65),
));


  }
}
