import 'package:flutter/material.dart';
import 'package:machine_task_2/tab_view_items.dart';

class TabViewWidget extends StatelessWidget {
  const TabViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: SizedBox(
        // color: Colors.grey,
        // width: 338,
        height:  MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: 338,
              height: 47,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F9),
                borderRadius: BorderRadius.circular(23.5),
              ),
              child: const TabBar(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                // indicatorPadding: EdgeInsets.zero,
                isScrollable: false,
                // indicatorPadding: EdgeInsets.only(left: 5),
                // dragStartBehavior:DragStartBehavior.down ,
                //  isScrollable: true,
                dividerColor: Color(0xFFF1F1F9),
                // indicatorColor: Colors.amber,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(23.5)), // Creates border
                    color: Colors.white),
      
                tabs: [
                  Tab(
                      child: Center(
                    child: Text(
                      'Drivers',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF255FD5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
                  Tab(
                      child: Center(
                    child: Text(
                      'Retail Shops',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF255FD5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const TabViewItems()
          ],
        ),
      ),
    );
  }
}
