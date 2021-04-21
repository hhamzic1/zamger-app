import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/models/certificates.dart';
import 'package:zamgerapp/models/person.dart';
import 'package:zamgerapp/navigation/certificates/create_certificate_screen.dart';
import 'package:zamgerapp/widgets/widgets.dart';

class CertificatesPage extends StatefulWidget {
  Person _currentPerson;
  CertificatesPage(Person currentPerson) {
    _currentPerson = currentPerson;
  }

  @override
  _CertificatesState createState() => _CertificatesState(_currentPerson);
}

class _CertificatesState extends State<CertificatesPage> {
  Certificates _certs;
  dynamic _purposeTypes;
  Person _currentPerson;
  _CertificatesState(Object currentPerson) {
    _currentPerson = currentPerson;
  }
  @override
  void initState() {
    super.initState();
    _fetchCertificates();
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
                      title: Text("Zahtjevi"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CreateCertificate(
                                        _purposeTypes, _currentPerson.id),
                                  ));
                            },
                            child: Icon(Icons.add_sharp, color: Colors.white))
                      ],
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
                Expanded(child: _buildCertsList()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchCertificates() async {
    var response = await ZamgerAPIService.getMyCertificates(_currentPerson.id);
    var response2 = await ZamgerAPIService.getCertificatePurposeTypes();
    setState(() {
      _purposeTypes = response2.data["purposes"];
      _certs = Certificates.fromJson(response.data);
    });
  }

  Widget _buildCertsList() {
    return _certs != null
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                itemCount: _certs.results.length,
                itemBuilder: (BuildContext context, int index) {
                  var purposeId =
                      _certs.results[index].certificatePurpose.toString();
                  var purpose = _purposeTypes[purposeId];
                  return Card(
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [lightBlue, etfBlue]),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.white24))),
                          child: _certs.results[index].status == 1
                              ? Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                        ),
                        title: Text(
                          _certs.results[index].certificateType == 1
                              ? 'Potvrda o redovnom studiju'
                              : 'Uvjerenje o položenim ispitima',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " U svrhu: " + purpose,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(_certs.results[index].datetime,
                                  style: TextStyle(color: Colors.white))
                            ]),
                        trailing: _certs.results[index].status == 2
                            ? null
                            : TextButton(
                                child: Icon(Icons.cancel,
                                    color: Colors.white, size: 30.0),
                                onPressed: () async {
                                  _showAlertDialog(
                                      context, _certs.results[index].id);
                                  setState(() {
                                    _fetchCertificates();
                                  });
                                },
                              ),
                      ),
                    ),
                  );
                }),
            onRefresh: () async {
              setState(() {
                _fetchCertificates();
              });
            },
          )
        : Center(child: CircularProgressIndicator());
  }

  Future<void> _cancelCertificate(int id) async {
    await ZamgerAPIService.cancelCertificateById(id);
    _fetchCertificates();
  }

  _showAlertDialog(BuildContext context, certId) {
    AlertDialog alert = AlertDialog(
      title: Text('Upozorenje'), // To display the title it is optional
      content: Text('Da li ste sigurni da želite otkazati zahtjev?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('NE'),
        ),
        TextButton(
          onPressed: () async {
            await _cancelCertificate(certId);
            Navigator.of(context).pop();
          },
          child: Text('DA'),
        ),
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
