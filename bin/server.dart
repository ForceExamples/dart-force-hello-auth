library chat_example_force;

import 'dart:async';
import 'dart:io';
import 'package:logging/logging.dart' show Logger, Level, LogRecord;
import 'package:force/force_serverside.dart';
import 'package:force/force_common.dart';
import 'package:forcemvc/force_mvc.dart';

part 'security/session_strategy.dart';

final Logger log = new Logger('ChatApp');

void main() {
  // Set up logger.
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  
  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? 8080 : int.parse(portEnv);
  var serveClient = portEnv == null ? true : false;
    
  // Create a force server
  ForceServer fs = new ForceServer(port: port, 
                                     clientFiles: '../build/web/',
                                     clientServe: serveClient);
  
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
