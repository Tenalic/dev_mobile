import 'package:flutter/material.dart';
import 'dart:collection';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Catalogue'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List productList = List();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var product1 = new Product(
        "Zelda breath of the wild", 50, 0, "images/zbotw-switch.jpg", "Switch");
    var product2 =
        new Product("Ghost of Tsushima", 50, 1, "images/gos-ps4.jpg", "PS4");
    var product3 = new Product("Fifa 21", 70, 2, "images/f21-xbox.jpg", "Xbox");
    var product4 = new Product("Taiko no Tatsujin Drum'n'Fun!", 40, 3,
        "images/tnt-switch.jpg", "switch");
    var product5 =
        new Product("Marvel's Spider-Man", 20, 4, "images/msp-ps4.jpg", "PS4");
    var product6 = new Product(
        "Baten Kaitos : Les Ailes éternelles et l'Océan perdu",
        50,
        5,
        "images/bk-gamecube.jpg",
        "GameCube");
    var product7 = new Product(
        "Pokemon rubis", 40, 6, "images/pvr-gba.jpg", "GameBoyAdvance");

    productList.add(product1);
    productList.add(product2);
    productList.add(product3);
    productList.add(product4);
    productList.add(product5);
    productList.add(product6);
    productList.add(product7);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.builder(
        itemCount: productList.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext ctx, int index) {
          return Stack(children: <Widget>[
            Positioned(
              height: 140,
              width: 140,
              child: Image(image: AssetImage(productList[index].image)),
            ),
            Positioned(bottom: 0, child: Text(productList[index].name)),
            Positioned(
                bottom: 20, child: Text(productList[index].prix.toString())),
            Positioned(
              bottom: 40,
              child: Text(productList[index].console),
            ),
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Product {
  String name;
  double prix;
  int id;
  String image;
  String console;

  Product(String name, double prix, int id, String image, String console) {
    this.name = name;
    this.prix = prix;
    this.id = id;
    this.image = image;
    this.console = console;
  }
}
