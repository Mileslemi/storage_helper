// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:storage_helper/storage_helper.dart';

void main() {
  runApp(const MyApp());
}

// sensitive data should not be stored this way
class Data {
  String? name;
  String? email;
  Data({
    this.name,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(name: $name, email: $email)';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        storageHelper: StorageHelper(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key, required this.title, required this.storageHelper});

  final String title;
  final StorageHelper storageHelper;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  Data g = Data();

  @override
  void initState() {
    getLocalData();
    super.initState();
  }

  void getLocalData() async {
    Map<String, dynamic> y =
        await widget.storageHelper.readLocalJsonFile("data.json");
    g = Data.fromMap(y);
    controller.text = g.name ?? '';
    controller2.text = g.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Table(
              children: <TableRow>[
                TableRow(children: [
                  const Text("Names"),
                  TextFormField(
                    controller: controller,
                    onChanged: (s) {
                      g.name = s;
                    },
                  ),
                ]),
                TableRow(children: [
                  const Text("Email"),
                  TextFormField(
                    controller: controller2,
                    onChanged: (s) {
                      g.email = s;
                    },
                  ),
                ])
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  widget.storageHelper.writeToLocalJsonFile(
                    "data.json",
                    g.toMap(),
                  );
                },
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
