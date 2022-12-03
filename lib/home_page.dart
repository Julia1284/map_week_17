import 'package:flutter/material.dart';
import 'package:map_week_17/main.dart';
import 'package:map_week_17/map_page.dart';
import 'package:map_week_17/models/position.dart';
import 'package:map_week_17/objectbox.g.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Position> positions;
  late Box<Position> positionBox;
  deletePosition(id) {
    positionBox.remove(id);
    setState(() {
      positions = positionBox.getAll();
    });
  }

  @override
  void initState() {
    super.initState();
    positions = objectBox.store.box<Position>().getAll();
    positionBox = objectBox.store.box<Position>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List of Positions'),
          centerTitle: true,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            columnSpacing: 10,
            columns: [
              const DataColumn(
                label: Text('Latitude'),
              ),
              const DataColumn(
                label: Text('Longitude'),
              ),
              DataColumn(label: Container()),
              DataColumn(label: Container())
            ],
            rows: positions.map((position) {
              return DataRow(cells: [
                DataCell(
                  Text(position.latitude.toString()),
                ),
                DataCell(
                  Text(position.longitude.toString()),
                ),
                DataCell(
                  const Icon(Icons.delete),
                  onTap: () {
                    deletePosition(position.id);
                  },
                ),
                DataCell(
                  const Icon(Icons.route_outlined),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapPage(position)));
                  },
                )
              ]);
            }).toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/mappage');
          },
          child: const Text('+'),
        ),
      ),
    );
  }
}
