import 'dart:io';

class Connection{
  static const defaultHost = 'mrmyyesterday.com';
  static const defaultPort = 5000;
  
  Socket socket;
  String host;
  int port;
  Connection({this.host = Connection.defaultHost, this.port = Connection.defaultPort});

  bool isConnected(){
    if(socket == null){
      return false;
    }
    return true;
  }

  bool subscribe({Function onData, Function onDone}){
    if(this.isConnected()){
      this.socket.listen(
        onData,
        onDone: onDone
      );
      return true;
    }else{
      return false;
    }
  }

  void connectToServer({
    Function onData, 
    Function onDone
  }) async {
    // Socket.connect(this.host, this.port).then((socket) {
    //   this.socket = socket;
    //   this.socket.listen(onData, onDone: (){
    //     onDone();
    //     this.socket.destroy();
    //     this.socket = null;
    //   });
    // });
    Socket futureSocket = await Socket.connect(this.host, this.port);
    this.socket = futureSocket;
    this.socket.listen(onData, onDone: (){
        onDone();
        this.socket.destroy();
        this.socket = null;    
    });
  } 
}
