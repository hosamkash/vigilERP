part of 'connectivity_bloc.dart';

@immutable
sealed class connectivity_State {}

final class connected_StateInitial extends connectivity_State {}
class connected_State extends connectivity_State {
  late String message;
  connected_State({required this.message});
}
class notConnected_State extends connectivity_State {
  late String message;
  notConnected_State({required this.message});
}
