import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/models/certificate.dart';
import 'package:zamgerapp/models/index.dart';
import 'package:zamgerapp/widgets/widgets.dart';

class CreateCertificate extends StatefulWidget {
  Map<String, dynamic> _purposeTypes;
  Person _currentPerson;
  List<String> _purposes = [];
  List<String> _types = [];
  CreateCertificate(purposeTypes, currentPersonId) {
    _purposeTypes = purposeTypes;
    _currentPerson = new Person();
    _currentPerson.id = currentPersonId;

    _purposeTypes.forEach((k, v) {
      _purposes.add(v);
      _types.add(k);
    });
  }
  @override
  _CreateCertificateState createState() =>
      _CreateCertificateState(_currentPerson, _purposes, _types);
}

class _CreateCertificateState extends State<CreateCertificate> {
  Person _currentPerson;
  List<String> _purposes;
  List<String> _types;
  List<String> _certNames;
  List<int> _certTypes;

  String _chosenPurpose;
  String _chosenCertName;
  _CreateCertificateState(
      Person currentPerson, List<String> purposes, List<String> types) {
    _currentPerson = currentPerson;
    _purposes = purposes;
    _types = types;
    _certNames = [
      "potvrda o redovnom studiju",
      "uvjerenje o položenim ispitima"
    ];
    _certTypes = [1, 2];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              painter: CurvePainter(),
              child: Container(
                height: 300.0,
              ),
            ),
            Column(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: PreferredSize(
                    preferredSize: Size.fromHeight(100),
                    child: AppBar(
                      backgroundColor: etfBlue,
                      title: Text("Kreiraj novi zahtjev"),
                      centerTitle: true,
                      elevation: 0,
                      leading: TextButton(
                        child: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Text(
                  'Tip zahtjeva: ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: DropdownButton(
                    hint: Text(
                      'Izaberite tip',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    isExpanded: true,
                    underline: SizedBox(),
                    value: _chosenCertName,
                    onChanged: (newValue) {
                      setState(() {
                        _chosenCertName = newValue;
                      });
                    },
                    items: _certNames.map((valueItem) {
                      return DropdownMenuItem(
                        child: Text(valueItem),
                        value: valueItem,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'U svrhu:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: DropdownButton(
                    hint: Text(
                      'Izaberite svrhu',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    isExpanded: true,
                    underline: SizedBox(),
                    value: _chosenPurpose,
                    onChanged: (newValue) {
                      setState(() {
                        _chosenPurpose = newValue;
                      });
                    },
                    items: _purposes.map((valueItem) {
                      return DropdownMenuItem(
                        child: Text(valueItem),
                        value: valueItem,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 55),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: etfBlue, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () async {
                        await _sendNewCertificate(
                            _chosenPurpose, _chosenCertName);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: Text(
                            "Pošalji",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _findTypeForPurpose(String purpose) {
    for (int i = 0; i < _purposes.length; i++) {
      if (_purposes[i] == purpose) {
        return int.parse(_types[i]);
      }
    }
    return -1;
  }

  int _findCertTypeByName(certName) {
    for (int i = 0; i < _certNames.length; i++) {
      if (_certNames[i] == certName) {
        return _certTypes[i];
      }
    }
    return -1;
  }

  Future<void> _sendNewCertificate(chosenPurpose, chosenCertName) async {
    int purposeType = _findTypeForPurpose(chosenPurpose);
    int certType = _findCertTypeByName(chosenCertName);
    Certificate cert = new Certificate();
    cert.student = _currentPerson;
    cert.certificatePurpose = purposeType;
    cert.certificateType = certType;
    var response =
        await ZamgerAPIService.sendCertificate(cert.student.id, cert);
    if (response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Greška"),
      content: Text("Zahtjev nije poslan!"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
