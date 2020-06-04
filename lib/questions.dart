import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Question {
  final int questionId;
  final String userId;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  Question(
      {this.questionId,
      this.userId,
      this.question,
      this.option1,
      this.option2,
      this.option3,
      this.option4});

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'option1': option1,
      'option2': option2,
    };
  }
}

Future<List<Question>> questions() async {
  // Hard-coded DB location for the time-being.
  final Future<Database> database = openDatabase(
    join('/Users/prroy/Documents/Apps/flutter_projects/databases/', 'vote.db'),
  );
  // Get a reference to the database.
  final Database db = await database;

  // Query the table for all the questions.
  final List<Map<String, dynamic>> maps = await db.query('questions');

  // Convert the List<Map<String, dynamic> into a List<Question>.
  return List.generate(maps.length, (i) {
    return Question(
      questionId: maps[i]['question_id'],
      userId: maps[i]['user_id'],
      question: maps[i]['question'],
      option1: maps[i]['option1'],
      option2: maps[i]['option2'],
      option3: maps[i]['option3'],
      option4: maps[i]['option4'],
    );
  });
}
