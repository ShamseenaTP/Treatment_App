import 'package:flutter/material.dart';
import 'package:treatmentapp/ui/dashboad/components/body.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
     resizeToAvoidBottomInset: false,
          body: Body(),);
  }
}