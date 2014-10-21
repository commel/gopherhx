package gopherhx;

import sys.net.Socket;
import sys.net.Host;
import gopherhx.Extensions;

using Extensions.StringExtender;

class GopherUrl {
  public var host:String;
  public var port:Int;
  public var path:String;

  public function new(url:String) {
    trace('url: $url');
    var r = new EReg("gopher://(.*):([0-9]{0,5})/(.*)","i");
    r.match(url);
    this.host = r.matched(1);
    this.port = Std.parseInt(r.matched(2));
    this.path = r.matched(3);

    trace(this);
  }
}

class Client {

  static inline var CR = 13;
  static inline var LF = 10;

  private var socket:Socket;
  private var gopherUrl:GopherUrl;

  public function new(url:String) {
    gopherUrl = new GopherUrl(url);

    connect(gopherUrl);
  }

  private function connect(url:GopherUrl) {
    socket = new Socket();
    socket.connect(new Host(url.host), url.port);
  }

  private function open(path:String):String {
    if (path.length > 0) {
      trace('opening $path');
      socket.output.writeString(path);
    } else {
      socket.output.writeByte(CR);
    }
    socket.output.writeByte(LF);
    
    socket.waitForRead();
    return socket.read();
  }

  public function getBody():String {
    return open(gopherUrl.path);
  }

  public function close() {
    socket.close();
  }

}
