import 'package:flutter/material.dart';
import 'package:hello/login.dart';
import 'package:hello/news.dart';
import 'package:hello/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(body: Home()),
              routes: {
                // "/": (context) => Home(),
                '/login': (context) => Login() ,
                '/register': (context) => Register() ,
                '/news': (context) => News() ,
              });
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[700],
          title: Center(child: Text("USAMA NEWS")),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/5357363/pexels-photo-5357363.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  fit: BoxFit.fitWidth)),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/9469733/pexels-photo-9469733.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  radius: 100,
                ),
                SizedBox(
                  height: 120,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text("SIGN UP"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.pink),
                      padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 20))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>Login()));
                  },
                  child: Text("SIGN IN"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                      padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 20))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                   onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>News()));
                  },
                  child: Text("NEWS"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 20))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
