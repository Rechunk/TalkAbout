import "SingleComment.dart";
import "dart:html";
import "dart:convert";
import "discussionSearch.dart";

serviceGetEntryDiscussionsFromDb(){
  var url = "http://localhost:8082/discussionApi/v1/getAllDiscussions";

  getAllDiscussions(String response){
    return JSON.decode(response);
  }

  return HttpRequest.getString(url).then(getAllDiscussions);
}

void serviceSetupMatchingDiscussions(){
  var url = "http://localhost:8082/discussionApi/v1/getMatchingDiscussions/$searchTerm";

  populateMatchingDiscussionsAndUpdateAmountOfMatches(String response){
    var l = JSON.decode(response);
    matchingDiscussions = removeKeyFromJsonList(l);
    updateAmountOfMatches();
  }

  HttpRequest.getString(url).then(populateMatchingDiscussionsAndUpdateAmountOfMatches);
}




List<SingleComment> comments = [
  new SingleComment("Jake", new DateTime.now(), "This is such a boring topic..."),
  new SingleComment("Bob", new DateTime.now(), "Wow, I didn't except such a topic to come up here, lol!")
];
