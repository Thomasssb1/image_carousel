import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'non_luminance.dart';
import 'luminance.dart';

void main() {
  runApp(const MyApp());
}

final router = GoRouter(initialLocation: "/", routes: [
  GoRoute(path: "/", builder: (context, state) => const Home()),
  GoRoute(
      path: "/non_luminance",
      builder: (context, state) => const NonLuminance()),
  GoRoute(
    path: "/luminance",
    builder: (context, state) => const Luminance(),
  )
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
            onTap: () {
              context.push("/non_luminance");
            },
            child: Ink(
                child: Container(
                    padding: EdgeInsets.all(30),
                    color: Colors.blueAccent,
                    child: Text("Non Luminance example",
                        style: TextStyle(fontSize: 20))))),
        InkWell(
            onTap: () {
              context.push("/luminance");
            },
            child: Ink(
                child: Container(
                    padding: EdgeInsets.all(30),
                    color: Colors.blueAccent,
                    child: Text("Luminance example",
                        style: TextStyle(fontSize: 20)))))
      ],
    )));
  }
}
