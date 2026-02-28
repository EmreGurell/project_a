abstract class NutritionResultEvent {}

class AnalyzeBarcode extends NutritionResultEvent {
  final String barcode;
  AnalyzeBarcode(this.barcode);
}

class AnalyzeImage extends NutritionResultEvent {
  final String imagePath;
  AnalyzeImage(this.imagePath);
}
