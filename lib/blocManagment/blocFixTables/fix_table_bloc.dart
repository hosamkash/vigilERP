import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bll/bllFirebase/ManageBLL.dart';
import '../../bll/bllFirebase/bllFix_Address_City.dart';
import '../../bll/bllFirebase/bllFix_Address_DistrictArea.dart';
import '../../bll/bllFirebase/bllFix_Address_Government.dart';
import '../../bll/bllFirebase/bllFix_BalanceType.dart';
import '../../bll/bllFirebase/bllFix_Gender.dart';
import '../../bll/bllFirebase/bllFix_MaritalStatus.dart';
import '../../bll/bllFirebase/bllFix_MilitaryStatus.dart';
import '../../bll/bllFirebase/bllFix_PriceType.dart';
import '../../bll/bllFirebase/bllFix_Religions.dart';
import '../../bll/bllFirebase/bllFix_RequestStatus.dart';
import '../../bll/classModel/Fix_Address_City.dart';
import '../../bll/classModel/Fix_Address_DistrictArea.dart';
import '../../bll/classModel/Fix_Address_Government.dart';
import '../../bll/classModel/Fix_BalanceType.dart';
import '../../bll/classModel/Fix_Gender.dart';
import '../../bll/classModel/Fix_MaritalStatus.dart';
import '../../bll/classModel/Fix_MilitaryStatus.dart';
import '../../bll/classModel/Fix_PriceType.dart';
import '../../bll/classModel/Fix_Religions.dart';
import '../../bll/classModel/Fix_RequestStatus.dart';
import '../../componants/ctr_DropDowenList.dart';
import '../../shared/enumerators.dart';

part 'fixTable_event.dart';

part 'fixTable_state.dart';

class priceType_bloc extends Bloc<fixTable_event, fixTable_state> {
  static late priceType_bloc instance;

  static priceType_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<priceType_bloc>(context);
    return instance;
  }

  List<Fix_PriceType> lst_PriceType = [];
  List<DropDowenDataSource> lstPriceTypeAsDataSource = [];

  Future getList_PriceType() async {
    try {
      lst_PriceType.clear();
      lst_PriceType = await bllFix_PriceType.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  Future getLst_PriceTypeAsDataSource() async {
    lstPriceTypeAsDataSource.clear();
    if (bllFix_PriceType.lstFix_PriceType.length == 0) await bllFix_PriceType.fire_getList();
    for (var item in bllFix_PriceType.lstFix_PriceType) {
      lstPriceTypeAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllFix_PriceType.lstFix_PriceType.isNotEmpty && ID != null) {
      ret = bllFix_PriceType.lstFix_PriceType.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  priceType_bloc() : super(priceType_StateInitial()) {
    on<fixTable_event>((event, emit) async {
      if (event is getListPriceType_Event) {
        await getList_PriceType();
        emit(getListPriceType_State(lst_PriceType: lst_PriceType));
      }
    });
  }
}

class balanceType_bloc extends Bloc<fixTable_event, fixTable_state> {
  static late balanceType_bloc instance;

  static balanceType_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<balanceType_bloc>(context);
    return instance;
  }

  List<Fix_BalanceType> lst_balanceType = [];
  List<DropDowenDataSource> lstBalanceTypeAsDataSource = [];

  Future getList_balanceType() async {
    try {
      lst_balanceType.clear();
      lst_balanceType = await bllFix_BalanceType.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  Future getLst_balanceTypeAsDataSource() async {
    lstBalanceTypeAsDataSource.clear();
    if (bllFix_BalanceType.lstFix_BalanceType.length == 0) await bllFix_BalanceType.fire_getList();
    for (var item in bllFix_BalanceType.lstFix_BalanceType) {
      lstBalanceTypeAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllFix_BalanceType.lstFix_BalanceType.isNotEmpty && ID != null) {
      ret = bllFix_BalanceType.lstFix_BalanceType.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  balanceType_bloc() : super(balanceType_StateInitial()) {
    on<fixTable_event>((event, emit) async {
      if (event is getListBalanceType_Event) {
        await getList_balanceType();
        emit(getListBalanceType_State(lst_BalanceType: lst_balanceType));
      }
    });
  }
}

class maritalStatus_bloc extends Bloc<fixTable_event, fixTable_state> {
  static late maritalStatus_bloc instance;

  static maritalStatus_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<maritalStatus_bloc>(context);
    return instance;
  }

  List<Fix_MaritalStatus> lst_MaritalStatus = [];
  List<DropDowenDataSource> lstMaritalStatusAsDataSource = [];

  Future getList_MaritalStatus() async {
    try {
      lst_MaritalStatus.clear();
      lst_MaritalStatus = await bllFix_MaritalStatus.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  Future getLst_MaritalStatusAsDataSource() async {
    lstMaritalStatusAsDataSource.clear();
    if (bllFix_MaritalStatus.lstFix_MaritalStatus.length == 0) {
      await bllFix_MaritalStatus.fire_getList();
    }
    for (var item in bllFix_MaritalStatus.lstFix_MaritalStatus) {
      lstMaritalStatusAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllFix_MaritalStatus.lstFix_MaritalStatus.isNotEmpty && ID != null) {
      ret = bllFix_MaritalStatus.lstFix_MaritalStatus.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  maritalStatus_bloc() : super(maritalStatus_StateInitial()) {
    on<fixTable_event>((event, emit) async {
      if (event is getListMaritalStatus_Event) {
        await getList_MaritalStatus();
        emit(getListMaritalStatus_State(lst_MaritalStatus: lst_MaritalStatus));
      }
    });
  }
}

class militaryStatus_bloc extends Bloc<fixTable_event, fixTable_state> {
  static late militaryStatus_bloc instance;

  static militaryStatus_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<militaryStatus_bloc>(context);
    return instance;
  }

  List<Fix_MilitaryStatus> lst_militaryStatus = [];
  List<DropDowenDataSource> lstmilitaryStatusAsDataSource = [];

  Future getList_militaryStatus() async {
    try {
      lst_militaryStatus.clear();
      lst_militaryStatus = await bllFix_MilitaryStatus.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  Future getLst_militaryStatusAsDataSource() async {
    lstmilitaryStatusAsDataSource.clear();
    if (bllFix_MilitaryStatus.lstFix_MilitaryStatus.length == 0) await bllFix_MilitaryStatus.fire_getList();
    for (var item in bllFix_MilitaryStatus.lstFix_MilitaryStatus) {
      lstmilitaryStatusAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllFix_MilitaryStatus.lstFix_MilitaryStatus.isNotEmpty && ID != null) {
      ret = bllFix_MilitaryStatus.lstFix_MilitaryStatus.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  militaryStatus_bloc() : super(militaryStatus_StateInitial()) {
    on<fixTable_event>((event, emit) async {
      if (event is getListMilitaryStatus_Event) {
        await getList_militaryStatus();
        emit(getListMilitaryStatus_State(lst_MilitaryStatus: lst_militaryStatus));
      }
    });
  }
}

class gender_bloc extends Bloc<fixTable_event, fixTable_state> {
  static late gender_bloc instance;

  static gender_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<gender_bloc>(context);
    return instance;
  }

  List<Fix_Gender> lst_gender = [];
  List<DropDowenDataSource> lstgenderAsDataSource = [];

  Future getList_gender() async {
    try {
      lst_gender.clear();
      lst_gender = await bllFix_Gender.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  Future getLst_genderAsDataSource() async {
    lstgenderAsDataSource.clear();
    if (bllFix_Gender.lstFix_Gender.length == 0) {
      await bllFix_Gender.fire_getList();
    }
    for (var item in bllFix_Gender.lstFix_Gender) {
      lstgenderAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllFix_Gender.lstFix_Gender.isNotEmpty && ID != null) {
      ret = bllFix_Gender.lstFix_Gender.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  gender_bloc() : super(gender_StateInitial()) {
    on<fixTable_event>((event, emit) async {
      if (event is getListGender_Event) {
        await getList_gender();
        emit(getListGender_State(lst_Gender: lst_gender));
      }
    });
  }
}

class religions_bloc extends Bloc<fixTable_event, fixTable_state> {
  static late religions_bloc instance;

  static religions_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<religions_bloc>(context);
    return instance;
  }

  List<Fix_Religions> lst_religions = [];
  List<DropDowenDataSource> lstReligionsAsDataSource = [];

  Future getList_religions() async {
    try {
      lst_religions.clear();
      lst_religions = await bllFix_Religions.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  Future getLst_religionsAsDataSource() async {
    lstReligionsAsDataSource.clear();
    if (bllFix_Religions.lstFix_Religions.length == 0) await bllFix_Religions.fire_getList();
    for (var item in bllFix_Religions.lstFix_Religions) {
      lstReligionsAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllFix_Religions.lstFix_Religions.isNotEmpty && ID != null) {
      ret = bllFix_Religions.lstFix_Religions.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  religions_bloc() : super(religions_StateInitial()) {
    on<fixTable_event>((event, emit) async {
      if (event is getListReligions_Event) {
        await getList_religions();
        emit(getListReligions_State(lst_Religions: lst_religions));
      }
    });
  }
}

class requestStatus_bloc extends Bloc<fixTable_event, fixTable_state> {
  static late requestStatus_bloc instance;

  static requestStatus_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<requestStatus_bloc>(context);
    return instance;
  }

  List<Fix_RequestStatus> lst_requestStatus = [];
  List<DropDowenDataSource> lstRequestStatusAsDataSource = [];

  Future getList_requestStatus() async {
    try {
      lst_requestStatus.clear();
      lst_requestStatus = await bllFix_RequestStatus.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  Future getLst_requestStatusAsDataSource() async {
    lstRequestStatusAsDataSource.clear();
    if (bllFix_RequestStatus.lstFix_RequestStatus.length == 0) {
      await bllFix_RequestStatus.fire_getList();
    }
    for (var item in bllFix_RequestStatus.lstFix_RequestStatus) {
      lstRequestStatusAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllFix_RequestStatus.lstFix_RequestStatus.isNotEmpty && ID != null) {
      ret = bllFix_RequestStatus.lstFix_RequestStatus.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  requestStatus_bloc() : super(requestStatus_StateInitial()) {
    on<fixTable_event>((event, emit) async {
      if (event is getListRequestStatus_Event) {
        await getList_requestStatus();
        emit(getListRequestStatus_State(lst_RequestStatus: lst_requestStatus));
      }
    });
  }
}

class address_bloc extends Bloc<fixTable_event, fixTable_state> {
  static late address_bloc instance;

  static address_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<address_bloc>(context);
    return instance;
  }

  //****************************** Government ************************************
  List<Fix_Address_Government> lst_AddressGovernment = [];
  List<DropDowenDataSource> lst_AddressGovernmentAsDataSource = [];

  Future getList_AddressGovernment() async {
    try {
      lst_AddressGovernment.clear();
      lst_AddressGovernment = await bllFix_Address_Government.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  Future getLst_AddressGovernmentAsDataSource() async {
    lst_AddressGovernmentAsDataSource.clear();
    if (bllFix_Address_Government.lstFix_Address_Government.length == 0) {
      await getList_AddressGovernment();
    }
    for (var item in bllFix_Address_Government.lstFix_Address_Government) {
      lst_AddressGovernmentAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllFix_Address_Government.lstFix_Address_Government.isNotEmpty && ID != null) {
      ret = bllFix_Address_Government.lstFix_Address_Government.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  //****************************** City ************************************
  List<Fix_Address_City> lst_AddressCity = [];
  List<DropDowenDataSource> lst_AddressCityAsDataSource = [];
  Future getList_AddressCity(int? governmentID) async {
    try {
      // lst_AddressCity.clear();
      lst_AddressCity = await bllFix_Address_City.fire_getListWithConditions(conditions: [
        BLLCondions(
          enTable_Fix_Address_City.IDGovernment.name,
          en_CondionsWhere.isEqualTo,
          governmentID,
        )
      ]);
    } catch (error) {
      print(error.toString());
    }
  }
  Future getLst_AddressCityAsDataSource(int? governmentID) async {
    lst_AddressCityAsDataSource.clear();
    if (bllFix_Address_City.lstFix_Address_City.length == 0) {
      await getList_AddressCity(governmentID);
    }
    for (var item in bllFix_Address_City.lstFix_Address_City) {
      lst_AddressCityAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }
  String getNameCityByID(int? ID) {
    String ret = '';
    if (bllFix_Address_City.lstFix_Address_City.isNotEmpty && ID != null) {
      ret = bllFix_Address_City.lstFix_Address_City.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  //******************************  District Area ************************************
  List<Fix_Address_DistrictArea> lst_AddressArea = [];
  List<DropDowenDataSource> lst_AddressAreaAsDataSource = [];
  Future getLst_AddressArea(int? cityID) async {
    try {
      lst_AddressArea = await bllFix_Address_DistrictArea.fire_getListWithConditions(conditions: [
        BLLCondions(
          enTable_Fix_Address_DistrictArea.CityID.name,
          en_CondionsWhere.isEqualTo,
          cityID,
        )
      ]);
    } catch (error) {
      print(error.toString());
    }
  }
  Future getLst_AddressAreaAsDataSource(int? cityID) async {
    lst_AddressAreaAsDataSource.clear();
    if (bllFix_Address_DistrictArea.lstFix_Address_DistrictArea.length == 0) {
      await getLst_AddressArea(cityID);
    }
    for (var item in bllFix_Address_DistrictArea.lstFix_Address_DistrictArea) {
      lst_AddressAreaAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }
  String getNameAreaByID(int? ID) {
    String ret = '';
    if (bllFix_Address_DistrictArea.lstFix_Address_DistrictArea.isNotEmpty && ID != null) {
      ret = bllFix_Address_DistrictArea.lstFix_Address_DistrictArea.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }



  address_bloc() : super(address_StateInitial()) {
    on<fixTable_event>((event, emit) async {
      if (event is getListAddressGovernment_Event) {
        await getList_AddressGovernment();
        emit(getListAddressGovernment_State(lst_AddressGovernmentAsDataSource: lst_AddressGovernmentAsDataSource));
      }

      //*********************************************************
      else if (event is getListAddressCity_Event) {
        await getList_AddressCity(event.governmentID);
        emit(getListAddressCity_State(lst_AddressCity: lst_AddressCity));
      }
      else if (event is refreshAddressCity_Event) {
        emit(getListAddressCity_State(lst_AddressCity: lst_AddressCity));
      }
      else if (event is getListAddressCityAsDataSource_Event) {
        await getLst_AddressCityAsDataSource(event.governmentID);
        emit(getListAddressCityAsDataSource_State(lst_AddressCityAsDataSource: lst_AddressCityAsDataSource));
      }

      //*********************************************************
      else if (event is getListAddressArea_Event) {
        await getLst_AddressArea(event.cityID);
        emit(getListAddressArea_State(lst_AddressArea: lst_AddressArea));
      }
      else if (event is refreshAddressArea_Event) {
        emit(getListAddressArea_State(lst_AddressArea: lst_AddressArea));
      }
      else if (event is getListAddressAreaAsDataSource_Event) {
        await getLst_AddressAreaAsDataSource(event.cityID);
        emit(getListAddressAreaAsDataSource_State(lst_AddressAreaAsDataSource: lst_AddressAreaAsDataSource));
      }


    });
  }
}
