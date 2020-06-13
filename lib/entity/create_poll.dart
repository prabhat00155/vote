class CreatePollEntity {
  List<String> tags;
  String question;
  List<Map<String, String>> options;
  int totalVote;
  String userId;
  Visibility visibility;

  CreatePollEntity(
      List<String> tags, String ques, List<String> optionsValue, String userId,
      {Visibility visibility: Visibility.local}) {
    this.tags = tags;
    this.question = ques;
    this.options = getOptions(optionsValue);
    this.userId = userId;
    this.totalVote = 0;
    this.visibility = visibility;
  }

  List<Map<String, String>> getOptions(List<String> optionsValue) {
    List<Map<String, String>> optionEntityList = new List();
    optionsValue.forEach((element) {
      optionEntityList.add({"count": "0", "text": element});
    });
    return optionEntityList;
  }
}

enum Visibility { none, global, local, nation }
