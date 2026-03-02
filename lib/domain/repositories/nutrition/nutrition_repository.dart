import 'package:dartz/dartz.dart';
import '../../../data/models/nutrition/nutrition_log_req_params.dart';

abstract class NutritionRepository {
  Future<Either> getNutritionDataByDate(DateTime date);
  Future<Either<String, void>> logNutrition(NutritionLogReqParams params);
}