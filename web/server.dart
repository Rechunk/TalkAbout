import "dart:io";
import "dart:core";
import "package:rpc/rpc.dart";
import "Discussion.dart";
import "SingleComment.dart";
import 'package:sqljocky/sqljocky.dart';

final ApiServer _apiServer = new ApiServer();
List<Discussion> allDiscussions = [];

var database = null;

main() async {
  database = new ConnectionPool(
    host: 'localhost', port: 3306,
    user: 'root', password: 'password',
    db: 'angularsite');

  _apiServer.addApi(new DiscussionAPI());
  HttpServer server = await HttpServer.bind("127.0.0.1", 8082);
  server.listen(_apiServer.httpRequestHandler);
}

getCommentsOfDiscussion(id) async {

  List<SingleComment> allComments = [];

  List<SingleComment> returnComments(var args) {
    return allComments;
  }

  var commentsFromDb = await database.query("select * from comments where discussionId = $id");
  // We have to instantiate actual SingleComment objects from the database columns
  return commentsFromDb.forEach((comment) async {
    allComments.add(new SingleComment(comment[0], comment[1], comment[2], comment[3]));
  }).then(returnComments);
}

getAllDiscussionsFromDb() async {

  List<Discussion> discussionsToReturn = [];

  var discussionsFromDb = await database.query("select * from discussions");
  // We have to instantiate actual discussion objects from the database columns
  await for(var discussion in discussionsFromDb) {
    int discussionId = discussion[4];
    var comments;
    comments = await getCommentsOfDiscussion(discussionId);
    discussionsToReturn.add(new Discussion(discussion[0], discussion[1], discussion[2], discussion[3], comments));
  }
  allDiscussions = discussionsToReturn;
  return discussionsToReturn;
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

String replaceEntityWithSpace(searchTerm){
  if (searchTerm.contains("%20")){
    searchTerm = searchTerm.replaceAllMapped(new RegExp(r'%20'), (match) {
      return ' ';
    });
  }
  return searchTerm;
}

bool foundMatchAtCurrentIndex(int i, String searchTerm){
  searchTerm = replaceEntityWithSpace(searchTerm);
  if (allDiscussions[i].admin.contains(searchTerm) || allDiscussions[i].category.contains(searchTerm) ||
      allDiscussions[i].subject.contains(searchTerm)){
      return true;
  }
  return false;
}
