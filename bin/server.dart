library chat_example_force;

import 'dart:io';
import 'package:force/force_serverside.dart';
import 'package:force/force_common.dart';
import 'package:forcemvc/force_mvc.dart';

part 'security/session_strategy.dart';

void main() {
  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? 8080 : int.parse(portEnv);
  var serveClient = portEnv == null ? true : false;
    
  // Create a force server
  ForceServer fs = new ForceServer(port: port, 
                                     clientFiles: '../build/web/',
                                     clientServe: serveClient);
  
  // Setup logger
  fs.setupConsoleLog();
  // Setup session strategy
  fs.server.strategy = new SessionStrategy();
    
  fs.on('count', (e, sendable) { 
    sendable.send('notifications', e.json);
  });
  
  fs.on('secure', (e, sendable) { 
      sendable.send('notifications', e.json);
    }, authentication: true);
  
  fs.start();
}
