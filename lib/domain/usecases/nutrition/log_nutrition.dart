import 'package:dartz/dartz.dart';
import '../../../data/models/nutrition/nutrition_log_req_params.dart';
import '../../repositories/nutrition/nutrition_repository.dart';

class LogNutritionUseCase {
  final NutritionRepository nutritionRepository;

  LogNutritionUseCase({required this.nutritionRepository});

  Future<Either<String, void>> call({required NutritionLogReqParams param}) {
    return nutritionRepository.logNutrition(param);
  }
}
