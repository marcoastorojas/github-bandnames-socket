import 'package:flutter/material.dart';
import 'package:mi_segunda_aplicacion/providers/bandas_provider.dart';
import 'package:mi_segunda_aplicacion/providers/socket_provider.dart';
// import 'package:mi_segunda_aplicacion/providers/socket_provider.dart';
import 'package:mi_segunda_aplicacion/screens/home.dart';
import 'package:mi_segunda_aplicacion/screens/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BandaProvider()),
    ChangeNotifierProxyProvider<BandaProvider, SocketProvider>(
      create: (BuildContext context) => SocketProvider(),
      update: (_, bandaProvider, socketProvider) {
        socketProvider!.bandaProvider = bandaProvider;
        return socketProvider;
      },
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: 'routes',
      routes: {
        'home': (context) => const HomeScreen(),
        'routes': (context) => const RoutesScreen()
      },
    );
  }
}
