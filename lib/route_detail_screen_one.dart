import 'package:flutter/material.dart';
import 'package:machine_task_2/models/route.dart';
import 'package:machine_task_2/route_detail_screen_two.dart';

class RouteDetailScreenOne extends StatefulWidget {
  final RouteModels route;

  const RouteDetailScreenOne({super.key, required this.route});

  @override
  State<RouteDetailScreenOne> createState() => _RouteDetailScreenOneState();
}

class _RouteDetailScreenOneState extends State<RouteDetailScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Route Details'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Route Name: ${widget.route.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Driver: ${widget.route.driver.name}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Stores:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...widget.route.stores.map(
              (store) => Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RouteDetailScreenTwo(
                                storeName: store.name,
                                storeAddress: store.address,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          store.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(store.address)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
