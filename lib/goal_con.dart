class GoalCon {
  GoalCon(this.text, this.images, this.finished, this.des);

  final List<String> text;
  final List<String> images;
  List<int> finished;
  final List<String> des;

  List<String> getText() {
    return text;
  }

  List<String> getImages() {
    return images;
  }

  List<String> getDes() {
    return des;
  }
}