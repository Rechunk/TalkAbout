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

  updateSearchResultsAndAmountOfMatches(String response){
    matchingDiscussions = removeKeyFromJsonList(JSON.decode(response));
    discussionsToDisplay = matchingDiscussions;
    setNewRowContent();
    updateAmountOfMatches();
  }

  HttpRequest.getString(url).then(updateSearchResultsAndAmountOfMatches);
}
