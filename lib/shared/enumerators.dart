
import '../componants/ctr_DropDowenList.dart';

enum en_AppKey {
  isSkipBoarding,
}

enum en_DocumentType {
  permissionAdd(1),
  permissionDiscount(2),
  settlement(3),
  transfer(4),
  // transfer(5),
  ;

  final int value;

  const en_DocumentType(this.value);
}

enum en_FormMode {
  NewMode,
  EditMode,
  // View,
}

enum en_DataTypeComon {
  string,
  bool,
  double,
  int,
  listString,
  map,
  LoginModel,
}

enum en_finacialType {
  finacialTypeExchange,
  finacialTypeSupplay,
}

enum en_PriceType {
  purchasePrice(1),
  salesPrice1(2),
  salesPrice2(3),
  salesPrice3(4),
  salesPrice4(5),
  salesPrice5(6);

  final int value;

  const en_PriceType(this.value);
}

enum en_BalanceType {
  debit_Madeen_Aleh,
  credit_Daeen_Loh,
}

enum en_MaritalStatus {
  singel,
  married,
  marriedWithChildren,
  armal,
  motallak,
}

enum en_MilitaryStatus {
  exempt,
  postponement,
  ending,
}

enum en_Gender {
  male,
  female,
  undefined,
}

enum en_Religions {
  muslim,
  misihy,
  undefined,
}

enum en_Monthes {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December,
}

enum en_RequestStatus {
  OnDemand(1), // تحت الطلب
  RequestCompleted(2), // تم إنهاء الطلب
  UnderReview(3), // قيد المراجعة
  ReviewError(4), // خطأ فى المراجعة
  Preparing(5), // قيد التجهيز
  SuccessfullyPrepared(6), // تم التجهيز بنجاح
  PreparedWithNotes(7), // تم التجهيز مع ملاحظات
  PreparedIncomplete(8), // تم التجهيز - ناقص
  Sending(9), // قيد الإرسال
  Sent(10), // تم الإرسال
  ReceivedReview(11), // قيد مراجعة الإستلام
  Received(12), // تم الإستلام
  ReceivedWithCorrection(13); // تم الإستلام مع التصحيح

  final int? value;
  const en_RequestStatus(this.value);

}

enum en_CondionsWhere {
  isNull,
  isEqualTo,
  isNotEqualTo,
  isLessThan,
  isLessThanOrEqualTo,
  isGreaterThan,
  isGreaterThanOrEqualTo,
  whereIn,
  whereNotIn,
  arrayContains,
  arrayContainsAny
}

enum en_HideZeroFrom {
  stockQty(1) ,
  representQty(2) ,
  sumQty(3) ;

  final int value ;
  const en_HideZeroFrom(this.value);

  static List<String> getListArabic()  {
    List<String> lst = [
      getNameArabicByValue(1),
      getNameArabicByValue(2),
      getNameArabicByValue(3),
    ];
    return lst;
  }

  static List<DropDowenDataSource> getListDropDowen ()  {
    List<DropDowenDataSource> lst = [
      DropDowenDataSource(valueMember: stockQty.value, displayMember: getNameArabicByValue(1)),
      DropDowenDataSource(valueMember: representQty.value, displayMember: getNameArabicByValue(2)),
      DropDowenDataSource(valueMember: sumQty.value, displayMember: getNameArabicByValue(3)),
    ];
    return lst;
  }

 static String getNameArabicByValue(int value)  {
    if(value == 1)
      return 'رصيد المخزن';
    else  if(value == 2)
      return 'رصيد المندوبين';
    else  if(value == 3)
      return 'إجمالى الكمية';
    else
      return '';
  }

  static String getNameEnglishByArabic(String ar)  {
    if(ar ==  'رصيد المخزن')
      return stockQty.name;
    else  if(ar ==  'رصيد المندوبين')
      return  representQty.name;
    else  if(ar ==  'إجمالى الكمية')
      return sumQty.name ;
    else
      return '';
  }

}
