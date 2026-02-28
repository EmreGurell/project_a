import 'package:dartz/dartz.dart';
import 'package:project_a/core/usecase/usecase.dart';

import '../../repositories/nutrition/nutrition_repository.dart';

class GetNutritionDataByDate extends Usecase<Either,dynamic>{
  final NutritionRepository nutritionRepository;

  GetNutritionDataByDate({required this.nutritionRepository});
  @override
  Future<Either> call({param}) {
    return nutritionRepository.getNutritionDataByDate(param as DateTime);
  }

}