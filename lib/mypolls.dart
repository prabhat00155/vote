import 'package:flutter/material.dart';

import 'questions.dart';

class MyPolls extends StatelessWidget {
  const MyPolls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Polls"),
      ),
      body: FutureBuilder<List>(
          future: fetchQuestions(),
          initialData: List(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(child: displayPoll(snapshot.data[index]));
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}
