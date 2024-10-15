import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart'; // flutter_barcode_scanner: ^2.0.0

class manageBarcode {
  static Future<String> readBarcode() async {
    return await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Cancel', false, ScanMode.DEFAULT).then((val) {
      return val;
    });
  }
}
