import 'package:flutter/material.dart';

import 'questions.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
      ),
      body: FutureBuilder<List>(
          future: fetchQuestions("questions"),
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
