class BaseResponseModel {
  final bool success;
  final String message;

  const BaseResponseModel({
    required this.success,
    required this.message,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      success: json['success'],
      message: json['message'],
    );
  }
}
