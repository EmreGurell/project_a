import 'package:project_a/data/models/cimbil/chat_message_model.dart';

abstract class CimbilState {}

class CimbilLoaded extends CimbilState {
  final List<ChatMessageModel> messages;
  final bool isTyping;
  final Map<String, String> userContext;

  CimbilLoaded({
    required this.messages,
    this.isTyping = false,
    this.userContext = const {},
  });

  CimbilLoaded copyWith({
    List<ChatMessageModel>? messages,
    bool? isTyping,
    Map<String, String>? userContext,
  }) {
    return CimbilLoaded(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      userContext: userContext ?? this.userContext,
    );
  }
}
