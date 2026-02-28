abstract class ProfileSetupEvent {}

class LoadFormProgress extends ProfileSetupEvent {}

class AnswerUpdated extends ProfileSetupEvent {
  final String key;
  final String value;
  AnswerUpdated(this.key, this.value);
}

class AnswerUpdated2 extends ProfileSetupEvent {
  final String key;
  final String value;
  AnswerUpdated2(this.key, this.value);
}

class FormPageChanged extends ProfileSetupEvent {
  final int page;
  FormPageChanged(this.page);
}

class SubmitForm extends ProfileSetupEvent {}
