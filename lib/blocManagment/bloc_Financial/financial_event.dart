part of 'financial_bloc.dart';

@immutable
sealed class financial_event {}

//*************************** Exchange *******************************
class getListExchange_Event extends financial_event {
  final List<BLLCondions>? conditions;
  getListExchange_Event({ this.conditions });
}
class resetFilterExchange_Event extends financial_event {}
class filterAnyExchange_Event extends financial_event {
  final String? filterData;
  filterAnyExchange_Event({ this.filterData});
}

//*************************** Supplay *******************************
class getListSupplay_Event extends financial_event {
  final List<BLLCondions>? conditions;
  getListSupplay_Event({ this.conditions });
}
class resetFilterSupplay_Event extends financial_event {}
class filterAnySupplay_Event extends financial_event {
  final String? filterData;
  filterAnySupplay_Event({ this.filterData});
}
