import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigil_erp/blocManagment/blocConnectivity/connectivity_bloc.dart';
import 'package:vigil_erp/blocManagment/general/cubitGeneral.dart';
import 'package:vigil_erp/screens/MasterPages/scr_DefinitionsTools.dart';
import 'package:vigil_erp/screens/MasterPages/scr_FinancialTools.dart';
import 'package:vigil_erp/screens/MasterPages/scr_RepresentsTools.dart';
import 'package:vigil_erp/screens/MasterPages/scr_StocksTools.dart';
import 'package:vigil_erp/screens/mainFiles/barPages/scr_AccountSettings.dart';
import 'package:vigil_erp/screens/mainFiles/barPages/scr_Chat.dart';
import 'package:vigil_erp/screens/mainFiles/barPages/scr_Offers.dart';
import 'package:vigil_erp/screens/mainFiles/barPages/scr_SettingsApp.dart';
import 'package:vigil_erp/screens/mainFiles/barPages/scr_Shop.dart';
import 'package:vigil_erp/screens/mainFiles/barPages/scr_Social.dart';
import 'package:vigil_erp/screens/masterPages/scr_DealingsTools.dart';
import 'package:vigil_erp/screens/masterPages/scr_HRTools.dart';
import 'package:vigil_erp/screens/masterPages/scr_InvoicesTools.dart';
import 'package:vigil_erp/screens/masterPages/scr_SettingsTools.dart';
import 'package:vigil_erp/shared/sharedDesigne.dart';
import 'package:vigil_erp/shared/shared_controls.dart';

class scr_HomepageSlider extends StatefulWidget {
  scr_HomepageSlider({super.key});

  @override
  State<scr_HomepageSlider> createState() => _scr_HomepageSliderState();
}

class _scr_HomepageSliderState extends State<scr_HomepageSlider> {
  var pageController = PageController();

  List<Widget> LstPagesView = [
    scr_DefinitionsTools(),
    scr_DealingsTools(),
    scr_StocksTools(),
    scr_FinancialTools(),
    scr_InvoicesTools(),
    scr_RepresentsTools(),
    scr_HRTools(),
    scr_SettingsTools(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: cubitGeneral.instance,
      listener: (context, state) => {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: BlocBuilder<connectivity_Bloc, connectivity_State>(
                  builder: (context, state) {
                    if (state is connected_State) {
                      sharedControls.toastNotification(state.message, true);
                      return  const Row(
                        children: [
                           Text('مكة ستار', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black)),
                           Text(' - متصل', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.green)),
                        ],
                      );
                    } else if (state is notConnected_State) {
                      sharedControls.toastNotification(state.message, false);
                      return const Row(
                        children: [
                           Text('مكة ستار', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red)),
                          Text(' - غير متصل', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.red)),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              // IconButton(
              //     onPressed: () {
              //       sharedFunctions_Social.openWhatsApp('201004232647');
              //     },
              //     icon: const Icon(Icons.chat)),
              // IconButton(
              //     onPressed: () {
              //       sharedControls.openFacebookGroup();
              //     },
              //     icon: Icon(Icons.facebook)),
            ],
          ),
          drawer: sharedControls.buildMainMenu(context),
          body: PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 8,
            controller: pageController,
            onPageChanged: (index) {
              print(index);
            },
            itemBuilder: (context, index) {
              return Container(
                color: Colors.red,
                child: LstPagesView[index],
              );
              //buildPageItem(context);
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubitGeneral.tabIndex,
            backgroundColor: Colors.white,
            elevation: 10,
            iconSize: 25,
            selectedItemColor: sharedDesigne.primaryColor,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
            onTap: (index) async {
              // cubitGeneral.objCubit.selectedTabChaned(val);
              if (index == 0) {
                sharedControls.navigatTo(context, scr_Social());
              } else if (index == 1) {
                sharedControls.navigatTo(context, scr_Chat());
              } else if (index == 2) {
                sharedControls.navigatTo(context, scr_Offers());
              } else if (index == 3) {
                sharedControls.navigatTo(context, scr_Shop());
              } else if (index == 4) {
                sharedControls.navigatTo(context, scr_AccountSettings());
              } else if (index == 5) {
                sharedControls.navigatTo(context, scr_SettingsApp());
              }
            },
            items: const [
              // BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: 'المندوبين'),
              BottomNavigationBarItem(icon: Icon(Icons.facebook), label: 'سوشيال'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'شات'),
              BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'العروض'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded), label: 'مكة شوب'),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'المستخدم'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
            ],
          ),
        );
      },
    );
  }
}
