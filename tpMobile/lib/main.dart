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

/// Page principale
class _MyHomePageState extends State<MyHomePage> {
  List productList = List();

  List checkedList = List();

  Panier panier = Panier();

  void _checked(int index, bool value) {
    setState(() {
      checkedList[index] = value;
      if (value == true) {
        panier.listeProduct.add(productList[index]);
        panier.prix = panier.prix + productList[index].prix;
      } else {
        panier.listeProduct.remove(productList[index]);
        panier.prix = panier.prix - productList[index].prix;
      }
    });
  }

  void _updateChecked(int index, bool value) {
    setState(() {
      checkedList[index] = value;
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
                  onTap: () async {
                    Panier _panier = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailsProduit(productList[index], panier);
                    }));
                    if (_panier != null) {
                      panier = _panier;
                      _updateChecked(productList[index].id,
                          panier.listeProduct.contains(productList[index]));
                    }
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

///Page panier
class PanierPage extends StatelessWidget {
  Panier panier;

  Panier panierToBuy;

  List<bool> panierToBuyBool;

  PanierPage(Panier panier) {
    this.panier = panier;
    panierToBuy = panier;
    panierToBuyBool = List();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < panier.listeProduct.length; i++) {
      panierToBuyBool.add(true);
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            Stack(children: <Widget>[
              Icon(Icons.shopping_cart),
              Text(panier.listeProduct.length.toString())
            ])
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Text('Panier :'),
          ListView.builder(
              shrinkWrap: true,
              itemCount: panier.listeProduct.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: <Widget>[
                    Image.asset(
                      panier.listeProduct[index].image,
                      width: 140,
                      height: 140,
                    ),
                    Positioned(
                        top: 10,
                        left: 150,
                        child: Text(panier.listeProduct[index].name)),
                    Positioned(
                        top: 30,
                        left: 150,
                        child: Text(panier.listeProduct[index].console)),
                    Positioned(
                        top: 50,
                        left: 150,
                        child: Text(
                            panier.listeProduct[index].prix.toString() + ' €')),
                    Positioned(
                        right: 0,
                        top: 50,
                        child: Checkbox(
                          value: panierToBuyBool[index],
                          onChanged: (value) {
                            panierToBuyBool[index] = value;
                            if (value == true) {
                              panierToBuy.listeProduct
                                  .add(panier.listeProduct[index]);
                              panierToBuy.prix = panierToBuy.prix +
                                  panier.listeProduct[index].prix;
                            } else {
                              if (panierToBuy.listeProduct
                                      .remove(panier.listeProduct[index]) ==
                                  true) {
                                panierToBuy.prix = panierToBuy.prix -
                                    panier.listeProduct[index].prix;
                              }
                            }
                          },
                        )),
                  ],
                );
              }),
          Text('total : ' + panierToBuy.prix.toString() + ' €'),
          Text('Ou veux-tu te faire livrer ?'),
          Text('En salle de TD ?'),
          TextFormField(
            decoration: InputDecoration(labelText: 'Rue'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Ville'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Code Postal'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LastPage();
              }));
            },
            child: Text('Passer commande'),
          ),
        ])));
  }
}

/// Page details
class DetailsProduit extends StatelessWidget {
  Product product;

  Panier panier;

  bool _value;

  DetailsProduit(Product product, Panier panier) {
    this.product = product;
    this.panier = panier;
  }

  @override
  Widget build(BuildContext context) {
    _value = panier.listeProduct.contains(product);

    return Scaffold(
      appBar: AppBar(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              product.image, // 'images/tnt-switch.jpg',
              fit: BoxFit.cover, // this is the solution for border
            ),
            Text(
              'Jeu : ' + product.name,
            ),
            Text('Console : ' + product.console),
            Text('Prix : ' + product.prix.toString() + '€'),
            Checkbox(
              value: _value,
              onChanged: (value) {
                _value = value;
                if (value == true) {
                  panier.listeProduct.add(product);
                  panier.prix = panier.prix + product.prix;
                } else {
                  if (panier.listeProduct.remove(product) == true) {
                    panier.prix = panier.prix - product.prix;
                  }
                }
                Navigator.pop(context, panier);
              },
            )
          ],
        ),
      ),
    );
  }
}

class LastPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar : AppBar(
        title: Text('Merci d\'avoir commandé'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
        Image(image: AssetImage('images/merci.jpg')),
         Text('solde sur votre compte: 15€59', style: TextStyle(color: Colors.grey)),
         ElevatedButton(
          child: Text('Retour au menu principal'),
         onPressed: (){
           Navigator.popUntil(context,ModalRoute.withName('/'));
         },
        ),
        ],
        
      ),
      
      );
  }
}
