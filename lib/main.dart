import 'package:flutter/material.dart';
import 'package:major_project/screens/splash_screen.dart';
import 'package:major_project/widgets/prompt_form.dart';
import './models/item_list.dart';
import 'models/item_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GAN',
      theme: ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? chosenValue;
  String? imageSource;
  Items? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GAN'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton(
                  hint: const Text('Select Model'),
                  value: chosenValue,
                  onChanged: (newValue) {
                    setState(() {
                      chosenValue = newValue.toString();
                    });
                    item = items.singleWhere(
                        (element) => element.itemName == chosenValue);
                  },
                  items: items.map((element) {
                    return DropdownMenuItem(
                        value: element.itemName,
                        child: Text(
                          element.itemName,
                        ));
                  }).toList(),
                ),
                PromptForm(item, imageSource, chosenValue),
              ]),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.red,
              child: const Center(
                child: Text(
                  "Text To Image Generation",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.only(left: 10),
              child: ListView(
                children: const [
                  Text("1. Musab Shaikh", style: TextStyle(fontSize: 15)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('2. Harsh Sawaji', style: TextStyle(fontSize: 15)),
                  SizedBox(
                    height: 10,
                  ),
                  Text("3. Aayush Shah", style: TextStyle(fontSize: 15))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
