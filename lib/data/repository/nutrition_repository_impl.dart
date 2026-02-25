import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:project_a/domain/entities/nutrition/nutrition_entity.dart';
import 'package:project_a/domain/repositories/nutrition/nutrition_repository.dart';
import '../source/nutrition/nutrition_api_service.dart';

class NutritionRepositoryImpl extends NutritionRepository {
  final NutritionApiService apiService;

  NutritionRepositoryImpl({required this.apiService});

  @override
  Future<Either<String, NutritionEntity>> getNutritionDataByDate(DateTime date) async {
    try {
      final model = await apiService.getNutritionDataByDate(date);

      return Right(model.toEntity());
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? 'Beslenme verileri yüklenirken bir sorun oluştu.',
      );
    } catch (e) {
      return Left('Beklenmedik bir hata oluştu: $e');
    }
  }
}