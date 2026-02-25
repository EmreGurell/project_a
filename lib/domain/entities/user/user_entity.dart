class UserEntity {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String status;
  final String? profilePicture;

  UserEntity( {this.profilePicture,required this.id, required this.username, required this.email, required this.firstName, required this.lastName, required this.role, required this.status});


}