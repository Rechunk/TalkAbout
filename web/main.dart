// Copyright (c) 2017, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import "dart:core";
import "discussionSearch.dart";
import "uiFunctions.dart";
import "discussion_service.dart";

main() {
  GetEntryDiscussionsFromDb().then(init);

  querySelector("#menubar").onClick.listen((e) {
    openNavbar();
  });

  querySelector("#searchBtn").onClick.listen((e) {
    toggleSearchWindow();
    clearSearchbox();
  });

  querySelector("#hidenavbarBtn").onClick.listen((e) {
    closeNavbar();
    toggleSearchWindowIfOpened();
  });

  querySelector('#searchbox').onKeyUp.listen((KeyboardEvent e) {
    InputElement inputbox = querySelector("#searchfield");
    searchTerm = inputbox.value;
    displayDiscussionsWithSearchTerm();
  });
}
