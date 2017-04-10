import "dart:io";
import "dart:core";
import "package:rpc/rpc.dart";
import "Discussion.dart";
import "SingleComment.dart";

final ApiServer _apiServer = new ApiServer();

main() async {
  _apiServer.addApi(new DiscussionAPI());
  HttpServer server = await HttpServer.bind("127.0.0.1", 8082);
  server.listen(_apiServer.httpRequestHandler);
}

@ApiClass(
  name: 'discussionApi',
  version: 'v1',
)
class DiscussionAPI {
  @ApiMethod(method: "GET", path: 'getAllDiscussions')
  List<Discussion> getAllDiscussions() {
    return [
      new Discussion("SBob Gerner",new DateTime.now(), "Politics", "AAALorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor?", comments),
      new Discussion("Wayne Gerner",new DateTime.now(), "Fun", "AAALorem ipsum dolor sit asdas?", comments),
      new Discussion("Alice Bazz",new DateTime.now(), "Generic", "BBBing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ma?", comments),
      new Discussion("Tom Fedel",new DateTime.now(), "Tests", "BBBitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore maa rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lo?", comments),
      new Discussion("Dieter Boot",new DateTime.now(), "Lifestyle", "BBBto duo dolores et eing elit?", comments),
      new Discussion("Tom Fedel",new DateTime.now(), "Tests", "t vero eos et accusam?", comments)
    ];
  }
}

List<SingleComment> comments = [
  new SingleComment("Jake", new DateTime.now(), "This is such a boring topic..."),
  new SingleComment("Bob", new DateTime.now(), "Wow, I didn't except such a topic to come up here, lol!")
];
