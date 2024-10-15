import 'package:flutter/material.dart';

class ctr_TabBar extends StatelessWidget {
  // List<String>? LstTabBarViewHeaderNames;
  List<Widget>? LstTabBarViewHeaderWidget;
  List<Widget>? LstTabBarViewWidget;

  ctr_TabBar({
    // this.LstTabBarViewHeaderNames,
    this.LstTabBarViewHeaderWidget,
    this.LstTabBarViewWidget,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: LstTabBarViewHeaderWidget!.length,
      child: Column(
        children: [
          TabBar(
            tabs: buildTabBarNames(),
          ),
          Expanded(
            child: TabBarView(
              children: LstTabBarViewWidget!,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildTabBarNames() {
    List<Widget> tabBars = [];

    for (int i = 0; i < LstTabBarViewHeaderWidget!.length; i++) {
      tabBars.add(
        Tab(
          // text: LstTabBarViewNames![i],
          // child: Text( LstTabBarViewHeaderNames![i] ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 14),),
          child: LstTabBarViewHeaderWidget![i],
        ),
      );
    }
    return tabBars;
  }
}
