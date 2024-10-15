import 'package:flutter/material.dart';
import 'package:vigil_erp/shared/shared_controls.dart';


class scr_Chat extends StatelessWidget {
  scr_Chat({super.key});

  var gridController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: sharedControls.buildMainMenu(context),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Text('شات ومحادثات' , style:  TextStyle(fontSize: 50 , fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }


}
