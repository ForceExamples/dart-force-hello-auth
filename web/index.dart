import 'dart:async';
import 'dart:html';

import 'package:force/force_browser.dart';

void main() {
  ForceClient forceClient = new ForceClient();
  forceClient.connect();
  
  int count = 0;
  
  AnchorElement element = querySelector("#foo");
  element.onClick.listen((e) {
    count++;
    forceClient.send('count', {"count" : count, "foo" : "hello"} );
  });
  
  AnchorElement secElement = querySelector("#secure");
  secElement.onClick.listen((e) {
      count++;
      forceClient.send('secure', {"count" : count, "secure" : "hello"} );
    });
  
  AnchorElement loginElement = querySelector("#login");
  loginElement.onClick.listen((e) {
       count++;
       var profileInfo = { 'name' : 'login'};
       forceClient.initProfileInfo(profileInfo);
     });
  
  
  
  forceClient.on("notifications", (e, sender) {
    var json = e.json;
    print("received $json");
  });
  
  forceClient.on("unauthorized", (e, sender) {
      var json = e.json;
      print("unauthorized $json");
    });
}
