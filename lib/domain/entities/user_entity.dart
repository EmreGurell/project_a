import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });

  // Ad Soyad birleşimi — her yerde user.displayName diye kullan
  String get displayName => '$firstName $lastName';

  @override
  List<Object?> get props => [id, firstName, lastName, email, role];
}
