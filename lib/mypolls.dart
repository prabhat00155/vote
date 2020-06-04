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
          future: questions(),
          initialData: List(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              Card(
                                child: Text(snapshot.data[index].question),
                              ),
                              Text(snapshot.data[index].option1),
                              Text(snapshot.data[index].option2),
                              Text(snapshot.data[index].option3 ?? 'None'),
                              Text(snapshot.data[index].option4 ?? 'None'),
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}
