import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:i_tortani_v_2_0/Screens/Spese/SpeseScreen.dart';

import 'Screens/Tortani/TortaniScreen.dart';
import 'Utils/API/Spese/SpeseAPIUser.dart';
import 'Utils/API/Tortani/TortaniAPIUser.dart';
import 'Utils/DB/Spese/SpeseDBUser.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {

  if (kDebugMode) {
    HttpOverrides.global = new MyHttpOverrides();
  }

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
                                        try{
                                          SpeseAPIUser.deleteAllSpese();
                                        }catch(e){
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Errore'),
                                                  content: Text('C\'è stato un problema nella cancellazione delle spese, controlla la connessione internet e riprova.\n Errore: ${e.toString()}'),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('Capito'),
                                                      onPressed: () => Navigator.of(context).pop(),
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
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
                                        try{
                                          await TortaniAPIUser.deleteAllTortani();
                                          Navigator.of(context).pop();
                                        }catch(e){
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Errore'),
                                                  content: Text('C\'è stato un problema nella cancellazione dei tortani, controlla la connessione internet e riprova.\n Errore: ${e.toString()}'),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('Capito'),
                                                      onPressed: () => Navigator.of(context).pop(),
                                                    ),
                                                  ],
                                                );
                                              });
                                          Navigator.of(context).pop();
                                        }

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
