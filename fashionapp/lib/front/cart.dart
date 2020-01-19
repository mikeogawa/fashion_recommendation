import 'package:flutter/material.dart';

class cartResult{

  static Row row(String title, String ref){
    return Row(
//        mainAxisAlignment: MainAxisAlignment.,
        children: <Widget>[
          SizedBox(
            height: 70.0,
            child: Image.network(
              'http://10.0.2.2:8000/myapp/image2/${ref}',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
                  '${title}'
                ),
            ),
        ]
    );
  }

  static Container container(String title, String image){
    return Container(
//            height: 120.0,
      padding: const EdgeInsets.all(30),
      width: 120.0,
      child: GestureDetector(
        onTap: () => {},
        child: row(title,image),
      ),
//            Center(child: Text('Entry ${entries[index]}')),
    );
  }

  static Dismissible dismissable(ShoppingData shoppingData, int index){
    return Dismissible(
        key: Key(shoppingData.carts[index]),
        onDismissed: (direction) {
          shoppingData.remove(index);
        },
        child: container(shoppingData.carts[index],shoppingData.images[index]),
    );
  }

  static ListView lists(ShoppingData shoppingData){
    return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: shoppingData.carts.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {

          return dismissable(shoppingData, index);
        }
    );
  }
}

class ShoppingData with ChangeNotifier{
  List<String> carts = [];
  List<String> images = [];

  void append(String image, String title){
    carts.add(title);
    images.add(image);
    notifyListeners();
  }

  void remove(int index){
    carts.removeAt(index);
    images.removeAt(index);
    notifyListeners();
  }
}

final shoppingData=ShoppingData();