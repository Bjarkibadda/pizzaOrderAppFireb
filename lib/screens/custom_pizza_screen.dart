import 'dart:core';
import 'package:flutter/material.dart';
import 'package:food_order_app/Models/topic.dart';
import 'package:food_order_app/Providers/Order_cart_service.dart';
import 'package:food_order_app/Widgets/custom_app_bar.dart';
import 'package:food_order_app/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import '../Data/topics_list.dart';

class CustomPizza extends StatefulWidget {
  const CustomPizza({Key? key}) : super(key: key);

  @override
  _CustomPizzaState createState() => _CustomPizzaState();
}

class _CustomPizzaState extends State<CustomPizza> {
  late Future<List<Topic>> _fetchedTopics;
  List<bool> _boolList2 = [];
  late Future<int> _topicsCount;

  Future<List<Topic>> fetchTopics() async {
    var result = TopicsList().fetchTopics();
    _topicsCount = result.then((value) => value.length);
    _boolList2 = List<bool>.filled(await _topicsCount, false);
    return result;
  }

  // List<int> convertBoolToTopicId() {
  //   for (var i = 0; i >= _boolList2.length - 1; i++) {
  //     if (_boolList2[i] == true){
  //       topicsPickedList.add(_fetchedTopics[i]);
  //     } ;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _fetchedTopics = fetchTopics();
  }

  bool _isChecked = false;

  List<int> pickedTopics = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderChartService>(builder: (context, cartService, child) {
      return Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60), child: CustomAppBar()),
          body: Center(
            child: FutureBuilder<List<Topic>>(
                future: _fetchedTopics,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                              height: 200,
                              width: double.infinity - 10,
                              child: Card(
                                shadowColor: Colors.blueAccent,
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                    height: 8,
                                  ),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.4),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(23))),
                                      child: CheckboxListTile(
                                          title:
                                              Text(snapshot.data![index].name),
                                          value: _boolList2[index],
                                          onChanged: (value) {
                                            setState(() {
                                              _boolList2[index] = value!;
                                              if (value = true) {
                                                pickedTopics.add(
                                                    snapshot.data![index].id);
                                              } else {
                                                pickedTopics.remove(
                                                    snapshot.data![index].id);
                                              }
                                            });
                                          }),
                                    );
                                  },
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () =>
                              cartService.addCustomToChart(pickedTopics),
                          child: Container(
                            height: 15,
                            color: Colors.pink,
                            child: Text("Panta"),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.4),
                              border: Border(
                                  top: BorderSide(color: Colors.orange))),
                          height: 75,
                          padding: EdgeInsets.all(20),
                          //margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Row(
                            children: [Text('Verð')],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ));
    });
  }
}
