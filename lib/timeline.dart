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

  _State({this.data});

  Widget build(BuildContext context) {
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
          _displayOptions(data.options[i].text,
              _calculateFraction(data.options[i].count, data.totalVotes), i),
      ],
    );
  }

  ListTile _displayOptions(option, percent, index) {
    return ListTile(
      title: option == null || option == ''
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
              linearStrokeCap: LinearStrokeCap.butt,
              backgroundColor: Colors.grey[100],
              progressColor: Colors.blue[50],
            ),
      leading: option == null || option == ''
          ? Offstage()
          : Radio(
              value: index,
              groupValue: choice,
              onChanged: (value) {
                vote(value);
                setState(() {
                  choice = value;
                });
              },
            ),
    );
  }

  void vote(option) {
    print('voted $option!');
  }

  double _calculateFraction(vote, total) {
    if (vote == '') return 0;
    var denominator = total is String ? double.parse(total) : total.toDouble();
    if (denominator == 0) return 0;
    var numerator = (vote is String ? double.parse(vote) : total.toDouble());
    return numerator / denominator;
  }
}
