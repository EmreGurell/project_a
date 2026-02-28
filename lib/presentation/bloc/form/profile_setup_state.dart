abstract class ProfileSetupState {}

class ProfileSetupInitial extends ProfileSetupState {}

class ProfileSetupInProgress extends ProfileSetupState {
  final int currentPage;
  final Map<String, String> answers;
  final bool isSubmitting;

  ProfileSetupInProgress({
    required this.currentPage,
    required this.answers,
    this.isSubmitting = false,
  });

  ProfileSetupInProgress copyWith({
    int? currentPage,
    Map<String, String>? answers,
    bool? isSubmitting,
  }) {
    return ProfileSetupInProgress(
      currentPage: currentPage ?? this.currentPage,
      answers: answers ?? this.answers,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class ProfileSetupSuccess extends ProfileSetupState {}

class ProfileSetupFailure extends ProfileSetupState {
  final String message;
  ProfileSetupFailure(this.message);
}
