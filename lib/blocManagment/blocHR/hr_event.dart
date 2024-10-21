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

//*************************** Withdrwals *******************************
class getListWithdrwals_Event extends hr_event {
  final List<BLLCondions>? conditions;
  getListWithdrwals_Event({ this.conditions });
}
class resetFilterWithdrwals_Event extends hr_event {}
class filterAnyWithdrwals_Event extends hr_event {
  final String? filterData;
  filterAnyWithdrwals_Event({ this.filterData});
}

//*************************** Advances *******************************
class getListAdvances_Event extends hr_event {
  final List<BLLCondions>? conditions;
  getListAdvances_Event({ this.conditions });
}
class resetFilterAdvances_Event extends hr_event {}
class filterAnyAdvances_Event extends hr_event {
  final String? filterData;
  filterAnyAdvances_Event({ this.filterData});
}

