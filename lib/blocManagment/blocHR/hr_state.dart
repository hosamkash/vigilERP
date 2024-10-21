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



