import 'package:flutter/material.dart';
import 'front/scroller.dart';
import 'front/cart.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'dart:convert';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Demo: Test'),
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
  List<String> cart=[];
  List<String> images=[];
  List<num> userdata=[3,3,3];
  String recID="0";
  final cartData = shoppingData;


  void _incrementCounter(String image, String title) {
    setState(() {
      cart.add(title);
      images.add(image);
    });
  }

  void _update(){
    setState(() {
    });
  }

  @override
  void initState(){
    cartData.addListener(_update);
    front.futureRecommend(userdata).then((res){
      setState(() {
        Map<String,dynamic> result = json.decode(res.body);
        recID = result["idx"];
        print(recID);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true ,
        title: Text(widget.title),
        backgroundColor: Color(0xFF333333),
      ),
      body:Stack(
       children: <Widget>[
         front.lists(context,userdata),
         front.recommendBar(context,recID,userdata),
       ],
      ),
      endDrawer: Drawer(
        child: cartResult.lists(cartData)
      ),
    );
  }
}
