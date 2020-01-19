import 'package:fashionapp/front/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class rec{
  static List<String> entries = <String>[
    'Black Pants',
    'White Pants',
    'Red Pants',
    'Yellow Pants',
    'Blue Pants',
    'Green Pants'];

  static Future<http.Response> futureRecommend(String idx, List<num> userdata, List<num> masks) async{

    List<num> shio = [0,0,0,0,0,0];
    shio[int.parse(idx)]=1;
    List<num> tot = userdata+shio+[0,0,0,0,0,0];

    final joined = tot.join(",");
    final maskJoined = masks.join(",");
    String url = "http://10.0.2.2:8000/myapp/nn/0?params=${joined}&masks=${maskJoined}";
    http.Response resp = await http.get(url);
    return resp;
  }

  static void tapped(BuildContext context, String idx, String title, List<num> userdata){
    print("tappped");
    Scaffold.of(context).openEndDrawer();
    popup(context, idx, title, userdata);
  }

  static void popup(BuildContext context, String idx, String title, List<num> userdata){
    futureRecommend(idx,userdata,[1,1,1,1,1,1]).then((res){

      Map<String,dynamic> result = json.decode(res.body);

      shoppingData.append(idx,title);

      showDialog(
          context: context,
          builder: (context) {

            String mode = "1";
            String id = result["idx"];
            String title = entries[int.parse(id)];
            List<num> mask = [1,1,1,1,1,1];

            print(id);
            print("${mask.join(',')}");

            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: new Center(child:Text("Recommended")),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Image.network(
                          'http://10.0.2.2:8000/myapp/image/${mode}/${id}',
                        ),
                        Center(
                          child: Container(
                            color:Color(0x11111111),
                            width:140,
                            height: 30,
                            child: Center(
                              child: Text(title+" 00:00"),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                              child: Text("Cancel"),
                              onPressed: () => {
                                Navigator.pop(context),
                              },
                            ),
                            FlatButton(
                              child: Text("Next"),
                              onPressed: () => {
                                  mask[int.parse(id)] = 0,
                                  futureRecommend(id,userdata,mask).then((res){
                                    Map <String,dynamic> result2 = json.decode(res.body);
                                    setState(() => {
                                    id = result2["idx"],
                                    title = entries[int.parse(id)],
                                    });
                                  }),
                                print("in the hole"),
                              },
                            ),
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () => {
                                shoppingData.append("b"+id,title),
                                Navigator.pop(context),
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
      );
    });
  }

}