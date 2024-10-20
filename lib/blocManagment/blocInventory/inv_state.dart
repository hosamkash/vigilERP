part of 'inv_bloc.dart';

@immutable
sealed class inv_state {}

//******************************** Material Qty - الجرد المستمر **************************************
final class productQty_StateInitial extends inv_state {}

final class productQty_StateDataChanged extends inv_state {
  final List<Inv_ProductsQty> filterdLst_productQty;
  double? sumQty;
  double? sumQtyRepresents;
  double? sumTotalQty;
  double? sumTotalPrice;

  productQty_StateDataChanged({
    required this.filterdLst_productQty,
    this.sumQty,
    this.sumQtyRepresents,
    this.sumTotalQty,
    this.sumTotalPrice,
  });
}

//******************************** Permission add **************************************
final class permissionAdd_StateInitial extends inv_state {}

final class permissionAdd_StateDataChanged extends inv_state {
  final List<Inv_PermissionAdd> filterdLst_PermissionAdd;

  permissionAdd_StateDataChanged({required this.filterdLst_PermissionAdd});
}

final class permissionAddDetails_StateInitial extends inv_state {}

final class permissionAddDetails_StateDataChanged extends inv_state {
  final List<Inv_PermissionAddDetails> filterdLst_PermissionAddDetails;

  permissionAddDetails_StateDataChanged({required this.filterdLst_PermissionAddDetails});
}

final class clearPermissionAddDetails extends inv_state {}

//******************************** Permission discount **************************************
final class permissionDiscount_StateInitial extends inv_state {}

final class permissionDiscount_StateDataChanged extends inv_state {
  final List<Inv_PermissionDiscount> filterdLst_PermissionDiscount;

  permissionDiscount_StateDataChanged({required this.filterdLst_PermissionDiscount});
}

final class permissionDiscountDetails_StateInitial extends inv_state {}

final class permissionDiscountDetails_StateDataChanged extends inv_state {
  final List<Inv_PermissionDiscountDetails> filterdLst_PermissionDiscountDetails;

  permissionDiscountDetails_StateDataChanged({required this.filterdLst_PermissionDiscountDetails});
}

final class clearPermissionDiscountDetails extends inv_state {}

//******************************** Settlement **************************************
final class settlement_StateInitial extends inv_state {}

final class settlement_StateDataChanged extends inv_state {
  final List<Inv_Settlement> filterdLst_Settlement;

  settlement_StateDataChanged({required this.filterdLst_Settlement});
}

final class settlementDetails_StateInitial extends inv_state {}

final class settlementDetails_StateDataChanged extends inv_state {
  final List<Inv_SettlementDetails> filterdLst_SettlementDetails;

  settlementDetails_StateDataChanged({required this.filterdLst_SettlementDetails});
}

final class clearSettlementDetails extends inv_state {}

//******************************** Transfer **************************************
final class transfer_StateInitial extends inv_state {}

final class transfer_StateDataChanged extends inv_state {
  final List<Inv_Transfer> filterdLst_Transfer;

  transfer_StateDataChanged({required this.filterdLst_Transfer});
}
final class transferDetails_StateInitial extends inv_state {}
final class transferDetails_StateDataChanged extends inv_state {
  final List<Inv_TransferDetails> filterdLst_TransferDetails;

  transferDetails_StateDataChanged({required this.filterdLst_TransferDetails});
}
final class clearTransferDetails extends inv_state {}

//******************************** Recived **************************************
final class recived_StateInitial extends inv_state {}

final class recived_StateDataChanged extends inv_state {
  final List<Inv_RecivedQty> filterdLst_Recived;

  recived_StateDataChanged({required this.filterdLst_Recived});
}
final class recivedDetails_StateInitial extends inv_state {}
final class recivedDetails_StateDataChanged extends inv_state {
  final List<Inv_RecivedQtyDetails> filterdLst_RecivedDetails;

  recivedDetails_StateDataChanged({required this.filterdLst_RecivedDetails});
}
final class clearRecivedDetails extends inv_state {}

