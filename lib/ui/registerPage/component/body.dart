import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:treatmentapp/api/api_service.dart';
import 'package:treatmentapp/models/patientModel/patient_model.dart';
import 'package:http/http.dart' as http;
import '../../../constants/colors.dart';
import '../../../constants/progress_indicator.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

enum CashMethod { cash, card, upi }

class _BodyState extends State<Body> {
  TextEditingController nameController = TextEditingController();
  TextEditingController wtspController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController treatmentDateController = TextEditingController();
  TextEditingController treatmentTimeController = TextEditingController();

  String selectedLocation = 'Kozhikode';
  String selectedBranch = 'Koyilandi';

  CashMethod? _cashMethod = CashMethod.cash;

  late APIService apiService;
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    apiService = APIService();
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            )),
                      ),
                      const Expanded(flex: 8, child: SizedBox()),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_active,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Register',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w600))),
                  const SizedBox(
                    height: 10,
                  ),
                  _listViewSetup(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listViewSetup() {
    return Column(
      children: [
        _buildTextField('Name', 'Enter your full name', nameController),
        _buildTextField(
            'Whatsapp Number', 'Enter your Whatsapp Number', wtspController),
        _buildTextField(
            'Address', 'Enter your full Address', addressController),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                    fontFamily: 'Poppins',
                  )),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: 400,
                height: 79.98,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.5),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.5),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  hint: const Text("Choose an item"),
                  value: selectedLocation,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: ['Kozhikode', 'Kannur', 'Wayanad', 'Kollam']
                      .map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (newValue) {
                    selectedLocation = newValue!;
                  },
                ),
              ),
            ]),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Branch',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                    fontFamily: 'Poppins',
                  )),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: 400,
                height: 79.98,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.5),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.5),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  hint: const Text("Choose an item"),
                  value: selectedBranch,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: ['Koyilandi', 'Thalassery', 'Sulthan Bathery']
                      .map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (newValue) {
                    selectedBranch = newValue!;
                  },
                ),
              ),
            ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Treatments',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                  fontFamily: 'Poppins',
                )),
            const SizedBox(
              height: 4,
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Row(
                      children: [
                        const Text('1. Couple Combo package',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w500)),
                        const SizedBox(
                          width: 25,
                        ),
                        const Icon(
                          Icons.close,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 26),
                    child: Row(
                      children: [
                        const Text('Male',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF006837),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 23,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: const Color(0xFF000000).withOpacity(0.1),
                          )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Female',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF006837),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 23,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: const Color(0xFF000000).withOpacity(0.1),
                          )),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        const Icon(
                          Icons.edit,
                          color: Color(0xFF006837),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                _buildModelSheeet();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(330, 50),
                backgroundColor: Color.fromARGB(255, 195, 216, 206),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                '+ Add Treatments',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        _buildTextField('Total Amount', '', totalController),
        _buildTextField('Discount Amount', '', discountController),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Payment Option',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                  fontFamily: 'Poppins',
                )),
            Row(
              children: <Widget>[
                Expanded(
                    child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text('Cash'),
                  leading: Radio<CashMethod>(
                    value: CashMethod.cash,
                    groupValue: _cashMethod,
                    onChanged: (CashMethod? value) {
                      setState(() {
                        _cashMethod = value;
                      });
                      debugPrint(_cashMethod!.name);
                    },
                  ),
                )),
                Expanded(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('Card'),
                    leading: Radio<CashMethod>(
                      value: CashMethod.card,
                      groupValue: _cashMethod,
                      onChanged: (CashMethod? value) {
                        setState(() {
                          _cashMethod = value;
                        });
                        debugPrint(_cashMethod!.name);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text('UPI'),
                    leading: Radio<CashMethod>(
                      value: CashMethod.upi,
                      groupValue: _cashMethod,
                      onChanged: (CashMethod? value) {
                        setState(() {
                          _cashMethod = value;
                        });
                        debugPrint(_cashMethod!.name);
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        _buildTextField('Advance Amount', '', advanceController),
        _buildTextField('Balance Amount', '', balanceController),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Treatment Date',
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
                controller: treatmentDateController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.5),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.5),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      color: iconColor,
                      size: 23,
                    ),
                    contentPadding: const EdgeInsets.all(12)),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Treatment Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                  fontFamily: 'Poppins',
                )),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 79.98,
                  width: 160,
                  child: TextFormField(
                    controller: treatmentDateController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.5),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.5),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        hintText: 'Hour',
                        suffixIcon: const Icon(Icons.keyboard_arrow_down,
                            color: iconColor, size: 26),
                        contentPadding: const EdgeInsets.all(12)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 79.98,
                  width: 160,
                  child: TextFormField(
                    controller: treatmentDateController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.5),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.5),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: iconColor,
                          size: 26,
                        ),
                        hintText: 'Minutes',
                        contentPadding: const EdgeInsets.all(12)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(330, 50),
            backgroundColor: const Color(0xFF006837),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: const Text(
            'Save',
            style: TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  Future<dynamic> _buildModelSheeet() {
    return showModalBottomSheet(isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 15, right: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text('Choose Treatment',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                      fontFamily: 'Poppins',
                                    )),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  width: 400,
                                  height: 79.98,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.5),
                                        borderSide: BorderSide(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.1),
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.5),
                                        borderSide: BorderSide(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.1),
                                          width: 1,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.all(10),
                                    ),
                                    hint: const Text(
                                        "Choose preferred treatment"),
                                    isExpanded: true,
                                    icon:
                                        const Icon(Icons.keyboard_arrow_down),
                                    items: [''].map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (newValue) {},
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Add Patients',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: textColor,
                                    fontFamily: 'Poppins',
                                  )),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 79.98,
                                    width: 110,
                                    child: TextFormField(
                                      controller: treatmentDateController,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.5),
                                            borderSide: BorderSide(
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.5),
                                            borderSide: BorderSide(
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                              width: 1,
                                            ),
                                          ),
                                          hintText: 'Male',
                                          contentPadding:
                                              const EdgeInsets.all(12)),
                                      keyboardType:
                                          TextInputType.emailAddress,
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 30),
                                    child: Stack(children: const [
                                      CircleAvatar(
                                        backgroundColor: iconColor,
                                        maxRadius: 20,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 10),
                                          child: Icon(
                                            Icons.minimize_sharp,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 79.98,
                                    width: 55,
                                    child: TextFormField(
                                      controller: treatmentDateController,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.5),
                                            borderSide: BorderSide(
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.5),
                                            borderSide: BorderSide(
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                              width: 1,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(12)),
                                      keyboardType:
                                          TextInputType.emailAddress,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 30),
                                    child: Stack(children: const [
                                      CircleAvatar(
                                        backgroundColor: iconColor,
                                        maxRadius: 20,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 79.98,
                                    width: 110,
                                    child: TextFormField(
                                      controller: treatmentDateController,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.5),
                                            borderSide: BorderSide(
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.5),
                                            borderSide: BorderSide(
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                              width: 1,
                                            ),
                                          ),
                                          hintText: 'female',
                                          contentPadding:
                                              const EdgeInsets.all(12)),
                                      keyboardType:
                                          TextInputType.emailAddress,
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 30),
                                    child: Stack(children: const [
                                      CircleAvatar(
                                        backgroundColor: iconColor,
                                        maxRadius: 20,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 10),
                                          child: Icon(
                                            Icons.minimize_sharp,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 79.98,
                                    width: 55,
                                    child: TextFormField(
                                      controller: treatmentDateController,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.5),
                                            borderSide: BorderSide(
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3.5),
                                            borderSide: BorderSide(
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                              width: 1,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(12)),
                                      keyboardType:
                                          TextInputType.emailAddress,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 30),
                                    child: Stack(children: const [
                                      CircleAvatar(
                                        backgroundColor: iconColor,
                                        maxRadius: 20,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(330, 50),
                            backgroundColor: const Color(0xFF006837),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  );
                },
              );
  }

  Column _buildTextField(
      String text1, String text2, TextEditingController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text1,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: textColor,
              fontFamily: 'Poppins',
            )),
        const SizedBox(height: 10),
        SizedBox(
          height: 79.98,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.5),
                  borderSide: BorderSide(
                    color: const Color(0xFF000000).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.5),
                  borderSide: BorderSide(
                    color: const Color(0xFF000000).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                hintText: text2,
                contentPadding: const EdgeInsets.all(12)),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ],
    );
  }
}
