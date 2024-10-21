part of 'hr_bloc.dart';

@immutable
sealed class hr_event {}

//*************************** Bonus *******************************
class getListBonus_Event extends hr_event {
  final List<BLLCondions>? conditions;
  getListBonus_Event({ this.conditions });
}
class resetFilterBonus_Event extends hr_event {}
class filterAnyBonus_Event extends hr_event {
  final String? filterData;
  filterAnyBonus_Event({ this.filterData});
}

//*************************** Discount *******************************
class getListDiscount_Event extends hr_event {
  final List<BLLCondions>? conditions;
  getListDiscount_Event({ this.conditions });
}
class resetFilterDiscount_Event extends hr_event {}
class filterAnyDiscount_Event extends hr_event {
  final String? filterData;
  filterAnyDiscount_Event({ this.filterData});
}