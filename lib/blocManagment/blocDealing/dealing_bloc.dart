import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../bll/bllFirebase/bllDealing_Clients.dart';
import '../../bll/bllFirebase/bllDealing_Employees.dart';
import '../../bll/bllFirebase/bllDealing_Users.dart';
import '../../bll/bllFirebase/bllDealing_Vendors.dart';
import '../../bll/classModel/Dealing_Clients.dart';
import '../../bll/classModel/Dealing_Employees.dart';
import '../../bll/classModel/Dealing_Users.dart';
import '../../bll/classModel/Dealing_Vendors.dart';
import '../../componants/ctr_DropDowenList.dart';
import '../../managment/manage_Images.dart';
import '../blocDefinition/definition_bloc.dart';

part 'dealing_event.dart';

part 'dealing_state.dart';

class employee_bloc extends Bloc<dealing_event, dealing_state> {
  static late employee_bloc instance;

  static employee_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<employee_bloc>(context);
    return instance;
  }

  List<Dealing_Employees> filterdLst_Employee = [];
  List<DropDowenDataSource> LstEmployeeAsDataSource = [];

  Future getList_Employee() async {
    try {
      filterdLst_Employee.clear();
      filterdLst_Employee = await bllDealing_Employees.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  // Future getList_EmployeeFromDB_ByBranch(int branchID) async {
  //   try {
  //     filterdLst_Employee.clear();
  //     filterdLst_Employee = await bllDealing_Employees.fire_getListByBranch(branchID , enTable_Dealing_Employees.IDBranch.name);
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  filterAny_Employee({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Employee();
    }
    filterdLst_Employee = bllDealing_Employees.lstDealing_Employees.where((item) {
      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Phone == null ? false : item.Phone!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Mobile == null ? false : item.Mobile!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Address == null ? false : item.Address!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (job_bloc.instance.getNameByID(item.IDJob).toLowerCase().contains(filterData!.toLowerCase())) //||
          // (cubitDefinitions.objCubit.getNameCompanyByID(item.IDBranch).toLowerCase().contains(filterData.toLowerCase()))

          ;
    }).toList();
  }

  Future resetFilter_Employee() async {
    filterdLst_Employee.clear();
    filterdLst_Employee = bllDealing_Employees.lstDealing_Employees;
  }

  Future getLstEmployeeAsDataSource() async {
    LstEmployeeAsDataSource.clear();
    if (bllDealing_Employees.lstDealing_Employees.length == 0) {
      await getList_Employee();
    }
    for (var item in bllDealing_Employees.lstDealing_Employees) {
      LstEmployeeAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  //  getEmployeeByID(int? ID) async {
  //   bllDealing_Employees? ret;
  //
  //   if (bllDealing_Employees.lstDealing_Employees.length == 0 && ID != null) {
  //     await getLstEmployeeAsDataSource();
  //   }
  //   ret = bllDealing_Employees.lstDealing_Employees.firstWhere((elm) {
  //     return elm.ID == ID;
  //   });
  //   return ret;
  // }

  String getNameByID(int? ID) {
    String ret = '';

    if (bllDealing_Employees.lstDealing_Employees.isNotEmpty && ID != null) {
      ret = bllDealing_Employees.lstDealing_Employees.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  late imageTemplet EmployeeImageTemp = imageTemplet();

  Future takeImageEmployee(ImageSource imageSource) async {
    ImagePicker().pickImage(source: imageSource).then((value) {
      EmployeeImageTemp.imagepath = value!.path;
      EmployeeImageTemp.imageName = Uri.file(value.path).pathSegments.last;
      EmployeeImageTemp.imageFile = File(value.path);
      EmployeeImageTemp.image = Image.file(EmployeeImageTemp.imageFile!).image;
    }).catchError((error) {
      throw error;
    });
  }

  employee_bloc() : super(employee_StateInitial()) {
    on<dealing_event>((event, emit) async {
      if (event is getListEmployee_Event) {
        await getList_Employee();
        emit(getListEmployee_StateDataChanged(filterdLst_Employee: filterdLst_Employee));
      } else if (event is getLstEmployeeAsDataSource_Event) {
        await getLstEmployeeAsDataSource();
        emit(getListEmployee_StateDataChanged(filterdLst_Employee: filterdLst_Employee));
      } else if (event is filterAnyEmployee_Event) {
        await filterAny_Employee(filterData: event.filterData);
        emit(getListEmployee_StateDataChanged(filterdLst_Employee: filterdLst_Employee));
      } else if (event is resetFilterEmployee_Event) {
        await resetFilter_Employee();
        emit(getListEmployee_StateDataChanged(filterdLst_Employee: filterdLst_Employee));
      }
    });
  }
}

class client_bloc extends Bloc<dealing_event, dealing_state> {
  static late client_bloc instance;

  static client_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<client_bloc>(context);
    return instance;
  }

  List<Dealing_Clients> filterdLst_Client = [];
  List<DropDowenDataSource> LstClientAsDataSource = [];

  Future getList_Client() async {
    try {
      filterdLst_Client = await bllDealing_Clients.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  filterAny_Client({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Client();
    }
    filterdLst_Client = bllDealing_Clients.lstDealing_Clients.where((item) {
      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Phone == null ? false : item.Phone!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Mobile == null ? false : item.Mobile!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Address == null ? false : item.Address!.toLowerCase().contains(filterData!.toLowerCase())) //||
          // (job_bloc.instance.getNameJobByID(item.IDJob).toLowerCase().contains(filterData!.toLowerCase())) ||
          // (cubitDefinitions.objCubit.getNameCompanyByID(item.IDBranch).toLowerCase().contains(filterData.toLowerCase()))

          ;
    }).toList();
  }

  Future resetFilter_Client() async {
    filterdLst_Client.clear();
    filterdLst_Client = bllDealing_Clients.lstDealing_Clients;
  }

  Future getLstClientAsDataSource() async {
    LstClientAsDataSource.clear();
    if (bllDealing_Clients.lstDealing_Clients.length == 0) {
      await getList_Client();
    }
    for (var item in bllDealing_Clients.lstDealing_Clients) {
      LstClientAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if(bllDealing_Clients.lstDealing_Clients.length == 0)
      bllDealing_Clients.fire_getList();

    if (bllDealing_Clients.lstDealing_Clients.isNotEmpty && ID != null) {
      ret = bllDealing_Clients.lstDealing_Clients.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  client_bloc() : super(client_StateInitial()) {
    on<dealing_event>((event, emit) async {
      if (event is getListClient_Event) {
        await getList_Client();
        emit(getListClient_StateDataChanged(filterdLst_Client: filterdLst_Client));
      }
      else if (event is getListClientAsDataSource_Event) {
        await getLstClientAsDataSource();
        emit(getListClientAsDataSource_StateDataChanged(filterdLst_ClientAsDataSource: LstClientAsDataSource));
      }
      else if (event is filterAnyClient_Event) {
        await filterAny_Client(filterData: event.filterData);
        emit(getListClient_StateDataChanged(filterdLst_Client: filterdLst_Client));
      } else if (event is resetFilterClient_Event) {
        await resetFilter_Client();
        emit(getListClient_StateDataChanged(filterdLst_Client: filterdLst_Client));
      }
    });
  }
}

class vendor_bloc extends Bloc<dealing_event, dealing_state> {
  static late vendor_bloc instance;

  static vendor_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<vendor_bloc>(context);
    return instance;
  }

  List<Dealing_Vendors> filterdLst_Vendor = [];
  List<DropDowenDataSource> LstVendorAsDataSource = [];

  Future getList_Vendor() async {
    try {
      filterdLst_Vendor = await bllDealing_Vendors.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  filterAny_Vendor({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_Vendor();
    }
    filterdLst_Vendor = bllDealing_Vendors.lstDealing_Vendors.where((item) {
      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Phone == null ? false : item.Phone!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Mobile == null ? false : item.Mobile!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Address == null ? false : item.Address!.toLowerCase().contains(filterData!.toLowerCase())) //||
          // (job_bloc.instance.getNameJobByID(item.IDJob).toLowerCase().contains(filterData!.toLowerCase())) ||
          // (cubitDefinitions.objCubit.getNameCompanyByID(item.IDBranch).toLowerCase().contains(filterData.toLowerCase()))

          ;
    }).toList();
  }

  Future resetFilter_Vendor() async {
    filterdLst_Vendor.clear();
    filterdLst_Vendor = bllDealing_Vendors.lstDealing_Vendors;
  }

  Future getList_VendorAsDataSource() async {
     LstVendorAsDataSource.clear();
    if (bllDealing_Vendors.lstDealing_Vendors.length == 0) {
      await bllDealing_Vendors.fire_getList();
    }
    for (var item in bllDealing_Vendors.lstDealing_Vendors) {
      LstVendorAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllDealing_Vendors.lstDealing_Vendors.isNotEmpty && ID != null) {
      ret = bllDealing_Vendors.lstDealing_Vendors.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  vendor_bloc() : super(vendor_StateInitial()) {
    on<dealing_event>((event, emit) async {
      if (event is getListVendor_Event) {
        await getList_Vendor();
        emit(getListVendor_StateDataChanged(filterdLst_Vendor: filterdLst_Vendor));
      }
      else if (event is getListVendorAsDataSource_Event) {
        await getList_VendorAsDataSource();
        emit(getListVendorAsDataSource_StateDataChanged(filterdLst_VendorAsDataSource: LstVendorAsDataSource));
      }
      else if (event is filterAnyVendor_Event) {
        await filterAny_Vendor(filterData: event.filterData);
        emit(getListVendor_StateDataChanged(filterdLst_Vendor: filterdLst_Vendor));
      } else if (event is resetFilterVendor_Event) {
        await resetFilter_Vendor();
        emit(getListVendor_StateDataChanged(filterdLst_Vendor: filterdLst_Vendor));
      }
    });
  }
}

class user_bloc extends Bloc<dealing_event, dealing_state> {
  static late user_bloc instance;

  static user_bloc cretaeInctance(BuildContext context) {
    instance = BlocProvider.of<user_bloc>(context);
    return instance;
  }

  List<Dealing_Users> filterdLst_User = [];
  List<DropDowenDataSource> LstUserAsDataSource = [];

  Future getList_User() async {
    try {
      filterdLst_User = await bllDealing_Users.fire_getList();
    } catch (error) {
      print(error.toString());
    }
  }

  filterAny_User({String? filterData}) {
    if (filterData == null || filterData.isEmpty) {
      resetFilter_User();
    }
    filterdLst_User = bllDealing_Users.lstDealing_Users.where((item) {
      return (item.Code == null ? false : item.Code!.toString().toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Name == null ? false : item.Name!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Phone == null ? false : item.Phone!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Mobile == null ? false : item.Mobile!.toLowerCase().contains(filterData!.toLowerCase())) ||
              (item.Address == null ? false : item.Address!.toLowerCase().contains(filterData!.toLowerCase())) //||
          // (job_bloc.instance.getNameJobByID(item.IDJob).toLowerCase().contains(filterData!.toLowerCase())) ||
          // (cubitDefinitions.objCubit.getNameCompanyByID(item.IDBranch).toLowerCase().contains(filterData.toLowerCase()))

          ;
    }).toList();
  }

  Future resetFilter_User() async {
    filterdLst_User.clear();
    filterdLst_User = bllDealing_Users.lstDealing_Users;
  }

  Future getLstUserAsDataSource() async {
    LstUserAsDataSource.clear();
    if (bllDealing_Users.lstDealing_Users.length == 0) await bllDealing_Users.fire_getList();
    for (var item in bllDealing_Users.lstDealing_Users) {
      LstUserAsDataSource.add(DropDowenDataSource(valueMember: item.ID!, displayMember: item.Name!));
    }
  }

  String getNameByID(int? ID) {
    String ret = '';
    if (bllDealing_Users.lstDealing_Users.isNotEmpty && ID != null) {
      ret = bllDealing_Users.lstDealing_Users.firstWhere((elm) {
        return elm.ID == ID;
      }).Name!;
    }
    return ret;
  }

  user_bloc() : super(user_StateInitial()) {
    on<dealing_event>((event, emit) async {
      if (event is getListUser_Event) {
        await getList_User();
        emit(getListUser_StateDataChanged(filterdLst_User: filterdLst_User));
      } else if (event is filterAnyUser_Event) {
        await filterAny_User(filterData: event.filterData);
        emit(getListUser_StateDataChanged(filterdLst_User: filterdLst_User));
      } else if (event is resetFilterUser_Event) {
        await resetFilter_User();
        emit(getListUser_StateDataChanged(filterdLst_User: filterdLst_User));
      }
    });
  }
}
