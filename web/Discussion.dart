import "SingleComment.dart";

class Discussion {
  String admin;
  DateTime time;
  String category;
  String subject;
  List<SingleComment> comments;
  Discussion(this.admin, this.time, this.category, this.subject, this.comments);
}
