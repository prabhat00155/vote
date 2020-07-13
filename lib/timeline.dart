import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'questions.dart';

class Timeline extends StatelessWidget {
  const Timeline({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: fetchQuestions("questions"),
        initialData: List(),
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Vote!'),
                ),
              ),
              snapshot.hasData
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Card(
                          child: DisplayTimeline(data: snapshot.data[index]),
                        ),
                        childCount: snapshot.data.length,
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: CircularProgressIndicator(),
                    ),
            ],
          );
        },
      ),
    );
  }
}

class DisplayTimeline extends StatefulWidget {
  final data;

  DisplayTimeline({this.data});

  @override
  _State createState() => _State(data: this.data);
}

class _State extends State<DisplayTimeline> {
  final data;
  int choice;
  double totalVotes;
  List<double> votes = List<double>();

  _State({this.data});

  Widget build(BuildContext context) {
    totalVotes = _stringToDouble(data.totalVotes);
    if (totalVotes == 0) totalVotes = 1;
    for (int i = 0; i < data.options.length; i++)
      votes.add(_stringToDouble(data.options[i].count));
    return _display(this.data);
  }

  Column _display(data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          data.question,
          style: TextStyle(fontSize: 18.0),
        ),
        for (int i = 0; i < data.options.length; i++)
          _displayOptions(data.options[i].text, i),
      ],
    );
  }

  ListTile _displayOptions(option, index) {
    return ListTile(
      leading: option == null || option == ''
          ? Offstage()
          : Radio(
              value: index,
              groupValue: choice,
              onChanged: (value) {
                setState(() {
                  if (choice != null) {
                    votes[choice] -= 1;
                    totalVotes -= 1;
                  }
                  choice = value;
                  votes[index] += 1;
                  totalVotes += 1;
                });
              },
            ),
      title: option == null || option == ''
          ? Offstage()
          : LinearPercentIndicator(
              animation: true,
              animationDuration: 500,
              width: 240.0,
              lineHeight: 20.0,
              percent: votes[index] / totalVotes,
              center: Text(
                option,
                style: TextStyle(fontSize: 18.0),
              ),
              linearStrokeCap: LinearStrokeCap.butt,
              backgroundColor: Colors.grey[100],
              progressColor: Colors.blue[50],
            ),
    );
  }

  double _stringToDouble(item) {
    if (item == '') return 0;
    return item is String ? double.parse(item) : item.toDouble();
  }
}
