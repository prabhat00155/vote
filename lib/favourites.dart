import 'package:flutter/material.dart';

import 'questions.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mypolls = questions(pageType.favourites);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
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
