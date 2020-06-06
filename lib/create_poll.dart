import 'package:flutter/material.dart';

class CreatePoll extends StatefulWidget {
  @override
  _CreatePollState createState() => _CreatePollState();
}

class _CreatePollState extends State<CreatePoll> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> listOptions =
    new List.generate(_count, (int i) => new OptionsList());

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Create Poll"),
        ),
        body: new LayoutBuilder(builder: (context, constraint) {
          return new Container(
            child: new Column(
              children: <Widget>[
                new Container(
                  padding: new EdgeInsets.all(20.0),
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: 'Question',
                  ),
                ),
                new Container(
                  padding: new EdgeInsets.all(20.0),
                ),
                new Expanded(
                  child: new Container(
                    height: 200.0,
                    child: new ListView(
                      shrinkWrap: false,
                      children: listOptions,
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                ),
                new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: new FlatButton(
                    onPressed: _addNewOption,
                    child: new Icon(Icons.add),
                  ),
                ),
                //new ContactRow()
              ],
            ),
          );
        }));
  }

  void _addNewOption() {
    setState(() {
      _count = _count + 1;
    });
  }
  
}

class OptionsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _OptionsList();
}

class _OptionsList extends State<OptionsList> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        width: 170.0,
        padding: new EdgeInsets.all(5.0),
        child: new Column(children: <Widget>[
          new TextFormField(
            decoration: new InputDecoration(
              labelText: 'Option',
            ),
          ),
          new Container(
            padding: new EdgeInsets.all(20.0),
          ),
        ]));
  }

  @override
  void initState() {
    super.initState();
  }
}
