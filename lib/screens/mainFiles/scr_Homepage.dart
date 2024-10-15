import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/blocManagment/general/cubitGeneral.dart';
import 'package:vigil_erp/shared/sharedDesigne.dart';
import 'package:vigil_erp/shared/sharedFunctions.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

class scr_Homepage extends StatelessWidget {
  scr_Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: cubitGeneral.instance,
      listener: (context, state) => {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'مكة ستار',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    sharedFunctions_Social.openWhatsApp('201004232647');
                  },
                  icon: const Icon(Icons.chat)),
              IconButton(
                  onPressed: () {
                    sharedControls.openFacebookGroup();
                  },
                  icon: Icon(Icons.facebook)),
              IconButton(
                  onPressed: () {
                    sharedControls.openAnyApp('Udemy');
                  },
                  icon: Icon(Icons.computer)),
            ],
          ),
          drawer: sharedControls.buildMainMenu(context),
          body: cubitGeneral.selectedTab,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubitGeneral.tabIndex,
            backgroundColor: Colors.white,
            elevation: 10,
            iconSize: 25,
            selectedItemColor: sharedDesigne.primaryColor,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
            onTap: (val) async {
              cubitGeneral.instance.selectedTabChaned(val);


            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: 'المندوبين'),
              BottomNavigationBarItem(icon: Icon(Icons.monetization_on_outlined), label: 'الماليات'),
              BottomNavigationBarItem(icon: Icon(Icons.local_grocery_store_outlined), label: 'المخازن'),
              BottomNavigationBarItem(icon: Icon(Icons.hail_rounded), label: 'HR'),
              BottomNavigationBarItem(icon: Icon(Icons.person_search), label: 'الجهات'),
              BottomNavigationBarItem(icon: Icon(Icons.note_add_outlined), label: 'التعريفات'),
            ],
          ),
        );
      },
    );
  }


}
