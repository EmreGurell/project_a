abstract class ButtonState {}

class ButtonLoadingState extends ButtonState{}

class ButtonSuccessState extends ButtonState {}

class ButtonInitialState extends ButtonState {}

class ButtonDisabledState extends ButtonState{}

class ButtonFailureState extends ButtonState {
  final String errorMessage;

  ButtonFailureState({required this.errorMessage});
  
}
