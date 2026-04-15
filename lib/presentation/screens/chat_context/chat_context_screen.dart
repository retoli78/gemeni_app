
import 'package:flutter/material.dart';
import 'package:gemeni_app/presentation/wigets/chat/custom_bottom_input.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemeni_app/presentation/providers/chat/chat_with_context.dart';

import 'package:gemeni_app/presentation/providers/users/user_provider.dart';


class ChatContextScreen extends ConsumerWidget {
  const ChatContextScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final chatMessages = ref.watch(chatWithContextProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat conversacional'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(chatWithContextProvider.notifier).newChat();

            }, 
            icon: Icon(Icons.delete_outline)
          )
        ],
      ),
      body: Chat(
        messages:chatMessages,

        //On send Message 
        onSendPressed: (_) {},
        user: user,
        theme: DarkChatTheme(),
        showUserNames: true,

        // Custom Input Area
        customBottomWidget: CustomBottomInput(
          onSend: (partialText, {images = const []}) {
            final chatNotifier = ref.read(chatWithContextProvider.notifier);
            chatNotifier.addMessage(
              partialText: partialText,
              user: user,
              images: images,
            );
          },
        ),
      )
    );
  }
}