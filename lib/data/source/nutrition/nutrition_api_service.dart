import 'package:project_a/data/models/nutrition/nutrition_log_req_params.dart';
import 'package:project_a/data/models/nutrition/nutrition_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import 'package:intl/intl.dart';

abstract class NutritionApiService {
  Future<NutritionModel> getNutritionDataByDate(DateTime date);
  Future<void> logNutrition(NutritionLogReqParams params);
}

class NutritionApiServiceImpl extends NutritionApiService {
  final DioClient dioClient;

  NutritionApiServiceImpl({required this.dioClient});

  @override
  Future<NutritionModel> getNutritionDataByDate(DateTime date) async {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    final response = await dioClient.get(
      ApiEndpoints.nutritionDataByDate,
      queryParameters: {'date': formattedDate},
    );

    return NutritionModel.fromJson(response.data['data']);
  }

  @override
  Future<void> logNutrition(NutritionLogReqParams params) async {
    await dioClient.post(
      ApiEndpoints.nutritionLog,
      data: params.toJson(),
    );
  }
}