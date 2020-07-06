import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/entity/create_poll.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  File _takenImage;

  Future<void> _takePicture() async {
    print('take picture clicked');
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _takenImage = imageFile;
    });
    //TODO -> save image to db
    //below code can be used to upload image to db
//    final appDir = await pPath.getApplicationDocumentsDirectory();
//    final fileName = path.basename(imageFile.path);
//    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
  }

  @override
  void dispose() {
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
              if (_takenImage != null)
                Container(
                  height: 200.0,
                  width: 200.0,
                  child: Image.file(_takenImage),
                  color: Colors.white10,
                ),
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
      automaticallyImplyLeading: true,
      title: Text("Create Poll"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, false),
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
            onPressed: _takePicture,
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
