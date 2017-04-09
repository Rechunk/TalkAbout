import "dart:html";

var navbar = querySelector("#navbar");
var menubar = querySelector("#menubar");
var searchWindow = querySelector("#searchwindow");
var searchBox = querySelector("#searchbox");
bool searchOpened = false;

void toggleSearchWindow(){
  if (!searchOpened){
    searchWindow.classes.remove("searchwindowdisappear");
    searchWindow.classes.add("searchwindowappear");
    searchBox.classes.remove("searchboxhide");
    searchBox.classes.add("searchboxshow");
    searchOpened = true;
  }
  else if (searchOpened){
    searchBox.classes.remove("searchboxshow");
    searchBox.classes.add("searchboxhide");
    searchWindow.classes.remove("searchwindowappear");
    searchWindow.classes.add("searchwindowdisappear");
    searchOpened = false;
  }
}

void toggleSearchWindowIfOpened(){
  if (searchOpened)
    toggleSearchWindow();
}

void openNavbar(){
  menubar.classes.remove("menubarappear");
  menubar.classes.add("menubardisappear");
  navbar.classes.remove("navdisappear");
  navbar.classes.add("navappear");
}

void closeNavbar(){
  menubar.classes.remove("menubardisappear");
  menubar.classes.add("menubarappear");
  navbar.classes.remove("navappear");
  navbar.classes.add("navdisappear");
}
