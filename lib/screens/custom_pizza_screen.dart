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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppBar()),
        body: Center(
          child: FutureBuilder<List<Topic>>(
              future: TopicsList().fetchTopics(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                      height: 200,
                      width: double.infinity - 10,
                      child: Card(
                        shadowColor: Colors.blueAccent,
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            height: 60,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(snapshot.data![index].name);
                          },
                        ),
                      ));
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ));
  }
}
