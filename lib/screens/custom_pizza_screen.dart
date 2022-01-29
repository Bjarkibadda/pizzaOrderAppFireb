import 'package:flutter/material.dart';
import 'package:food_order_app/Models/topic.dart';
import 'package:food_order_app/Widgets/custom_app_bar.dart';
import '../Data/topics_list.dart';

class CustomPizza extends StatefulWidget {
  const CustomPizza({Key? key}) : super(key: key);

  @override
  _CustomPizzaState createState() => _CustomPizzaState();
}

class _CustomPizzaState extends State<CustomPizza> {
  bool _isChecked = false;
  var boolList = List<bool>.filled(100, false);
  // væri best að hafa þetta jafn langan lista og topicin eru! en ef hann er initilaizaður í buildinu þá overridast alltaf þegar kallað er á setstate

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppBar()),
        body: Center(
          child: FutureBuilder<List<Topic>>(
              future: TopicsList().fetchTopics(),
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
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(23))),
                                    child: CheckboxListTile(
                                        title: Text(snapshot.data![index].name),
                                        value: boolList[index],
                                        onChanged: (value) {
                                          setState(() {
                                            boolList[index] = value!;
                                          });
                                        }),
                                  );
                                  // Container(
                                  //     padding:
                                  //         EdgeInsets.fromLTRB(10, 0, 14, 4),
                                  //     decoration: BoxDecoration(
                                  //         color: Colors.orange.withOpacity(0.4),
                                  //         borderRadius: BorderRadius.all(
                                  //             Radius.circular(23))),
                                  //     height: 29,
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         Text(snapshot.data![index].name),
                                  //       ],
                                  //     ));
                                },
                              ),
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.4),
                            border:
                                Border(top: BorderSide(color: Colors.orange))),
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
  }
}
