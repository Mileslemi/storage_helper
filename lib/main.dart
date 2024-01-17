import 'package:flutter/material.dart';
import 'package:storage_helper/storage_helper.dart';

void main() {
  runApp(const MyApp());
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

  @override
  void initState() {
    getLocalData();
    super.initState();
  }

  void getLocalData() async {
    Map y = await widget.storageHelper.readLocalJsonFile("data.json");
    // print(y); // {name: Lemi, email: mileslemi@gmail.com}
    if (y.containsKey("name") && y.containsKey("email")) {
      controller.text = y['name'];
      controller2.text = y['email'];
    } else {
      // write these keys and default values to the file
      widget.storageHelper.writeToLocalJsonFile(
          "data.json", {"name": "Lemi", "email": "mileslemi@gmail.com"});
    }
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
                  ),
                ]),
                TableRow(children: [
                  const Text("Email"),
                  TextFormField(
                    controller: controller2,
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
                onPressed: () {},
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
