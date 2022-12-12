import 'package:flutter/material.dart';
import 'package:i_tortani_v_2_0/Screens/Spese/SpeseScreen.dart';
import 'package:i_tortani_v_2_0/Utils/DB/Tortani/TortaniDBUser.dart';

import 'Screens/Tortani/TortaniScreen.dart';
import 'Utils/DB/Spese/SpeseDBUser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        "/Tortani": (BuildContext context) => new TortaniScreen(),
      },
      title: 'iTortani',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'iTortani'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController controller = new PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("iTortani"),
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: [
          Card(
            child: Stack(
              children: [
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SpeseScreen())),
                  child: Center(
                    child: Text("Spese",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
                Positioned(
                  child: FloatingActionButton(
                      child: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Cancellazione Spese'),
                                content: Text(
                                    'Sei sicuro di voler cancellare tutti i dati sulle spese? L\'operazione non può essere annullata.'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        SpeseDbUser.deleteAllSpese();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('SI')),
                                  TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('NO',
                                          style:
                                              TextStyle(color: Colors.white))),
                                ],
                              );
                            });
                      }),
                  left: MediaQuery.of(context).size.width / 1.3,
                  top: MediaQuery.of(context).size.height / 1.3,
                ),
              ],
            ),
          ),
          Card(
            child: Stack(
              children: [
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TortaniScreen())),
                  child: Center(
                    child: Text("Tortani",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
                Positioned(
                  child: FloatingActionButton(
                      child: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Cancellazione Tortani'),
                                content: Text(
                                    'Sei sicuro di voler cancellare tutti i dati sui tortani? L\'operazione non può essere annullata.'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        await TortaniDBUser.deleteAllTortani();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('SI')),
                                  TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('NO',
                                          style:
                                              TextStyle(color: Colors.white))),
                                ],
                              );
                            });
                      }),
                  left: MediaQuery.of(context).size.width / 1.3,
                  top: MediaQuery.of(context).size.height / 1.3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
