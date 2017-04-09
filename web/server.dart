import "dart:io";
import "dart:core";

main() async {
  HttpServer server = await HttpServer.bind("127.0.0.1", 8082);
  print("Server started on port ${server.port}...");

  await for (HttpRequest request in server){
    handleRequest(request);
  }
}

handleRequest(request){
  try {
    if (request.method == "GET"){
      print("hi");
    }
  } catch (e){
    print(e.toString());
  }
}

handlePost(request) async {
  print("got it");
}
