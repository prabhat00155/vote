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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(snapshot.data[index].question),
                            Container(
                                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                                width: double.infinity,
                                child: Text(snapshot.data[index].option1)),
                            Container(
                                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                                width: double.infinity,
                                child: Text(snapshot.data[index].option2)),
                            Container(
                                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                                width: double.infinity,
                                child: snapshot.data[index].option3 != null
                                    ? Text(snapshot.data[index].option3)
                                    : Offstage()),
                            Container(
                                margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                                width: double.infinity,
                                child: snapshot.data[index].option4 != null
                                    ? Text(snapshot.data[index].option4)
                                    : Offstage())
                          ],
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
