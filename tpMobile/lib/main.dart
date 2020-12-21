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

/**
 * Page principale
 */
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List productList = List();

  List checkedList = List();

  Panier panier = Panier();

  void _checked(int index, bool value) {
    setState(() {
      checkedList[index] = value;
      if (value == true) {
        panier.listeProduct.add(productList[index]);
      } else {
        panier.listeProduct.remove(productList[index]);
      }
    });
  }

  void _initListCheked(int taille) {
    for (int i = 0; i < taille; i++) {
      checkedList.add(false);
    }
  }

  void _initListProduct() {
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
  }

  @override
  Widget build(BuildContext context) {
    if (productList.length == 0) {
      _initListProduct();
      _initListCheked(productList.length);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Stack(children: <Widget>[
            IconButton(
                icon: new Icon(Icons.shopping_cart),
                onPressed: () {
                  if (panier.listeProduct.length > 0) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PanierPage(panier);
                    }));
                  }
                }),
            Text(panier.listeProduct.length.toString())
          ])
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
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailsProduit(productList[index]);
                    }));
                  },
                  child: Image(image: AssetImage(productList[index].image))),
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
                  value: checkedList[index],
                  onChanged: (bool value) {
                    _checked(index, value);
                  },
                ))
          ]);
        },
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

class Panier {
  double prix;
  List<Product> listeProduct;

  Panier() {
    this.prix = 0;
    this.listeProduct = List();
  }
}

/**
 * Page panier
 */
class PanierPage extends StatelessWidget {
  Panier panier;

  PanierPage(Panier panier) {
    this.panier = panier;
  }

  @override
  Widget build(BuildContext context) {
    int _counter = 0;

    void _incrementCounter() {}

    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(children: <Widget>[
            IconButton(icon: new Icon(Icons.shopping_cart), onPressed: () {}),
          ])
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print("toutch");
              }, // handle your image tap here
              child: Image.asset(
                panier.listeProduct[0].image, // 'images/tnt-switch.jpg',
                fit: BoxFit.cover, // this is the solution for border
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

/**
 * Page details
 */
class DetailsProduit extends StatelessWidget {
  Product product;

  DetailsProduit(Product product) {
    this.product = product;
  }

  @override
  Widget build(BuildContext context) {
    int _counter = 0;

    void _incrementCounter() {}

    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(children: <Widget>[
            IconButton(icon: new Icon(Icons.shopping_cart), onPressed: () {}),
          ])
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              product.image, // 'images/tnt-switch.jpg',
              fit: BoxFit.cover, // this is the solution for border
            ),
            Text(
              product.name,
            ),
            Text(product.console),
            Text(product.prix.toString() + '€')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
