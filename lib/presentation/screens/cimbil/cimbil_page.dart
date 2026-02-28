import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/core/di/service_locator.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/bloc/cimbil/cimbil_bloc.dart';
import 'package:project_a/presentation/bloc/cimbil/cimbil_event.dart';
import 'package:project_a/presentation/bloc/cimbil/cimbil_state.dart';
import 'package:project_a/presentation/widgets/cimbil/cimbil_chat_list.dart';
import 'package:project_a/presentation/widgets/cimbil/cimbil_empty_state.dart';
import 'package:project_a/presentation/widgets/cimbil/cimbil_input_bar.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class CimbilPage extends StatefulWidget {
  const CimbilPage({super.key});

  @override
  State<CimbilPage> createState() => _CimbilPageState();
}

class _CimbilPageState extends State<CimbilPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    context.read<CimbilBloc>().add(SendMessage(text));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CimbilBloc>(),
      child: Builder(
        builder: (context) {
          final l10n = AppLocalizations.of(context)!;
          final textTheme = Theme.of(context).textTheme;

          return Scaffold(
            backgroundColor: ProjectColors.white,
            appBar: AppBar(
              backgroundColor: ProjectColors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new, size: ProjectSizes.iconM),
              ),
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: ProjectSizes.iconL,
                    height: ProjectSizes.iconL,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [ProjectColors.orange, Color(0xFFFF6B6B)],
                      ),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: ProjectSizes.iconSm,
                    ),
                  ),
                  const SizedBox(width: ProjectSizes.paddingSm),
                  Text(
                    l10n.cimbil_title,
                    style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            body: BlocConsumer<CimbilBloc, CimbilState>(
              listener: (context, state) {
                if (state is CimbilLoaded) {
                  _scrollToBottom();
                }
              },
              builder: (context, state) {
                final loaded = state as CimbilLoaded;
                return Column(
                  children: [
                    Expanded(
                      child: loaded.messages.isEmpty
                          ? CimbilEmptyState(
                              onSuggestionTap: (query) {
                                _controller.text = query;
                                _send(context);
                              },
                            )
                          : CimbilChatList(
                              messages: loaded.messages,
                              isTyping: loaded.isTyping,
                              scrollController: _scrollController,
                            ),
                    ),
                    CimbilInputBar(
                      controller: _controller,
                      isLoading: loaded.isTyping,
                      onSend: () => _send(context),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
