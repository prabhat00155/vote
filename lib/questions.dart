import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

enum pageType {
  mypolls,
  favourites,
  timeLine,
}

class Question {
  final String questionId;
  final String userId;
  final String question;
  final List<String> options;
  final List<String> votes;
  final String totalVotes;
  Question({
    this.questionId,
    this.userId,
    this.question,
    this.options,
    this.votes,
    this.totalVotes,
  });
}

List<Question> questions(page) {
  List<Question> questions;
  switch (page) {
    case pageType.mypolls:
      questions = dataToQuestion(mypollData);
      break;
    case pageType.favourites:
      questions = dataToQuestion(favouritesData);
      break;
    case pageType.timeLine:
      questions = dataToQuestion(favouritesData);
      break;
  }
  return questions;
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
      for (int i = 0; i < data.options.length; i++)
        displayOption(
            data.options[i], calculateFraction(data.votes[i], data.totalVotes)),
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

const List<String> mypollData = [
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

const List<String> favouritesData = [
  "18,anon1,Do you like working out?,Yes,No,may be,,,18,15,11,,,44",
  "19,anon1,Do you like first dates?,Yes,No,may be,,,35,8,12,,,55",
  "20,anon1,Do you like clubbing?,Yes,No,may be,,,22,39,27,,,88",
  "21,anon1,Do you like dancing?,Yes,No,may be,,,34,44,21,,,99",
  "22,anon1,Do you like singing?,Yes,No,may be,,,30,30,7,,,67",
  "23,anon1,A car you wish you had?,Bugatti,Ferrari,Lamborghini,Aston Martin,Rolls Royce,129,73,84,113,166,565",
  "24,anon1,Which language do you mostly use for coding?,C,C++,Java,Python,Other,10,10,8,10,6,44",
  "25,anon1,What’s worse?,Corruption,Gerrymandering,Divisive politics,,,134,103,108,,,345",
  "26,anon1,Cats or dogs?,Cats,Dogs,Neither,,,10,19,14,,,43",
  "27,anon1,Your favourite genre of music?,Rock,Pop,Punk,Jazz,Heavy metal,79,79,69,69,49,345",
  "28,anon1,Favourite actress?,Shraddha Kapoor,Disha Patani,Alia Bhatt,Deepika Padukone,Other,15,15,13,13,10,66",
  "29,anon1,Favourite cuisine?,Indian,Italian,Chinese,Japanese,Thai,3,3,2,2,4,14",
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
    options: items.sublist(3, 8),
    votes: items.sublist(8, 13),
    totalVotes: items[13],
  );
}
