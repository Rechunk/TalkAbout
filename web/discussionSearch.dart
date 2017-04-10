import 'dart:html';
import "discussion_service.dart";
import "Discussion.dart";

List<Discussion> discussionsFromDb = [];
List<Discussion> discussionsToDisplay = [];
List<Discussion> matchingDiscussions = [];
String searchTerm;
bool currentBoxColorGrey = true;

List<Discussion> sampleList = [
  new Discussion("SBob Gerner", new DateTime.now(), "Politics", "AAALorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor?", comments),
  new Discussion("Wayne Gerner", new DateTime.now(), "Fun", "AAALorem ipsum dolor sit asdas?", comments),
  new Discussion("Alice Bazz", new DateTime.now(), "Generic", "BBBing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ma?", comments),
  new Discussion("Tom Fedel", new DateTime.now(), "Tests", "BBBitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore maa rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lo?", comments),
  new Discussion("Dieter Boot", new DateTime.now(), "Lifestyle", "BBBto duo dolores et eing elit?", comments),
  new Discussion("Tom Fedel", new DateTime.now(), "Tests", "t vero eos et accusam?", comments)
];

List<Discussion> removeKeyFromJsonList(var allDiscussions){
  List<Discussion> converted = [];
  for (var d in allDiscussions){
    converted.add(new Discussion(d["admin"], d["time"], d["category"], d["subject"], d["comments"]));
  }
  return converted;
}

populateAndDisplayDiscussionList(var allDiscussions) {
  discussionsFromDb = removeKeyFromJsonList(allDiscussions);
  discussionsToDisplay = discussionsFromDb;
  setNewRowContent();
}

void setNewRowContent(){
  querySelector("#myRow").innerHtml = getNewRowContent();
}

String getNewRowContent(){
  String newContent = "";
  for (Discussion d in discussionsToDisplay){
    newContent += getDiscussionHtml(d);
  }
  return newContent;
}

String getDiscussionHtml(Discussion d){
  changeCurrentBoxColor();
  return '''
  <div class="row ${(currentBoxColorGrey) ? 'bg-grey' : ''}">
  <div class="col-lg-4 col-md-4 col-sm-4 hidden-xs">
    <div class="${(currentBoxColorGrey) ? 'whitesidecolumn' : 'greysidecolumn'}">
      <i class="material-icons">access_time</i>
      <p>${d.time}</p>
    </div>
  </div>
  <div class="col-lg-4 col-md-4 col-sm-4 ${(currentBoxColorGrey) ? 'bg-grey' : ''}">
  <div class="${(currentBoxColorGrey) ? 'whitemaincolumn' : 'greymaincolumn'}">
      <h1>${d.admin}</h1>
      <h3>${d.subject}</h3>
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

void changeCurrentBoxColor(){
  if (currentBoxColorGrey){
    currentBoxColorGrey = false;
  }
  else {
    currentBoxColorGrey = true;
  }
}

bool foundAnyMatch(List<Discussion> matchingDiscussions){
  if (searchTerm == "" || matchingDiscussions.length == 0){
    return false;
  }
  return true;
}

void displayAllDiscussions(){
  discussionsToDisplay = discussionsFromDb;
  print(discussionsFromDb);
  setNewRowContent();
}

void displayDiscussionsWithSearchTerm(){
  serviceSetupMatchingDiscussions();

  discussionsToDisplay = matchingDiscussions;

  setNewRowContent();
}

bool noMatchingDiscussions(matchAmount){
  return (matchAmount != 0) ? false : true;
}

void updateAmountOfMatches(){
  var outputField = querySelector(".amountofmatches");
  int matches = matchingDiscussions.length;
  if (searchTerm != "")
    outputField.innerHtml = (matches > 1) ? "$matches matches found" : "$matches match found";
  else
    outputField.innerHtml = "";
}
