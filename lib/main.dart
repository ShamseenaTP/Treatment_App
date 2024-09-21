import 'package:flutter/material.dart';
import 'package:treatmentapp/sharedPreference/shared_serviece.dart';
import 'package:treatmentapp/ui/dashboad/dashboard_page.dart';
import 'package:treatmentapp/ui/loginPage/login_page.dart';
import 'package:treatmentapp/ui/registerPage/register_page.dart';
import 'package:treatmentapp/ui/splashScreen/splash.dart';

Widget _defaultHome = LoginPage();

void main() async {
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dashboard',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/dashboard': (BuildContext context) => const DashboardPage(), 
          '/login': (BuildContext context) =>  LoginPage(), 
          '/register': (BuildContext context) =>  const RegisterPage(),
        },
        );
  }
}
