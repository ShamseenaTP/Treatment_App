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

class _BodyState extends State<Body> {
  String selectedValue = 'Date';

  late APIService apiService;
  bool isApiCallProcess = false;

  late PatientModel _patient = PatientModel(patient: []);

  void getPatient() async {
    try {
      bool isApiCallProcess = true;
      String url = "https://flutter-amr.noviindus.in/api/PatientList";
      String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzk0MTE0NjQxLCJpYXQiOjE3MDc3MTQ2NDEsImp0aSI6ImNkYmI0MmQ1Y2NjMjQ3MjJiZTFiNzliYzZiMzNmYjMwIiwidXNlcl9pZCI6MjF9.eaWyfBeznzEI0MsLJY07vM2d0C6zCi7CATi_cIGIDGU";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        bool isApiCallProcess = false;
        var json = jsonDecode(response.body);
        setState(() {
          _patient = PatientModel.fromJson(json);
        });
      } else {
        throw Exception('failed');
      }
    } catch (error) {
      throw Exception('$error');
    }
  }

  @override
  void initState() {
    super.initState();
    apiService = APIService();
    getPatient();
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
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 235,
                        child: TextFormField(
                          // controller: _passwordController,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: const Color(0xFF000000)
                                        .withOpacity(0.1))),
                            hintText: 'Search for treatments',
                            prefixIcon: const Icon(Icons.search),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            alignLabelWithHint: false,
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(330, 50),
                            backgroundColor: const Color(0xFF006837),
                            padding: const EdgeInsets.symmetric(vertical: 9),
                          ),
                          child: const Text(
                            'Search',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Sort by :'),
                          )),
                      const Expanded(flex: 2, child: SizedBox()),
                      Expanded(
                        flex: 8,
                        child: SizedBox(
                          width: 400,
                          height: 40,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF000000).withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF000000).withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                            ),
                            // hint: const Text("Choose an item"),
                            value: selectedValue,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: iconColor,
                            ),
                            items: ['Date', 'Month', 'Year']
                                .map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (newValue) {
                              selectedValue = newValue!;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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
            Padding(
              padding: const EdgeInsets.only(top: 500),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(330, 50),
                  backgroundColor: const Color(0xFF006837),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Register Now',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listViewSetup() {
    return ListView.builder(
      itemCount: _patient.patient!.length,
      itemBuilder: (context, index) {
        final data = _patient.patient![index];
        return Card(
            margin: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    '${index + 1}. ${data.name}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    'Couple Combo Package',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: iconColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month, color: Colors.red),
                      Text(
                          '${data.dateNdTime != null ? DateFormat("dd-MM-yyyy").format(DateTime.parse('${data.dateNdTime!.toIso8601String()}')) : DateTime.now()}',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w300)),
                      const SizedBox(
                        width: 100,
                      ),
                      const Icon(
                        Icons.person,
                        color: Colors.red,
                      ),
                      Text('${data.user}',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w300))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: SizedBox(
                    height: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 189, 186, 186)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  child: Row(
                    children: [
                       Text(
                        'View Booking Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        width: 120,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: iconColor,
                        size: 17,
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
    );
  }
}
