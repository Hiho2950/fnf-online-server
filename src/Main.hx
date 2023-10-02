package;

import networking.Network;
import networking.sessions.Session;
import networking.utils.NetworkEvent;
import networking.utils.NetworkMode;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.MouseEvent;

class Main extends Sprite {
  public var connectedDevices:Int = 0;
  public function new() {
    super();
      runServer();
  }

  private function runServer() {
    var server = Network.registerSession(NetworkMode.SERVER, { ip: '0.0.0.0', port: 8888, max_connections: 2 });

    server.addEventListener(NetworkEvent.MESSAGE_RECEIVED, function(e: NetworkEvent) {
      if (e.data.verb == "noteHit") {
        server.send({verb: "noteHit", note: e.data.note});
      }
      if (e.data.verb == "connected") {
        connectedDevices += 1;
        server.send(verb: "connectStatus", connctedClients: connectedDevices});
      }
    }
    server.start();
  }
}
