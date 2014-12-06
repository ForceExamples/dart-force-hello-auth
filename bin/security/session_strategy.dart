part of chat_example_force;

class SessionStrategy extends SecurityStrategy {
  
  bool checkAuthorization(req, List<String> roles, data) {
    /* HttpSession session = req.session;
    return (session["user"]!=null); */
    ForceMessageEvent fme = data;
    return (fme.profile != null && fme.profile["name"] != null);
  }   
  
  Uri getRedirectUri(HttpRequest req) {
    var referer = req.uri.toString();
    return Uri.parse("/login/?referer=$referer");
  }
}