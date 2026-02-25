import 'package:dartz/dartz.dart';

abstract class NutritionRepository{
  Future<Either> getNutritionDataByDate(DateTime date);

}