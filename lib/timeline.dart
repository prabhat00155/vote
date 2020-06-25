import 'package:flutter/material.dart';

import 'questions.dart';

class Timeline extends StatelessWidget {
  const Timeline({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: fetchQuestions(),
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
                          child: displayPoll(snapshot.data[index]),
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
