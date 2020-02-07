import 'package:flutter/material.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:torch/torch.dart';
import  'package:flutter_socket_io/flutter_socket_io.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INTEV Torch App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'INTEV Torch App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _connected = false;
  bool _isFlashOn = false;

  SocketIO socketIO;

  @override
  void initState() {
    _connectSocket();
    super.initState();
  }

  _connectSocket() {
    //update your domain before using
    //socketIO = new SocketIO("http://127.0.0.1:3000", "/",

    socketIO = SocketIOManager().createSocketIO("http://10.0.2.2:3000", "/");

    //call init socket before doing anything
    socketIO.init();

    //subscribe event
    socketIO.subscribe("toggle", _onSocketInfo);

    //connect socket
    socketIO.connect();

    socketIO.getId();

    setState(() {
      _connected = true;
    });

  }

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

  _onSocketInfo(dynamic data) {
    print("Socket info: " + data);
  }

  _subscriptions() {
    if (socketIO != null) {
      socketIO.subscribe("toggle", _onToggle);
    }
  }

  void _onToggle(dynamic message) {
    print("Message from SocketIO: " + message);
    _isFlashOn = true;
  }

  void _disconnect(){
    //disconnect socket
    socketIO.connect();
    print("Disconnecting");
    setState(() {
      _connected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _connected == true ?

        RaisedButton(
          onPressed: _disconnect,
          child: Text(
              'Disconnect',
              style: TextStyle(fontSize: 20)
          ),

        )

                  : // Text == true
            Text(
              'Not Connected'
            ), // Text == false
            _isFlashOn == true ?
            Text(
              'Flash is On',
            ) : // Text == true
            Text(
                'Flash is Off'
            ), // Text == false

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _connectSocket,
        tooltip: 'Connect to Server',
        child: Icon(Icons.cast_connected),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
