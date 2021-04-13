import 'package:flutter/material.dart';
import 'package:zamgerapp/ZamgerAPI/zamger_api_service.dart';
import 'package:zamgerapp/configuration/themeconfiguration.dart';
import 'package:zamgerapp/models/index.dart';
import 'package:zamgerapp/widgets/widgets.dart';

class ComposeMessagePage extends StatefulWidget {
  @override
  _ComposeMessagePageState createState() => new _ComposeMessagePageState();
}

class _ComposeMessagePageState extends State<ComposeMessagePage> {
  final TextEditingController _filter = new TextEditingController();

  String _searchText = "";
  List<Person> names = [];
  List<Person> filteredNames = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Pretraži korisnike');

  _ComposeMessagePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = [];
        });
      } else {
        setState(() {
          _getNames();
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Padding(
          padding: const EdgeInsets.only(left: 23.0, right: 23, top: 30),
          child: _buildList()),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      backgroundColor: etfBlue,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildList() {
    if (_searchText.isNotEmpty) {
      List<Person> tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        var searchFields = filteredNames[i].name +
            " " +
            filteredNames[i].surname +
            " (" +
            filteredNames[i].login +
            ")";
        if (searchFields.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            SizedBox(height: 10),
            ChatItems(
                null,
                filteredNames[index].login,
                filteredNames[index].name + " " + filteredNames[index].surname,
                "",
                filteredNames[index],
                null,
                "compose")
          ],
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Pretraži'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Pretraži korisnike');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    final response = await ZamgerAPIService.findPersonBySearch(_filter.text);
    Persons persons = Persons.fromJson(response.data);
    List<Person> tempList = [];
    tempList.addAll(persons.results);
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}
