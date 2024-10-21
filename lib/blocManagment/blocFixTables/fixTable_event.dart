part of 'fix_table_bloc.dart';

@immutable
sealed class fixTable_event {}

//*************************** Fix_PriceType *******************************
class getListPriceType_Event extends fixTable_event {}

//*************************** Fix_BalanceType *******************************
class getListBalanceType_Event extends fixTable_event {}

//*************************** MaritalStatus *******************************
class getListMaritalStatus_Event extends fixTable_event {}

//*************************** militaryStatus *******************************
class getListMilitaryStatus_Event extends fixTable_event {}

//*************************** militaryStatus *******************************
class getListGender_Event extends fixTable_event {}

//*************************** militaryStatus *******************************
class getListReligions_Event extends fixTable_event {}

 //*************************** RequestStatus *******************************
 class getListRequestStatus_Event extends fixTable_event {}

//*************************** Address Government *******************************
class getListAddressGovernment_Event extends fixTable_event {}

//*************************** Address City*******************************
class getListAddressCity_Event extends fixTable_event {
 int? governmentID;
 getListAddressCity_Event({this.governmentID});
}
class getListAddressCityAsDataSource_Event extends fixTable_event {
 int? governmentID;
 getListAddressCityAsDataSource_Event({this.governmentID});
}
class refreshAddressCity_Event extends fixTable_event {}

//*************************** Address City*******************************
class getListAddressAreaAsDataSource_Event extends fixTable_event {
 final int? cityID;
 getListAddressAreaAsDataSource_Event({this.cityID});
}
class getListAddressArea_Event extends fixTable_event {
 final int? cityID;
 getListAddressArea_Event({this.cityID});
}
class refreshAddressArea_Event extends fixTable_event {}

//*************************** Bonus Type *******************************
class getListBonusType_Event extends fixTable_event {}
class getListBonusTypeAsDataSource_Event extends fixTable_event {}

