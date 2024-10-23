part of 'dealing_bloc.dart';

@immutable
sealed class dealing_event {}

//*************************** Employee *******************************
class getListEmployee_Event extends dealing_event {}
class resetFilterEmployee_Event extends dealing_event {}
class filterAnyEmployee_Event extends dealing_event {
  final String? filterData;
  filterAnyEmployee_Event({ this.filterData});
}
class getLstEmployeeAsDataSource_Event extends dealing_event {}
class getListEmployeesOffline_Event extends dealing_event {
  final int? branchID;
  final String? filterData;
  getListEmployeesOffline_Event({ this.branchID , this.filterData});
}
//*************************** Client *******************************
class getListClient_Event extends dealing_event {}
class getListClientAsDataSource_Event extends dealing_event {}
class resetFilterClient_Event extends dealing_event {}
class filterAnyClient_Event extends dealing_event {
  final String? filterData;
  filterAnyClient_Event({ this.filterData});
}
class getListClientsOffline_Event extends dealing_event {
  final int? branchID;
  final String? filterData;
  getListClientsOffline_Event({ this.branchID , this.filterData});
}
//*************************** Vendor *******************************
class getListVendor_Event extends dealing_event {}
class getListVendorAsDataSource_Event extends dealing_event {}
class resetFilterVendor_Event extends dealing_event {}
class filterAnyVendor_Event extends dealing_event {
  final String? filterData;
  filterAnyVendor_Event({ this.filterData});
}
class getListVendorsOffline_Event extends dealing_event {
  final int? branchID;
  final String? filterData;
  getListVendorsOffline_Event({ this.branchID , this.filterData});
}
//*************************** User *******************************
class getListUser_Event extends dealing_event {}
class resetFilterUser_Event extends dealing_event {}
class filterAnyUser_Event extends dealing_event {
  final String? filterData;
  filterAnyUser_Event({ this.filterData});
}



