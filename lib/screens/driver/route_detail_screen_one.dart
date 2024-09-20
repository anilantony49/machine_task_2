import 'package:flutter/material.dart';
import 'package:machine_task_2/models/route.dart';
import 'package:machine_task_2/screens/driver/route_detail_screen_two.dart';
import 'package:machine_task_2/utils/alerts_and_navigate.dart';

class RouteDetailScreenOne extends StatelessWidget {
  final RouteModels route;

  const RouteDetailScreenOne({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Route Details'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: route.stores.isEmpty
            ? const Center(
                child: Text(
                  'No assigned route',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Route Name: ${route.name}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Driver: ${route.driver.name}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Stores:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...route.stores.map(
                    (store) => Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                nextScreen(
                                  context,
                                  RouteDetailScreenTwo(
                                    storeName: store.name,
                                    storeAddress: store.address,
                                  ),
                                );
                              },
                              child: Text(
                                store.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(
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
