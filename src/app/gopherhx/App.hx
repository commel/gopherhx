package gopherhx;

import gopherhx.Client.*;

class App {
  static function main() {
    Sys.print( new Client(validate(Sys.args())).getBody() );
  }

  static function validate(args:Array<String>) {
    if (args.length != 1) {
      throw "usage: gopher://host:port/path";
    }

    return args[0];
  }

}
