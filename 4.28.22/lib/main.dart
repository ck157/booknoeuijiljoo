import 'package:booknoejilju/bookclub_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'Lobby.dart';
import 'LoginPage.dart';
import 'Splash.dart';
import 'Writing.dart';
import 'auth_service.dart';
import 'book_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // main 함수에서 async 사용하기 위함
  await Firebase.initializeApp(); // firebase 앱 시작
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: ((context) => ClubService())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF000000),
      ),
      debugShowCheckedModeBanner: false,
      home: user == null ? SplashPage() : LobbyPage(),
    );
  }
}
