import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

enum pageType {
  mypolls,
  favourites,
  timeLine,
}

enum Visibility {
  local,
  regional,
  national,
  global,
}

class Option {
  final String text;
  final String count;
  Option({this.text, this.count});
}

class Question {
  final String questionId;
  final String userId;
  final String question;
  final List<Option> options;
  final int totalVotes;
  final List<String> tags;
  final Visibility visibility;
  Question({
    this.questionId,
    this.userId,
    this.question,
    this.options,
    this.totalVotes,
    this.tags,
    this.visibility,
  });
}

List<Option> _parseOption(options) {
  var res = List<Option>();
  options.forEach((option) {
    res.add(Option(text: option['text'], count: option['count']));
  });
  return res;
}

Future<List<Question>> fetchQuestions() async {
  final databaseReference = Firestore.instance;
  var ref = databaseReference.collection("questions");
  var querySnapshot = await ref.getDocuments();
  var questionsList = List<Question>();
  querySnapshot.documents.forEach((document) {
    try {
      questionsList.add(Question(
        questionId: document.documentID,
        userId: document.data['user_id'],
        question: document.data['question'],
        options: _parseOption(document.data['options']),
        totalVotes: document.data['total_vote'],
        tags: document.data['tags'],
      ));
    } catch (e) {
      print("Error parsing ${document.data}");
    }
  });
  return questionsList;
}

double _calculateFraction(vote, total) {
  if (vote == '') return 0;
  var denominator = total is String ? double.parse(total) : total.toDouble();
  if (denominator == 0) return 0;
  var numerator = (vote is String ? double.parse(vote) : total.toDouble());
  return numerator / denominator;
}

Column displayPoll(data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        data.question,
        style: TextStyle(fontSize: 18.0),
      ),
      for (int i = 0; i < data.options.length; i++)
        _displayOption(data.options[i].text,
            _calculateFraction(data.options[i].count, data.totalVotes)),
    ],
  );
}

Container _displayOption(option, percent) {
  return Container(
    margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
    width: double.infinity,
    child: option == null || option == ''
        ? Offstage()
        : LinearPercentIndicator(
            animation: true,
            animationDuration: 500,
            width: 240.0,
            lineHeight: 20.0,
            percent: percent,
            center: Text(
              option,
              style: TextStyle(fontSize: 18.0),
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: Colors.grey[100],
            progressColor: Colors.blue[50],
          ),
  );
}
