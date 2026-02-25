// lib/common/bloc/user/user_event.dart
part of 'user_bloc.dart';

abstract class UserEvent {}

// "Bana kullanıcı bilgilerini getir" eventi
class GetUserMeEvent extends UserEvent {}

// İleride eklenecekler için hazır yapı:
// class UpdateProfileEvent extends UserEvent {
//   final String name;
//   UpdateProfileEvent({required this.name});
// }
