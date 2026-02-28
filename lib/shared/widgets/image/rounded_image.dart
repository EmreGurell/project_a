import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';
import 'package:shimmer/shimmer.dart';

/// URL ile verilen görseli yuvarlatılmış (köşeleri oval) gösterir.
/// [CachedNetworkImage] kullanır; bir kez yüklendikten sonra cache'den gösterilir.
class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = width;
    final effectiveHeight = height;
    final radius = borderRadius ?? BorderRadius.circular(ProjectSizes.imageAndCardRadius);

    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: effectiveWidth,
      height: effectiveHeight,
      fit: fit,
      placeholder: (context, url) =>
      placeholder ??
          Shimmer.fromColors(
            baseColor: ProjectColors.cardGray,
            highlightColor: Colors.white,
            child: Container(
              width: effectiveWidth,
              height: effectiveHeight,
              decoration: BoxDecoration(
                color: ProjectColors.cardGray,
                borderRadius: radius,
              ),
            ),
          ),
      errorWidget: (context, url, error) =>
      errorWidget ??
          SizedBox(
            width: effectiveWidth,
            height: effectiveHeight,
            child: Icon(
              Icons.person,
              size: (effectiveWidth ?? 48) * 0.5,
              color: ProjectColors.textGray,
            ),
          ),
    );

    return ClipRRect(borderRadius: radius, child: image);
  }
}