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
final class clearPurchaseDetails_State extends invoic_state {}

//******************************** purchaseReturned **************************************
final class purchaseReturned_StateInitial extends invoic_state {}
final class purchaseReturned_StateDataChanged extends invoic_state {
  final List<Invoices_PurchaseReturned> filterdLst_PurchaseReturned;
  purchaseReturned_StateDataChanged({required this.filterdLst_PurchaseReturned});
}
final class purchaseReturnedDetails_StateInitial extends invoic_state {}
final class purchaseReturnedDetails_StateDataChanged extends invoic_state {
  final List<Invoices_PurchaseReturnedDetails> filterdLst_PurchaseReturnedDetails;
  purchaseReturnedDetails_StateDataChanged({required this.filterdLst_PurchaseReturnedDetails});
}
final class clearPurchaseReturnedDetails_State extends invoic_state {}


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

//******************************** salesReturned **************************************
final class salesReturned_StateInitial extends invoic_state {}
final class salesReturned_StateDataChanged extends invoic_state {
  final List<Invoices_SalesReturned> filterdLst_SalesReturned;
  salesReturned_StateDataChanged({required this.filterdLst_SalesReturned});
}
final class salesReturnedDetails_StateInitial extends invoic_state {}
final class salesReturnedDetails_StateDataChanged extends invoic_state {
  final List<Invoices_SalesReturnedDetails> filterdLst_SalesReturnedDetails;
  salesReturnedDetails_StateDataChanged({required this.filterdLst_SalesReturnedDetails});
}
final class clearSalesReturnedDetails extends invoic_state {}