import "Discussion.dart";
import "SingleComment.dart";
import "dart:html";
import "dart:convert";


GetEntryDiscussionsFromDb(){
  var url = "http://localhost:8082/discussionApi/v1/getAllDiscussions";

  getRawJson(String response){
    return response;
  }

  return HttpRequest.getString(url).then(getRawJson);
}



List<SingleComment> comments = [
  new SingleComment("Jake", new DateTime.now(), "This is such a boring topic..."),
  new SingleComment("Bob", new DateTime.now(), "Wow, I didn't except such a topic to come up here, lol!")
];
