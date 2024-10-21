part of 'hr_bloc.dart';

@immutable
sealed class hr_state {}

//*************************** Bonus *******************************
final class hr_StateInitial extends hr_state {}
final class getListBonus_StateDataChanged extends hr_state {
  final List<HR_Bonus> filterdLst_Bonus;
  getListBonus_StateDataChanged({required this.filterdLst_Bonus});
}

//*************************** Discount *******************************
final class getListDiscount_StateDataChanged extends hr_state {
  final List<HR_Discount> filterdLst_Discount;
  getListDiscount_StateDataChanged({required this.filterdLst_Discount});
}

//*************************** Withdrwals *******************************
final class getListWithdrwals_StateDataChanged extends hr_state {
  final List<HR_Withdrwals> filterdLst_Withdrwals;
  getListWithdrwals_StateDataChanged({required this.filterdLst_Withdrwals});
}

//*************************** Advances *******************************
final class getListAdvances_StateDataChanged extends hr_state {
  final List<HR_Advances> filterdLst_Advances;
  getListAdvances_StateDataChanged({required this.filterdLst_Advances});
}

