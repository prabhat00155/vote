import 'package:flutter/material.dart';

import 'questions.dart';

class MyPolls extends StatelessWidget {
  const MyPolls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mypolls = questions(pageType.mypolls);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Polls"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(child: displayPoll(mypolls[index]));
        },
        itemCount: mypolls.length,
      ),
    );
  }
}
