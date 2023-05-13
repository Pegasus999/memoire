import 'package:rayto/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  _loadingPage() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimeFreak',
      theme: ThemeData.dark().copyWith(),
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Allo',
        theme: ThemeData(fontFamily: 'Inter'),
        home: const Scaffold(
          body: SplashScreen(),
        ));
  }
}
