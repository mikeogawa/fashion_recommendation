import 'package:flutter/material.dart';
import 'recommender.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class front{

  static List<String> entries = <String>[
    'Black Shirt',
    'White Shirt',
    'Red Shirt',
    'Yellow Shirt',
    'Blue Shirt',
    'Green Shirt'];

  Widget image(){
    return Image.network(
      'http://10.0.2.2:8000/myapp/image',
    );

  }

  static Column column(String ref, String title){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            'http://10.0.2.2:8000/myapp/image/0/${ref}',
          ),
          Text(
              '${title}'
          ),
        ]
    );
  }

  static Container container(BuildContext context, int index, List<num> userdata){
    return Container(
//            height: 120.0,
        padding: const EdgeInsets.all(30),
          width: 120.0,
          child: GestureDetector(
            onTap: () => {rec.tapped(context,"${index}",entries[index],userdata)},
            child: column("${index}",entries[index]),
          )
    );
  }

  static ListView lists(BuildContext context, List<num> userdata){
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: entries.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {

          return container(context, index, userdata);
        }
    );
  }

  static Future<http.Response> futureRecommend(List<num> userdata) async{
    List<num> tot = userdata+[0,0,0,0,0,0]+[0,0,0,0,0,0];
    final joined = tot.join(",");
    final masked = [1,1,1,1,1,1].join(",");
    String url = "http://10.0.2.2:8000/myapp/nn/0?params=${joined}&mask=${masked}";
    http.Response resp = await http.get(url);
    print(resp.body);
    return resp;
  }

  static Positioned recommendBar(BuildContext context, String idx, List<num> userdata) {


    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: GestureDetector(
          onTap: () => rec.popup(context,idx,entries[int.parse(idx)],userdata),
          child: Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              alignment: Alignment.centerRight,
              child:Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          'Today`s Recommendation:'
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                      child: Image.network(
                        'http://10.0.2.2:8000/myapp/image/0/${idx}',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          entries[int.parse(idx)]
                      ),
                    ),
                  ]
              )

          ),
        ),
    );
  }
}