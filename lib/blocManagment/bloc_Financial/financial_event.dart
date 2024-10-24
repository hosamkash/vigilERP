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

//*************************** Transfere *******************************
class getListTransfereMony_Event extends financial_event {
  final List<BLLCondions>? conditions;
  getListTransfereMony_Event({ this.conditions });
}
class resetFilterTransfereMony_Event extends financial_event {}
class filterAnyTransfereMony_Event extends financial_event {
  final String? filterData;
  filterAnyTransfereMony_Event({ this.filterData});
}

//*************************** TreasuryMovement *******************************
class getListTreasuryMovementMony_Event extends financial_event {
  final List<BLLCondions>? conditions;
  getListTreasuryMovementMony_Event({ this.conditions });
}
class resetFilterTreasuryMovementMony_Event extends financial_event {}
class filterAnyTreasuryMovementMony_Event extends financial_event {
  final String? filterData;
  filterAnyTreasuryMovementMony_Event({ this.filterData});
}

//*************************** ClosedTreasure *******************************
class getListClosedTreasure_Event extends financial_event {
  final List<BLLCondions>? conditions;
  getListClosedTreasure_Event({ this.conditions });
}
class resetFilterClosedTreasure_Event extends financial_event {}
class filterAnyClosedTreasure_Event extends financial_event {
  final String? filterData;
  filterAnyClosedTreasure_Event({ this.filterData});
}
