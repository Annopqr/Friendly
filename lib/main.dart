import 'package:flutter/material.dart';
import 'package:testapp/firebase_options.dart';
import 'package:testapp/screen/like_screen.dart';
import 'package:testapp/screen/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testapp/screen/search_screen.dart';
import 'screen/home_screen.dart';
import 'widget/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Mylogin(),
    );
  }
}

class _MyAppState extends State<MyApp> {
  late TabController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Friendly",
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
          colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              SearchScreen(),
              LikeScreen(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}

//login기능 구현
class Mylogin extends StatelessWidget{
  const Mylogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Authentication(),
    );
  }
}

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return SignInScreen(
            providerConfigs: [
              EmailProviderConfiguration()
            ],
          );
        }
        return HomeScreen();
      },
    );
  }
}
