import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/masterPages/scr_DealingsTools.dart';
import '../../screens/masterPages/scr_DefinitionsTools.dart';
import '../../screens/masterPages/scr_FinancialTools.dart';
import '../../screens/masterPages/scr_HRTools.dart';
import '../../screens/masterPages/scr_RepresentsTools.dart';
import '../../screens/masterPages/scr_StocksTools.dart';
import 'cubitStates.dart';


class cubitGeneral extends Cubit<cubitStates> {
  cubitGeneral() : super(state_InitialApp());

  static late cubitGeneral instance;

  static cubitGeneral get(BuildContext context) {
    instance = BlocProvider.of(context);
    return instance;
  }

//****************** On Boarding Page ***************************
  static int indexPage = 0;

  changePageIndex(int index) {
    indexPage = index;
    emit(state_BordingIndexChanged());
  }

  //****************** On Boarding Page ***************************
  static int tabIndex = 0;
  static Widget selectedTab = scr_RepresentsTools();
  List<Widget> LstTabs = [
    scr_RepresentsTools(),
    scr_FinancialTools(),
    scr_StocksTools(),
    scr_HRTools(),
    scr_DealingsTools(),
    scr_DefinitionsTools(),
  ];

  Widget selectedTabChaned(int index) {
    tabIndex = index;
    selectedTab = LstTabs[tabIndex];
    emit(state_TabIndexChanged());
    return selectedTab;
  }

  //
  // //**************************** requestStatus ********************************
  // List<Fix_RequestStatus> lst_requestStatus = [];
  // List<DropDowenDataSource> lstrequestStatusAsDataSource = [];
  //
  // Future getList_requestStatus() async {
  //   try {
  //     lst_requestStatus.clear();
  //     lst_requestStatus = await bllFix_RequestStatus.fire_getList();
  //     emit(requestStatus_StateChanged(lst_requestStatus ,lstrequestStatusAsDataSource ));
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }
  //
  // Future getLst_requestStatusAsDataSource() async {
  //   lstrequestStatusAsDataSource.clear();
  //   if (bllFix_RequestStatus.lstFix_RequestStatus.length == 0) {
  //     await getList_requestStatus();
  //   }
  //   for (var item in bllFix_RequestStatus.lstFix_RequestStatus) {
  //     lstrequestStatusAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
  //   }
  // }
  //
  // String getNameByID(int? ID) {
  //   String ret = '';
  //   if (bllFix_RequestStatus.lstFix_RequestStatus.isNotEmpty && ID != null) {
  //     ret = bllFix_RequestStatus.lstFix_RequestStatus.firstWhere((elm) {
  //       return elm.ID == ID;
  //     }).Name!;
  //   }
  //   return ret;
  // }

}


