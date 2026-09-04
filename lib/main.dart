import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'auth_page/sign_in.dart';
import 'providers/movie_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignInPage(),
    );
  }
}
