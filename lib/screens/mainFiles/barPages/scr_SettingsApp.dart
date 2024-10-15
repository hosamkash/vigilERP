import 'package:flutter/material.dart';
import 'package:vigil_erp/componants/ctr_TabBar.dart';
import 'package:vigil_erp/screens/settings/scr_SettingDefaulsValue.dart';
import 'package:vigil_erp/shared/shared_controls.dart';


class scr_SettingsApp extends StatelessWidget {
  scr_SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: sharedControls.buildMainMenu(context),
      body:  ctr_TabBar(
        LstTabBarViewHeaderWidget: [
          Text('Fixed'),
          // '*****',
          // '+++++',
          // '-----',
        ],
        LstTabBarViewWidget: [
          scr_SettingDefaulsValue(false),
          // Text('data'),
          // Text('data'),
          // Text('data'),
        ],
      ) ,


    );
  }


}
