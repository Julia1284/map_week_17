import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_week_17/home_page.dart';
import 'package:map_week_17/map_page.dart';
import 'package:map_week_17/models/position.dart';
import 'package:map_week_17/models/positions_repository.dart';
import 'package:map_week_17/objectbox.g.dart';

const googleApiKey = "AIzaSyBYd-LooZL8Tdxgp4gmqN67s03-Q0rM4-w";
late ObjectBox objectBox;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<Position> positions;
  late Box<Position> positionBox;
  Position unknownPosition = Position(
    id: 0,
    latitude: 0,
    longitude: 0,
  );

  @override
  void initState() {
    super.initState();
    //получаем все позиции из  store
    positions = objectBox.store.box<Position>().getAll();
    // инициализируем positionbox
    positionBox = objectBox.store.box<Position>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const HomePage(),
          '/mappage': (context) => MapPage(unknownPosition)
        });
  }
}
