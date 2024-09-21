import 'dart:io';
import 'package:flutter/material.dart';

import 'components/body.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          exit(0);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: kItextColor,
          body: Body(),
        ),
      ),
    );
  }
}
