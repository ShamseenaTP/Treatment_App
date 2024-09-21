import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treatmentapp/api/api_service.dart';
import 'package:treatmentapp/models/loginModel/login_model.dart';
import 'package:treatmentapp/sharedPreference/shared_serviece.dart';

import '../../../constants/colors.dart';
import '../../../constants/progress_indicator.dart';

class Body extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<Body> {
  bool passwordVisible = true;
  late UserDetails userDetails;
  bool isApiCallProcess = false;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  int initial = 0;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    userDetails = UserDetails();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(
      inAsyncCall: isApiCallProcess,
      child: _uiSetup(context),
    );
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                Container(
                  height: 180,
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
                    height: 80,
                    width: 84,
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Login Or Register To Book Your Appointments',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('User Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                        fontFamily: 'Poppins',
                      )),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 79.98,
                    child: TextFormField(
                     controller: _userNameController,
                      validator: (input) => input!.isEmpty
                          ? 'Please enter user name'
                          : null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.1))),
                        hintText: 'Enter Username',
                        prefixIcon: const Icon(Icons.person),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                        fontFamily: 'Poppins',
                      )),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 79.98,
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (input) => input!.length < 6
                          ? 'Password should be more than 3 characters'
                          : null,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.1))),
                        hintText: 'Enter Your Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(
                              () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),

                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        alignLabelWithHint: false,
                        // filled: true,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (validateAndSave()) {
                    setState(() {
                      isApiCallProcess = true;
                      });
                   
                    APIService apiService = APIService();
                    apiService.login(_userNameController.text, _passwordController.text, context).then((value) {
                     
                      setState(() {
                        isApiCallProcess = false;
                        });
                      if (value.token!.isNotEmpty) {
                        final snackBar =
                            SnackBar(content: Text('Login Successful'));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar); 

                            SharedService.setLoginDetails(value);Navigator.pushReplacementNamed(context, '/dashboard');
                            
                      } else {
                        final snackBar =
                            SnackBar(content: Text(value.message.toString()));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar); 
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(330, 50),
                  backgroundColor: const Color(0xFF006837),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RichText(
                  text: const TextSpan(
                      text:
                          'By creating or logging into an account you are agreeing with our',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                      children: [
                    TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0028FC),
                          fontFamily: 'Poppins',
                        )),
                    TextSpan(
                        text: 'and',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        )),
                    TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0028FC),
                          fontFamily: 'Poppins',
                        ))
                  ])),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      print('==============aaaaaaaaaaaaaaaaaaaaaaa');
      form.save();
      print('==============form.save();');
      return true;
    }
    return false;
  }
}
