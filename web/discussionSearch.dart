import 'dart:html';
import "discussion_service.dart";
import "Discussion.dart";
import "dart:convert";

List<Discussion> discussionsFromDb = [];
List<Discussion> discussionsToDisplay = [];
List<Discussion> matchingDiscussions = [];
String searchTerm;
bool currentBoxColorGrey = true;

init(String response) {
  discussionsFromDb = JSON.decode(response);
  discussionsToDisplay = discussionsFromDb;
  PopulateRow();
}

void clearSearchbox(){
  InputElement searchbox = querySelector("#searchfield");
  searchbox.value = "";
  searchTerm = "";
  updateAmountOfMatches();
}

String getDiscussionHtml(var discussionMap){
  changeCurrentBoxColor();
  return '''
  <div class="row ${(currentBoxColorGrey) ? 'bg-grey' : ''}">
  <div class="col-lg-4 col-md-4 col-sm-4 hidden-xs">
    <div class="${(currentBoxColorGrey) ? 'whitesidecolumn' : 'greysidecolumn'}">
      <i class="material-icons">access_time</i>
      <p>${discussionMap["time"]}</p>
    </div>
  </div>
  <div class="col-lg-4 col-md-4 col-sm-4 ${(currentBoxColorGrey) ? 'bg-grey' : ''}">
  <div class="${(currentBoxColorGrey) ? 'whitemaincolumn' : 'greymaincolumn'}">
      <h1>${discussionMap["admin"]}</h1>
      <h3>${discussionMap["subject"]}</h3>
    </div>
  </div>
  <div class="col-lg-4 col-xs-6 ${(currentBoxColorGrey) ? 'bg-grey' : ''}">
  <div class="${(currentBoxColorGrey) ? 'whitesidecolumn' : 'greysidecolumn'}">
      <i class="material-icons">explore</i>
      <p>Explore</p>
    </div>
  </div>
  </div>
  ''';
}

changeCurrentBoxColor(){
  if (currentBoxColorGrey){
    currentBoxColorGrey = false;
  }
  else {
    currentBoxColorGrey = true;
  }
}

String getNewRowContent(){
  String newContent = "";
  for (Discussion d in discussionsToDisplay){
    print("DISC: $d");
    newContent += getDiscussionHtml(d);
  }
  return newContent;
}

void setNewRowContent(){
  querySelector("#myRow").innerHtml = getNewRowContent();
}

bool foundAnyMatch(List<Discussion> matchingDiscussions){
  if (searchTerm == "" || matchingDiscussions.length == 0){
    return false;
  }
  return true;
}

void displayDiscussionsWithSearchTerm(){
  populateMatchingDiscussions();

  if (!foundAnyMatch(matchingDiscussions)){
    discussionsToDisplay = discussionsFromDb;
  }
  else {
    discussionsToDisplay = matchingDiscussions;
  }

  setNewRowContent();
  updateAmountOfMatches();
}

bool noMatchingDiscussions(matchAmount){
  return (matchAmount != 0) ? false : true;
}

bool foundMatchAtCurrentIndex(i){
  if (!discussionsFromDb[i].admin.contains(searchTerm) && !discussionsFromDb[i].category.contains(searchTerm) &&
      !discussionsFromDb[i].subject.contains(searchTerm)){
      return false;
  }
  return true;
}

void updateAmountOfMatches(){
  var outputField = querySelector(".amountofmatches");
  int matches = matchingDiscussions.length;
  if (searchTerm != "")
    outputField.innerHtml = (matches > 1) ? "$matches matches found" : "$matches match found";
  else
    outputField.innerHtml = "";
}

void populateMatchingDiscussions(){
  matchingDiscussions = [];
  List<Discussion> allDiscussions = GetEntryDiscussionsFromDb();
  for(int i = 0; i < allDiscussions.length; i++){
    if (foundMatchAtCurrentIndex(i)){
      matchingDiscussions.add(allDiscussions[i]);
    }
  }
}

void PopulateRow(){
  getNewRowContent();
  setNewRowContent();
}
