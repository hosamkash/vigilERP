part of 'fix_table_bloc.dart';

@immutable
sealed class fixTable_state {}

//*************************** Fix_PriceType *******************************
final class priceType_StateInitial extends fixTable_state {}
final class getListPriceType_State extends fixTable_state {
  final List<Fix_PriceType> lst_PriceType;
  getListPriceType_State({required this.lst_PriceType});
}

//*************************** Fix_BalanceType *******************************
final class balanceType_StateInitial extends fixTable_state {}
final class getListBalanceType_State extends fixTable_state {
  final List<Fix_BalanceType> lst_BalanceType;
  getListBalanceType_State({required this.lst_BalanceType});
}

//*************************** MaritalStatus *******************************
final class maritalStatus_StateInitial extends fixTable_state {}
final class getListMaritalStatus_State extends fixTable_state {
  final List<Fix_MaritalStatus> lst_MaritalStatus;
  getListMaritalStatus_State({required this.lst_MaritalStatus});
}

//*************************** militaryStatus *******************************
final class militaryStatus_StateInitial extends fixTable_state {}
final class getListMilitaryStatus_State extends fixTable_state {
  final List<Fix_MilitaryStatus> lst_MilitaryStatus;
  getListMilitaryStatus_State({required this.lst_MilitaryStatus});
}

//*************************** Genders *******************************
final class gender_StateInitial extends fixTable_state {}
final class getListGender_State extends fixTable_state {
  final List<Fix_Gender> lst_Gender;
  getListGender_State({required this.lst_Gender});
}

//*************************** Religions *******************************
final class religions_StateInitial extends fixTable_state {}
final class getListReligions_State extends fixTable_state {
  final List<Fix_Religions> lst_Religions;
  getListReligions_State({required this.lst_Religions});
}

//*************************** RequestStatus *******************************
final class requestStatus_StateInitial extends fixTable_state {}
final class getListRequestStatus_State extends fixTable_state {
  final List<Fix_RequestStatus> lst_RequestStatus;
  getListRequestStatus_State({required this.lst_RequestStatus});
}

//*************************** address Government *******************************
final class address_StateInitial extends fixTable_state {}
final class getListAddressGovernment_State extends fixTable_state {
  final List<DropDowenDataSource> lst_AddressGovernmentAsDataSource;
  getListAddressGovernment_State({required this.lst_AddressGovernmentAsDataSource});
}

//*************************** Address City  *******************************
final class getListAddressCity_State extends fixTable_state {
 final List<Fix_Address_City> lst_AddressCity;
  getListAddressCity_State({required this.lst_AddressCity });
}

final class getListAddressCityAsDataSource_State extends fixTable_state {
  final List<DropDowenDataSource> lst_AddressCityAsDataSource;
  getListAddressCityAsDataSource_State({required this.lst_AddressCityAsDataSource });
}

//*************************** Address Area  *******************************
final class getListAddressArea_State extends fixTable_state {
  final List<Fix_Address_DistrictArea> lst_AddressArea;
  getListAddressArea_State({required this.lst_AddressArea });
}
final class getListAddressAreaAsDataSource_State extends fixTable_state {
  final List<DropDowenDataSource> lst_AddressAreaAsDataSource;
  getListAddressAreaAsDataSource_State({required this.lst_AddressAreaAsDataSource });
}


