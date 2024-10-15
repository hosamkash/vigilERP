part of 'connectivity_bloc.dart';

@immutable
sealed class connectivity_Event {}

class connected_Event extends connectivity_Event{}
class notConnected_Event extends connectivity_Event{}