import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final box = Hive.box('myBox');

  void saveData() {
    String name = controller.text;
    box.put('name', name);
    setState(() {});
    controller.clear();
  }

  void deleteData() {
    box.delete('name');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String? savedName = box.get('name');

    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Example"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter your name",
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveData,
              child: Text("Save"),
            ),

            SizedBox(height: 20),

            Text(
              savedName != null
                  ? "Saved Name: $savedName"
                  : "No data found",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: deleteData,
              child: Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}