import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/data/models/cimbil/chat_message_model.dart';
import 'package:project_a/data/source/ai/ai_api_service.dart';
import 'package:project_a/utils/local_storage/storage_service.dart';

import 'cimbil_event.dart';
import 'cimbil_state.dart';

class CimbilBloc extends Bloc<CimbilEvent, CimbilState> {
  final AiApiService _aiService;
  final LocalStorageService _localService;

  CimbilBloc({
    required AiApiService aiService,
    required LocalStorageService localService,
  })  : _aiService = aiService,
        _localService = localService,
        super(CimbilLoaded(messages: [])) {
    // Mesajlar sıralı işlensin (stream aktarken yeni mesaj kuyruğa girer)
    on<SendMessage>(
      _onSendMessage,
      transformer: (events, mapper) => events.asyncExpand(mapper),
    );
    on<ClearChat>(_onClearChat);
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<CimbilState> emit,
  ) async {
    final current = state as CimbilLoaded;

    final userMsg = ChatMessageModel(role: 'user', content: event.text);
    final withUser = [...current.messages, userMsg];

    var ctx = current.userContext;
    if (ctx.isEmpty) ctx = await _buildUserContext();

    // Kullanıcı mesajını göster, typing indicator başlat
    emit(current.copyWith(messages: withUser, isTyping: true, userContext: ctx));

    var accumulated = '';

    await emit.forEach<String>(
      _aiService.chatStream(withUser, ctx),
      onData: (token) {
        accumulated += token;
        // Her token'da asistan mesajını güncelle
        return (state as CimbilLoaded).copyWith(
          messages: [
            ...withUser,
            ChatMessageModel(role: 'assistant', content: accumulated),
          ],
          isTyping: true,
        );
      },
      onError: (error, _) {
        debugPrint('CimbilBloc chatStream error: $error');
        return (state as CimbilLoaded).copyWith(
          messages: [
            ...withUser,
            const ChatMessageModel(
              role: 'assistant',
              content: 'Bir hata oluştu, lütfen tekrar deneyin.',
            ),
          ],
          isTyping: false,
        );
      },
    );

    // Stream bitti, isTyping kapat
    if (state is CimbilLoaded) {
      emit((state as CimbilLoaded).copyWith(isTyping: false));
    }
  }

  void _onClearChat(ClearChat event, Emitter<CimbilState> emit) {
    emit(CimbilLoaded(messages: []));
  }

  Future<Map<String, String>> _buildUserContext() async {
    final answers = await _localService.getFormAnswers();
    return {
      if (answers['goal'] != null) 'Hedef': answers['goal']!,
      if (answers['gender'] != null) 'Cinsiyet': answers['gender']!,
      if (answers['age'] != null) 'Yaş': answers['age']!,
      if (answers['height'] != null) 'Boy': '${answers['height']} cm',
      if (answers['weight'] != null) 'Kilo': '${answers['weight']} kg',
      if (answers['activityLevel'] != null) 'Aktivite': answers['activityLevel']!,
    };
  }
}
