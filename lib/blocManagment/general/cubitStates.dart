import '../../bll/classModel/Fix_RequestStatus.dart';
import '../../componants/ctr_DropDowenList.dart';

abstract class cubitStates {}

class state_InitialApp extends cubitStates {}
class state_BordingIndexChanged extends cubitStates {}
class state_TabIndexChanged extends cubitStates {}

//**************************** requestStatus ********************************
class requestStatus_StateChanged extends cubitStates {
  List<Fix_RequestStatus> lst_requestStatus = [];
  List<DropDowenDataSource> lstrequestStatusAsDataSource = [];
  requestStatus_StateChanged(this.lst_requestStatus, this.lstrequestStatusAsDataSource);
}
