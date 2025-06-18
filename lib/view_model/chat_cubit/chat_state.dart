part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

// ignore: must_be_immutable
class ChatSuccrss extends ChatState {
  List<Message> message;
  ChatSuccrss({required this.message});
}
