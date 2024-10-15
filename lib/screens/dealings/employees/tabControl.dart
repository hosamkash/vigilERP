import 'package:flutter/material.dart';



class Tabcontrol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(),
        // body:ctr_TabBar(
        //   LstTabBarViewHeaderNames: [
        //     '111',
        //     '222',
        //   ],
        //   LstTabBarViewWidget: [
        //     Text('data'),
        //     IconButton(onPressed: (){}, icon: Icon(Icons.save)),
        //   ],
        // ) ,

    );
  }
}


// DefaultTabController(
// length: 4,
// child: Column(
// children: [
// TabBar(
// tabs: [
// Tab(text: 'Tab 1'),
// Tab(text: 'Tab 2'),
// Tab(text: 'Tab 3'),
// Tab(text: 'Tab 4'),
// ],
// ),
// Expanded(
// child: TabBarView(
// children: [
// Center(child: Text('Content for Tab 1')),
// Center(child: Text('Content for Tab 2')),
// Center(child: Text('Content for Tab 3')),
// Center(child: Text('Content for Tab 4')),
// ],
// ),
// ),
// ],
// ),
// )