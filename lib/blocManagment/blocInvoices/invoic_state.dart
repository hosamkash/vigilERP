part of 'invoic_bloc.dart';

@immutable
// sealed class InvoicState {}
final class invoic_state  {}

//******************************** purchase **************************************
final class purchase_StateInitial extends invoic_state {}
final class purchase_StateDataChanged extends invoic_state {
  final List<Invoices_Purchase> filterdLst_Purchase;
  purchase_StateDataChanged({required this.filterdLst_Purchase});
}
final class purchaseDetails_StateInitial extends invoic_state {}
final class purchaseDetails_StateDataChanged extends invoic_state {
  final List<Invoices_PurchaseDetails> filterdLst_PurchaseDetails;
  purchaseDetails_StateDataChanged({required this.filterdLst_PurchaseDetails});
}
final class clearPurchaseDetails extends invoic_state {}

//******************************** sales **************************************
final class sales_StateInitial extends invoic_state {}
final class sales_StateDataChanged extends invoic_state {
  final List<Invoices_Sales> filterdLst_Sales;
  sales_StateDataChanged({required this.filterdLst_Sales});
}
final class salesDetails_StateInitial extends invoic_state {}
final class salesDetails_StateDataChanged extends invoic_state {
  final List<Invoices_SalesDetails> filterdLst_SalesDetails;
  salesDetails_StateDataChanged({required this.filterdLst_SalesDetails});
}
final class clearSalesDetails extends invoic_state {}