import 'package:flutter/material.dart';
import '../Widgets/custom_app_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBar()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const MenuButtons(text: "Pizzur á matseðli", route: '/menu'),
          const MenuButtons(text: "Do Your own!", route: '/custom')
        ],
      ),
    );
  }
}

class MenuButtons extends StatelessWidget {
  const MenuButtons({
    Key? key,
    required this.text,
    required this.route,
  }) : super(key: key);

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, route),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orange)),
            child: Align(
                alignment: Alignment.center,
                child: Text(text, textAlign: TextAlign.center)),
          ),
        ),
      ),
    );
  }
}
