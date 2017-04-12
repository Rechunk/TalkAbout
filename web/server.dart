import "dart:io";
import "dart:core";
import "package:rpc/rpc.dart";
import "Discussion.dart";
import "SingleComment.dart";
import 'package:sqljocky/sqljocky.dart';

final ApiServer _apiServer = new ApiServer();
List<Discussion> allDiscussions = [
  new Discussion("SBob Gerner",new DateTime.now(), "Politics", "AAALorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor?", comments),
  new Discussion("Wayne Gerner",new DateTime.now(), "Fun", "AAALorem ipsum dolor sit asdas?", comments),
  new Discussion("Alice Bazz",new DateTime.now(), "Generic", "BBBing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ma?", comments),
  new Discussion("Tom Fedel",new DateTime.now(), "Tests", "BBBitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore maa rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lo?", comments),
  new Discussion("Dieter Boot",new DateTime.now(), "Lifestyle", "BBBto duo dolores et eing elit?", comments),
  new Discussion("Tom Fedel",new DateTime.now(), "Tests", "t vero eos et accusam?", comments)
];

var database = null;

void connectToDatabase(){
  database = new ConnectionPool(
    host: 'localhost', port: 3306,
    user: 'root', password: 'password',
    db: 'angularsite');
}

main() async {
  connectToDatabase();

  _apiServer.addApi(new DiscussionAPI());
  HttpServer server = await HttpServer.bind("127.0.0.1", 8082);
  server.listen(_apiServer.httpRequestHandler);
}

getAllDiscussionsFromDb() async {

  List<Discussion> discussions = [];

  List<Discussion> returnDiscussions(List<Discussion> disc){
    return discussions;
  }

  var results = await database.query("select * from discussions");
  return results.forEach((disc){
    discussions.add(new Discussion(disc[0], disc[1], disc[2], disc[3], comments));
  }).then(returnDiscussions);
}

@ApiClass(
  name: 'discussionApi',
  version: 'v1',
)
class DiscussionAPI {
  @ApiMethod(method: "GET", path: "getAllDiscussions")
  List<Discussion> getAllDiscussions() {
    return getAllDiscussionsFromDb();
  }

  @ApiMethod(method: "GET", path: "getMatchingDiscussions/{searchTerm}")
  List<Discussion> fetchMatchingDiscussions(String searchTerm){
    return getMatchingDiscussions(searchTerm);
  }
}

List<Discussion> getMatchingDiscussions(searchTerm){
  List<Discussion> matchingDiscussions = [];
  for(int i = 0; i < allDiscussions.length; i++){
    if (foundMatchAtCurrentIndex(i, searchTerm)){
      matchingDiscussions.add(allDiscussions[i]);
    }
  }
  return matchingDiscussions;
}

bool foundMatchAtCurrentIndex(int i, String searchTerm){
  if (!allDiscussions[i].admin.contains(searchTerm) && !allDiscussions[i].category.contains(searchTerm) &&
      !allDiscussions[i].subject.contains(searchTerm)){
      return false;
  }
  return true;
}

List<SingleComment> comments = [
  new SingleComment("Jake", new DateTime.now(), "This is such a boring topic..."),
  new SingleComment("Bob", new DateTime.now(), "Wow, I didn't except such a topic to come up here, lol!")
];
