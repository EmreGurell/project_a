import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_a/utils/local_storage/storage_service.dart';

import 'profile_setup_event.dart';
import 'profile_setup_state.dart';

class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  final LocalStorageService localService;

  ProfileSetupBloc({required this.localService}) : super(ProfileSetupInitial()) {
    on<LoadFormProgress>(_onLoad);
    on<AnswerUpdated>(_onAnswerUpdated);
    on<AnswerUpdated2>(_onAnswerUpdated2);
    on<FormPageChanged>(_onPageChanged);
    on<SubmitForm>(_onSubmit);
  }

  Future<void> _onLoad(LoadFormProgress event, Emitter<ProfileSetupState> emit) async {
    final answers = await localService.getFormAnswers();
    final page = await localService.getFormCurrentPage();
    emit(ProfileSetupInProgress(currentPage: page, answers: answers));
  }

  Future<void> _onAnswerUpdated(AnswerUpdated event, Emitter<ProfileSetupState> emit) async {
    final current = state as ProfileSetupInProgress;
    final updated = Map<String, String>.from(current.answers)..[event.key] = event.value;
    await localService.saveFormAnswers(updated);
    emit(current.copyWith(answers: updated));
  }

  Future<void> _onAnswerUpdated2(AnswerUpdated2 event, Emitter<ProfileSetupState> emit) async {
    final current = state as ProfileSetupInProgress;
    final updated = Map<String, String>.from(current.answers)..[event.key] = event.value;
    await localService.saveFormAnswers(updated);
    emit(current.copyWith(answers: updated));
  }

  Future<void> _onPageChanged(FormPageChanged event, Emitter<ProfileSetupState> emit) async {
    final current = state as ProfileSetupInProgress;
    await localService.saveFormCurrentPage(event.page);
    emit(current.copyWith(currentPage: event.page));
  }

  Future<void> _onSubmit(SubmitForm event, Emitter<ProfileSetupState> emit) async {
    final current = state as ProfileSetupInProgress;
    emit(current.copyWith(isSubmitting: true));
    // TODO: API çağrıları endpoint'ler netleşince eklenecek
    await localService.setUserFormCompleted();
    await localService.clearFormData();
    emit(ProfileSetupSuccess());
  }
}
