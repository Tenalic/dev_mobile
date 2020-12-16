import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title : 'route',
     initialRoute: '/',
      routes:{
        '/' : (context) => MyApp(),
        '/lastScreen': (context) => LastPage(),
      },
  ));

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   /* return MaterialApp(
      title: 'First screen',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'FirstScreen'),
    );*/
    return Scaffold(
      appBar : AppBar(
        title: Text('Launch Screen'),
      ),
      body: Center(
        child:ElevatedButton(
          child:Text('Go lastPage'),
         onPressed: (){
           Navigator.pushNamed(context,'/lastScreen');
         },
        ),
      ),
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
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
      
        title: Text(widget.title),
      ),
      body: Center(
       child: new RaisedButton(
            onPressed: () {Navigator.pushNamed(context, '/lastScreen');},
            child:Text("Appuyer"),
        ),
      ),
    );
}
  void pressed() {
  setState() {
    print("demarage page");
  }
}

}

class LastPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*return MaterialApp(
      title: 'lastPage',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyLastPage(title: 'Page de confirmation'),
    );*/
     return Scaffold(
      appBar : AppBar(
        title: Text('Launch Screen'),
      ),
      body: Center(
        child:ElevatedButton(
          child:Text('Go home'),
         onPressed: (){
           Navigator.pop(context);
         },
        ),
      ),
    );
  }
}

class MyLastPage extends StatefulWidget {
  MyLastPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyLastPageState createState() => _MyLastPageState();
}

class _MyLastPageState extends State<MyLastPage> {
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
      
        title: Text(widget.title),
      ),
      body: Center(
       child: new RaisedButton(
            onPressed: () {Navigator.pop(context);},
            child:Text("retour au menu"),
        ),
      ),
    );
} 
}
