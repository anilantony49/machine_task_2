import 'package:flutter/material.dart';
import 'package:machine_task_2/retail_shop_screen.dart';

import 'package:machine_task_2/user_sign_in/driver_list_screen.dart';

class TabViewItems extends StatefulWidget {
  const TabViewItems({super.key});

  @override
  State<TabViewItems> createState() => _TabViewItemsState();
}



class _TabViewItemsState extends State<TabViewItems> {


  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TabBarView(
        children: [
          Column(
            children: [
              DriverListScreen(
               
              ),
            ],
          ),
          RetailShopScreen(
          
          ),
          // Icon(Icons.directions_car, size: 350),
        ],
      ),
    );
  }
}
