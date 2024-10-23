part of 'financial_bloc.dart';

@immutable
sealed class financial_state {}

final class financialnitial extends financial_state {}

//*************************** Exchange *******************************
final class getListExchange_StateDataChanged extends financial_state {
  final List<Fina_Exchange> filterdLst_Exchange;
  getListExchange_StateDataChanged({required this.filterdLst_Exchange});
}

//*************************** Supplay *******************************
final class getListSupplay_StateDataChanged extends financial_state {
  final List<Fina_Supplay> filterdLst_Supplay;
  getListSupplay_StateDataChanged({required this.filterdLst_Supplay});
}
