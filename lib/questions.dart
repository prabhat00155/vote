import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Question {
  final String questionId;
  final String userId;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String option5;
  final String vote1;
  final String vote2;
  final String vote3;
  final String vote4;
  final String vote5;
  final String totalVotes;
  Question({
    this.questionId,
    this.userId,
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.option5,
    this.vote1,
    this.vote2,
    this.vote3,
    this.vote4,
    this.vote5,
    this.totalVotes,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'option1': option1,
      'option2': option2,
    };
  }
}

List<Question> questions() {
  return dataToQuestion(data);
}

double calculateFraction(vote, total) {
  if (vote == '') return 0;
  return double.parse(vote) / double.parse(total);
}

Column displayPoll(data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        data.question,
        style: TextStyle(fontSize: 18.0),
      ),
      displayOption(
          data.option1, calculateFraction(data.vote1, data.totalVotes)),
      displayOption(
          data.option2, calculateFraction(data.vote2, data.totalVotes)),
      displayOption(
          data.option3, calculateFraction(data.vote3, data.totalVotes)),
      displayOption(
          data.option4, calculateFraction(data.vote4, data.totalVotes)),
      displayOption(
          data.option5, calculateFraction(data.vote5, data.totalVotes)),
    ],
  );
}

Container displayOption(option, percent) {
  return Container(
    margin: EdgeInsets.fromLTRB(3, 3, 10, 3),
    width: double.infinity,
    child: option == null || option == ''
        ? Offstage()
        : LinearPercentIndicator(
            animation: true,
            animationDuration: 500,
            width: 140.0,
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

const List<String> data = [
  "1,anon1,Is this app good?,Yes,No,,,,62,61,,,,123",
  "2,anon1,Are you happy with your life?,Yes,No,,,,76,69,,,,145",
  "3,anon1,Which is better?,Facebook,WhatsApp,TikTok,Instagram,Twitter,28,28,24,24,20,124",
  "4,anon1,Favourite holiday destination?,Maldives,Mauritius,Hawaii,New Zealand,,22,22,19,35,,98",
  "5,anon1,Where would you prefer living?,Island,Mountains,,,,36,75,,,,111",
  "6,anon1,What do you use?,iPhone,Android phone,,,,407,827,,,,1234",
  "7,anon1,What's more important for you?,Money,Happiness,Peace,,,85,110,50,,,245",
  "8,anon1,What's worse for body?,Sugar,Salt,,,,187,380,,,,567",
  "9,anon1,Your favourite sports?,Cricket,Football,Tennis,Formula 1,Badminton,99,99,86,86,62,432",
  "10,anon1,Whom would you say you idolise?,Mahatma Gandhi,John Lennon,Mother Teresa,Nelson Mandela,Martin Luther King Jr.,3,2,1,1,2,9",
];

List<Question> dataToQuestion(data) {
  List<Question> questions = [];
  data.forEach((row) => questions.add(parseRow(row)));
  return questions;
}

Question parseRow(row) {
  var items = row.split(",");
  return Question(
    questionId: items[0],
    userId: items[1],
    question: items[2],
    option1: items[3],
    option2: items[4],
    option3: items[5],
    option4: items[6],
    option5: items[7],
    vote1: items[8],
    vote2: items[9],
    vote3: items[10],
    vote4: items[11],
    vote5: items[12],
    totalVotes: items[13],
  );
}
