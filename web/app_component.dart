// Copyright (c) 2017, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import "dart:core";
import "Discussion.dart";
import "SingleComment.dart";
import "discussion_service.dart";
import "dart:html";

class AppComponent {

  String title = "Discussion section";
  bool searchOpened = false;
  var searchBox = null;
  var searchWindow = null;
  int amountOfMatches = 0;
  String searchTerm = "";

  List<Discussion> discussionsToDisplay = GetEntryDiscussionsFromDb();
  List<Discussion> discussionsFromDb = GetEntryDiscussionsFromDb();


  onSubmit(form){
    String url = "http://localhost:8082/getit";
    HttpRequest.getString(url).then(onDataLoaded);
  }

  void onDataLoaded(String responseText) {
    var jsonString = responseText;
    print(jsonString);
  }

  onSelect(var menubar, var navbar){
    menubar.classes.remove("menubarappear");
    menubar.classes.add("menubardisappear");
    navbar.classes.remove("navdisappear");
    navbar.classes.add("navappear");
  }

  closeNavbar(var menubar, var navbar){
    if (searchOpened){
      toggleSearchWindow(searchWindow, searchBox);
    }
    menubar.classes.remove("menubardisappear");
    menubar.classes.add("menubarappear");
    navbar.classes.remove("navappear");
    navbar.classes.add("navdisappear");
  }

  toggleSearchWindow(var searchwindow, var searchbox){
    if (searchWindow == null && searchBox == null){
      searchWindow = searchwindow;
      searchBox = searchbox;
    }
    if (!searchOpened){
      searchwindow.classes.remove("searchwindowdisappear");
      searchwindow.classes.add("searchwindowappear");
      searchbox.classes.remove("searchboxhide");
      searchbox.classes.add("searchboxshow");
      searchOpened = true;
    }
    else if (searchOpened){
      searchbox.classes.remove("searchboxshow");
      searchbox.classes.add("searchboxhide");
      searchwindow.classes.remove("searchwindowappear");
      searchwindow.classes.add("searchwindowdisappear");
      searchOpened = false;
    }

  }

  
}

List<SingleComment> comments = [
  new SingleComment("Jake", new DateTime.now(), "This is such a boring topic..."),
  new SingleComment("Bob", new DateTime.now(), "Wow, I didn't except such a topic to come up here, lol!")
];
