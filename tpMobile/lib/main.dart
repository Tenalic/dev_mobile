import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Delivecrous'),
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

  List productList = List();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    productList.add(new Product("Zelda breath of the wild", 50, 0,
        "images/zbotw-switch.jpg", "Switch"));
    productList.add(
        new Product("Ghost of Tsushima", 50, 1, "images/gos-ps4.jpg", "PS4"));
    productList
        .add(new Product("Fifa 21", 70, 2, "images/f21-xbox.jpg", "Xbox"));
    productList.add(new Product("Taiko no Tatsujin Drum'n'Fun!", 40, 3,
        "images/tnt-switch.jpg", "switch"));
    productList.add(
        new Product("Marvel's Spider-Man", 20, 4, "images/msp-ps4.jpg", "PS4"));
    productList.add(new Product(
        "Baten Kaitos : Les Ailes éternelles et l'Océan perdu",
        50,
        5,
        "images/bk-gamecube.jpg",
        "GameCube"));
    productList.add(new Product(
        "Pokemon rubis", 40, 6, "images/pvr-gba.jpg", "GameBoyAdvance"));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Icon(Icons.shopping_cart),
        ],
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
            Positioned(
                right: 0,
                top: 0,
                child: Checkbox(
                  value: false,
                  onChanged: (bool value) {
                    value = !value;
                  },
                ))
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
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
