import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../bll/bllFirebase/bllDef_CompanyStructure.dart';
import '../bll/classModel/Def_CompanyStructure.dart';
import 'enumerators.dart';

class sharedHive {

  static String UID = '';
  static String path = '';
  static Def_CompanyStructure? currentBranch;

  static void initial() async {

    // ********************************* ثابت فى اي مثود
    final ApppDirectory = await getApplicationDocumentsDirectory();
    path = ApppDirectory.path;
    Hive.init(ApppDirectory.path);
     currentBranch =await bllDef_CompanyStructure.fire_getItem('1');
  }

  static resetAllData() async {
    Hive.deleteBoxFromDisk(path);
  }

  static remove(String key) async {
    initial();
    await Hive.deleteBoxFromDisk(key, path: path).then((value) {
      // print(' deleteBoxFromDisk -----------------------------------');
    });
  }

  static Future saveData(String key, dynamic Value) async {
    // ********************************* ثابت فى اي مثود
    final ApppDirectory = await getApplicationDocumentsDirectory();
    // print('appDocDir.path : ${ApppDirectory.path}');
    Hive.init(ApppDirectory.path);
    // print('Hive.init');

    Hive.openBox(key).then((box) {
      box.put(key, Value).then((put) {
        // print('Value put : ${box.get(key)}');
      });
    });
  }

  static dynamic getData(String key, {dynamic defultValue, en_DataTypeComon type = en_DataTypeComon.string}) async {
    final ApppDirectory = await getApplicationDocumentsDirectory();
    Hive.init(ApppDirectory.path);

    var boxExists = await Hive.boxExists(key, path: ApppDirectory.path);
    // print('boxExists : ${boxExists}');

    var box;
    // var openBox;
    var get;
    if (!boxExists) {
      return castTypeReturned(null, type);
    }
//*********************************
    else {
      box = await Hive.openBox(key);
      // print('box : ${box.runtimeType}');

      get = await box.get(key);
      // print('get : ${get}');

      if (get == null) {
        box.put(key, defultValue);
        get = await box.get(key);
        // print('get Another : ${get}');
      }
      return castTypeReturned(get, type);
    }
  }

  static dynamic castTypeReturned(dynamic get, en_DataTypeComon type) {
    if (type == en_DataTypeComon.bool)
      return get != null ? get as bool : false;
    else if (type == en_DataTypeComon.string)
      return get != null ? get as String : '';
    else if (type == en_DataTypeComon.double)
      return get != null ? get as double : 0.0;
    else if (type == en_DataTypeComon.int) return get != null ? get as int : -1;
  }
}
