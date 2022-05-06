import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api/api_future_builder.dart';
import 'package:flutter_api/user_modal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ApiFutureBuilder(),
    );
  }
}

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);
  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  List<Item> users = [];

  getData() async {
    var response = await rootBundle.loadString("/catalog.json");
    var data = jsonDecode(response)["products"];

    Modal.items =
        List.from(data).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
    // for (var i in data) {
    //   Item user = Item(
    //       id: i["id"], userName: i["name"], desc: i["desc"], price: i["price"]);
    //   users.add(user);
    // }
    // return users;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: Modal.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            horizontalTitleGap: 0,
            title: Text(Modal.items[index].name.toString()),
            subtitle: Text(Modal.items[index].desc.toString()),
            isThreeLine: true,
            leading: Text(
              Modal.items[index].id.toString(),
              style: const TextStyle(fontSize: 30),
            ),
          );
        },
      ),
    );
  }
}
