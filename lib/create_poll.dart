import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/entity/create_poll.dart';

const MAX_OPTIONS_ALLOWED = 5;

class CreatePoll extends StatefulWidget {
  @override
  _CreatePollState createState() => _CreatePollState();
}

class _CreatePollState extends State<CreatePoll> {
  final databaseReference = Firestore.instance;

  int _count = 1;
  List<TextEditingController> optionTextFieldControllers;
  var quesTextFieldController;
  bool _isAddOptionButtonDisabled = false;

  @override
  void dispose() {
    //_count = 1;
    // Clean up the controller when the widget is disposed.
    quesTextFieldController.dispose();
    optionTextFieldControllers.forEach((element) {
      element.dispose();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    quesTextFieldController = TextEditingController();
    optionTextFieldControllers =
        new List.generate(_count, (int i) => TextEditingController());

    return Scaffold(
      appBar: appBar(),
      body: LayoutBuilder(builder: (context, constraint) {
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
              ),
              quesTextFormField(),
              Container(
                padding: EdgeInsets.all(20.0),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _count,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return optionContainer(index);
                    }),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: RaisedButton(
                  onPressed: _isAddOptionButtonDisabled ? null : _addNewOption,
                  //_addNewOption,
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget appBar() {
    return AppBar(
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
              onTap: savePoll,
              child: Icon(Icons.send),
            )),
      ],
    );
  }

  void savePoll() {
    print('Saving object...');
    print('ques text is ' + quesTextFieldController.text);
    List<String> tags = extractTags();
    List<String> options = List();
    optionTextFieldControllers.forEach((element) {
      if (element.text.isNotEmpty) {
        options.add(element.text);
        print('value of each controller is ' + element.text);
      }
    });

    String ques = quesTextFieldController.text;

    if (ques.isNotEmpty && options.isNotEmpty) {
      CreatePollEntity createPollEntity =
          new CreatePollEntity(tags, ques, options, 'test_user_1');
      createRecord(createPollEntity);
    }
  }

  Widget optionContainer(index) {
    var myController = optionTextFieldControllers[index];

    return Container(
      width: 170.0,
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,
            controller: myController,
            decoration: InputDecoration(
              labelText: 'Option',
              suffixIcon: _count > 1
                  ? null
                  : IconButton(
                      onPressed: () =>
                          {print('option add a photo button clicked')},
                      icon: Icon(Icons.add_a_photo),
                    ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
          ),
        ],
      ),
    );
  }

  Widget quesTextFormField() {
    return TextField(
      controller: quesTextFieldController,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () => {print('ques add a photo button clicked')},
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
      if (_count == MAX_OPTIONS_ALLOWED) {
        _isAddOptionButtonDisabled = true;
      }
    });
  }

  void createRecord(CreatePollEntity createPollEntity) async {
    print('create record called for ' + createPollEntity.toString());
    DocumentReference ref =
        await databaseReference.collection("questions").add({
      'Tags': createPollEntity.tags,
      'question': createPollEntity.question,
      'options': createPollEntity.options,
      'total_vote': createPollEntity.totalVote,
      'user_id': createPollEntity.userId,
      'visibility': createPollEntity.visibility.toString(),
    });
    print(ref.documentID);
  }

  List<String> extractTags() {
    return null;
  }
}
