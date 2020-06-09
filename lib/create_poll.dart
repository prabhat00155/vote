import 'package:flutter/material.dart';

class CreatePoll extends StatefulWidget {
  @override
  _CreatePollState createState() => _CreatePollState();
}

int _count = 1;
List<String> optionsList = new List();
String question = '';

class _CreatePollState extends State<CreatePoll> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listOptions =
        new List.generate(_count, (int i) => new OptionsList());

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Poll"),
        leading: GestureDetector(
          onTap: () {
            /* Write listener code here */
          },
          child: Icon(
            Icons.menu, // add custom icons also
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.label,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.send),
              )),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
              ),
              textFormField(),
              Container(
                padding: EdgeInsets.all(20.0),
              ),
              Expanded(
                child: Container(
                  height: 200.0,
                  child: ListView(
                    shrinkWrap: false,
                    children: listOptions,
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: FlatButton(
                  onPressed: _addNewOption,
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget textFormField() {
    return TextFormField(
      onChanged: (value) {
        print('Value for field saved as "$value"');
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () => {print('add a photo button clicked')},
            icon: Icon(Icons.add_a_photo),
          ),
          border: OutlineInputBorder(),
          labelText: 'Question',
          hintText: 'Who is the best cricketer? #Cricket#ICC'),
    );
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
    return Container(
      width: 170.0,
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            onChanged: (value) {
              print('Value for field option as "$value"');
            },
            decoration: InputDecoration(
              labelText: 'Option',
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
