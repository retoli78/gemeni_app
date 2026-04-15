
import 'package:flutter/material.dart';
import 'package:gemeni_app/presentation/wigets/chat/custom_bottom_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemeni_app/presentation/providers/chat/basic_chat.dart';
import 'package:gemeni_app/presentation/providers/chat/is_gemini_writing.dart';
import 'package:gemeni_app/presentation/providers/users/user_provider.dart';


class BasicPromptScreen extends ConsumerWidget {
  const BasicPromptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final geminiUser = ref.watch(geminiUserProvider);
    final user = ref.watch(userProvider);
    final isGeminiWriting = ref.watch(isGeminiWritingProvider);
    final chatMessages = ref.watch(basicChatProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Prompt Básico'),
      ),
      body: Chat(
        messages:chatMessages,

        //On send Message 
        onSendPressed: (types.PartialText partialText) {

        /*  /* /*  final basicChatNotifier = ref.read(basicChatProvider.notifier);
          basicChatNotifier.addMessage(
            partialText: partialText,
            user: user */
          ); */
         */
        },
        user: user,
        theme: DarkChatTheme(),
        showUserNames: true,

        // Custom Input Area
        customBottomWidget: CustomBottomInput(
          onSend: (types.PartialText partialText, {List<XFile>? images}) {
          final basicChatNotifier = ref.read(basicChatProvider.notifier);
          basicChatNotifier.addMessage(
            partialText: partialText,
            user: user,
            images: images ?? [],);

            print(images);
        }),


        // on files selected
        /* onAttachmentPressed: () async {
          ImagePicker picker =ImagePicker();
          final List<XFile> images = await picker.pickMultiImage(limit : 4) ;
          if(images.isEmpty) return;

          print(images);
        }, */


        //showUserAvatars: true,
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers: isGeminiWriting ? [geminiUser] : [],
          customTypingWidget: Center(
            child: Text('Gemini está pensando...'),
          )
        )
      )
    );
  }
}