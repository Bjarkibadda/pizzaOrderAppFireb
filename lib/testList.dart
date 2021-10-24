import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:food_order_app/main.dart';

class MyList {}

class TestList extends StatelessWidget {
  Widget build(BuildContext context) {
    var myList = ['Pizza', 'Hamburger', 'Meat', 'Sandwich'];
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: ListView(
        // <Widget> is the type of items in the list.
        children: <Widget>[
          ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: myList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  child: Center(child: Text('Entry ${myList[index]}')),
                );
              })
        ],
        // Expanded expands its child
        // to fill the available space.
      ),
    );
  }
}
