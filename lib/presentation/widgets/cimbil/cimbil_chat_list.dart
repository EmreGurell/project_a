import 'package:flutter/material.dart';
import 'package:project_a/data/models/cimbil/chat_message_model.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

import 'cimbil_chat_bubble.dart';

class CimbilChatList extends StatelessWidget {
  const CimbilChatList({
    super.key,
    required this.messages,
    required this.isTyping,
    required this.scrollController,
  });

  final List<ChatMessageModel> messages;
  final bool isTyping;
  final ScrollController scrollController;

  // Token henüz gelmemişse (son mesaj kullanıcıya ait) typing bubble göster
  bool get _showTyping =>
      isTyping && (messages.isEmpty || messages.last.isUser);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(
        horizontal: ProjectSizes.paddingMd,
        vertical: ProjectSizes.paddingSm,
      ),
      // Typing bubble: sadece henüz AI token göndermediyse göster
      // Token gelince son mesaj asistanın olur, bubble gizlenir
      itemCount: messages.length + (_showTyping ? 1 : 0),
      itemBuilder: (_, i) {
        if (i == messages.length && _showTyping) {
          return const _TypingBubble();
        }
        final msg = messages[i];
        return CimbilChatBubble(text: msg.content, isUser: msg.isUser);
      },
    );
  }
}

class _TypingBubble extends StatefulWidget {
  const _TypingBubble();

  @override
  State<_TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<_TypingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: ProjectSizes.paddingSm),
        padding: const EdgeInsets.symmetric(
          horizontal: ProjectSizes.paddingMd,
          vertical: ProjectSizes.paddingSm,
        ),
        decoration: BoxDecoration(
          color: ProjectColors.cardGray,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(18),
          ),
        ),
        child: FadeTransition(
          opacity: _anim,
          child: const Text('● ● ●', style: TextStyle(letterSpacing: 2)),
        ),
      ),
    );
  }
}
