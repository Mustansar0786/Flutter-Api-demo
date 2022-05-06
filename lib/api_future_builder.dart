import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api/user_modal.dart';

class ApiFutureBuilder extends StatefulWidget {
  const ApiFutureBuilder({Key? key}) : super(key: key);
  @override
  State<ApiFutureBuilder> createState() => _ApiFutureBuilderState();
}

class _ApiFutureBuilderState extends State<ApiFutureBuilder> {
  List<Item> users = [];

  getData() async {
    var response = await rootBundle.loadString("/catalog.json");
    var data = jsonDecode(response)["products"];
    for (var i in data) {
      Item user = Item(
          id: i["id"], name: i["name"], desc: i["desc"], price: i["price"]);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Loading...",
                    style: TextStyle(fontSize: 24),
                  )
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].name),
                  leading: Text(
                    users[index].id.toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                  subtitle: Text(users[index].desc),
                  trailing: Text(
                    "\$" + users[index].price.toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
