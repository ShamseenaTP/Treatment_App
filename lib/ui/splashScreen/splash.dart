import 'dart:ui';

import 'package:flutter/material.dart';

import '../../sharedPreference/shared_serviece.dart';
import '../dashboad/dashboard_page.dart';
import '../loginPage/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool _isLoggedIn = await SharedService.isLoggedIn();
    Widget _defaultHome = LoginPage(); 

    if (_isLoggedIn) {
      _defaultHome = const DashboardPage(); 
    }
    await Future.delayed(const Duration(seconds: 2)); 
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => _defaultHome));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      border: Border(),
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/vertical1.jpg",
                          ),
                          fit: BoxFit.fill)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/icon/Layer_1-2.png",
                    height: 150,
                    width: 140,
                  ),
                ),
              ]),
            ),
    );
  }
}