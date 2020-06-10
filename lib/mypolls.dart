import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
                            Text(
                              snapshot.data[index].question,
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                              width: double.infinity,
                              child: LinearPercentIndicator(
                                animation: true,
                                animationDuration: 500,
                                width: 140.0,
                                lineHeight: 20.0,
                                percent: 0.5,
                                center: Text(
                                  snapshot.data[index].option1,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                backgroundColor: Colors.grey[100],
                                progressColor: Colors.blue[50],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                              width: double.infinity,
                              child: LinearPercentIndicator(
                                animation: true,
                                animationDuration: 500,
                                width: 140.0,
                                lineHeight: 20.0,
                                percent: 0.3,
                                center: Text(
                                  snapshot.data[index].option2,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                backgroundColor: Colors.grey[100],
                                progressColor: Colors.blue[50],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                              width: double.infinity,
                              child: snapshot.data[index].option3 == null
                                  ? Offstage()
                                  : LinearPercentIndicator(
                                      animation: true,
                                      animationDuration: 500,
                                      width: 140.0,
                                      lineHeight: 20.0,
                                      percent: 0.1,
                                      center: Text(
                                        snapshot.data[index].option3,
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      backgroundColor: Colors.grey[100],
                                      progressColor: Colors.blue[50],
                                    ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
                              width: double.infinity,
                              child: snapshot.data[index].option4 == null
                                  ? Offstage()
                                  : LinearPercentIndicator(
                                      animation: true,
                                      animationDuration: 500,
                                      width: 140.0,
                                      lineHeight: 20.0,
                                      percent: 0.1,
                                      center: Text(
                                        snapshot.data[index].option4,
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      backgroundColor: Colors.grey[100],
                                      progressColor: Colors.blue[50],
                                    ),
                            ),
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
