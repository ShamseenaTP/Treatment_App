import 'package:flutter/material.dart';
import 'package:treatmentapp/ui/registerPage/component/body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
     resizeToAvoidBottomInset: false,
          body: Body(),);
  }
}