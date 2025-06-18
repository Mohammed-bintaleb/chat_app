import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/chat_cubit/chat_cubit.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static const String screenRoute = 'ChatPage';

  final _scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  List<Message> messagesList = [];

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kLogo, height: 50),
            const SizedBox(width: 8),
            const Text('chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccrss) {
                  messagesList = state.message;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    final isMe = messagesList[index].id == email;
                    return isMe
                        ? ChatBuble(message: messagesList[index])
                        : ChatBubleForFriend(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: textController,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(
                  context,
                ).sendMessage(message: data, email: email);
                textController.clear();
                _scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
