import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_a/l10n/app_localizations.dart';
import 'package:project_a/presentation/screens/cimbil/cimbil_page.dart';
import 'package:project_a/presentation/screens/nutrition/nutrition_result_page.dart';
import 'package:project_a/presentation/widgets/barcode/scanner_barcode_found_banner.dart';
import 'package:project_a/presentation/widgets/barcode/scanner_food_frame_overlay.dart';
import 'package:project_a/presentation/widgets/barcode/scanner_food_top_banner.dart';
import 'package:project_a/presentation/widgets/barcode/scanner_mode_tabs.dart';
import 'package:project_a/presentation/widgets/barcode/scanner_querying_modal.dart';
import 'package:project_a/presentation/widgets/barcode/scanner_scan_overlay.dart';
import 'package:project_a/presentation/widgets/barcode/scanner_status_badge.dart';
import 'package:project_a/utils/constants/colors.dart';
import 'package:project_a/utils/constants/sizes.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key, required this.camera});
  final CameraDescription camera;

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  late final CameraController _cam;
  late final Future<void> _init;

  final _barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.all]);
  bool _isProcessing = false;
  bool _streaming = false;

  ScanMode _mode = ScanMode.barcode;
  String? _detectedBarcode;
  bool _showFoodInstruction = true;

  @override
  void initState() {
    super.initState();
    _cam = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _init = _cam.initialize().then((_) => _startStream());
  }

  Future<void> _startStream() async {
    if (_streaming || _mode != ScanMode.barcode) return;
    _streaming = true;
    setState(() {});

    await _cam.startImageStream((CameraImage image) async {
      if (_isProcessing || !_streaming) return;
      _isProcessing = true;

      try {
        final input = _buildInputImage(image);
        if (input == null) {
          _isProcessing = false;
          return;
        }

        final barcodes = await _barcodeScanner.processImage(input);
        if (barcodes.isNotEmpty) {
          final raw = barcodes.first.rawValue ?? "";
          if (raw.isNotEmpty && _streaming) {
            await _stopStream();
            if (!mounted) return;
            setState(() => _detectedBarcode = raw);
            _showQueryingModal(raw);
            return;
          }
        }
      } catch (e) {
        debugPrint('Barcode scan error: $e');
      } finally {
        _isProcessing = false;
      }
    });
  }

  InputImage? _buildInputImage(CameraImage image) {
    final rotation = InputImageRotationValue.fromRawValue(
      _cam.description.sensorOrientation,
    );
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) {
      return null;
    }

    if (image.planes.isEmpty) return null;

    return InputImage.fromBytes(
      bytes: image.planes.first.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );
  }

  void _showQueryingModal(String barcode) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (_) => ScannerQueryingModal(barcode: barcode),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => NutritionResultPage(barcode: barcode, mode: 'barcode'),
        ),
      );
    });
  }

  Future<void> _stopStream() async {
    if (!_streaming) return;
    _streaming = false;
    try {
      await _cam.stopImageStream();
    } catch (_) {}
  }

  Future<void> _takePhoto() async {
    if (_streaming) await _stopStream();
    final file = await _cam.takePicture();
    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NutritionResultPage(
          photoPath: file.path,
          barcode: _detectedBarcode,
          mode: _mode.name,
        ),
      ),
    );
  }

  Future<void> _pickFromGallery() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null || !mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NutritionResultPage(photoPath: file.path, mode: 'food'),
      ),
    );
  }

  Future<void> _resetBarcode() async {
    setState(() => _detectedBarcode = null);
    await _startStream();
  }

  void _switchMode(ScanMode mode) async {
    if (_mode == mode) return;

    if (mode == ScanMode.askAI) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const CimbilPage()),
      );
      return;
    }

    if (_streaming) await _stopStream();

    setState(() {
      _mode = mode;
      _detectedBarcode = null;
      _showFoodInstruction = true;
    });

    if (mode == ScanMode.barcode) {
      await _startStream();
    }
  }

  @override
  void dispose() {
    _stopStream();
    _barcodeScanner.close();
    _cam.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _init,
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          return Stack(
            children: [
              Positioned.fill(child: CameraPreview(_cam)),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                      stops: const [0.0, 0.25, 0.65, 1.0],
                    ),
                  ),
                ),
              ),

              if (_mode == ScanMode.barcode && _streaming)
                const ScannerScanOverlay(),

              if (_mode == ScanMode.barcode && _detectedBarcode != null)
                ScannerBarcodeFoundBanner(
                  barcode: _detectedBarcode!,
                  onRescan: _resetBarcode,
                ),

              if (_mode == ScanMode.food) ...[
                const ScannerFoodFrameOverlay(),
                ScannerFoodTopBanner(
                  visible: _showFoodInstruction,
                  onDismiss: () => setState(() => _showFoodInstruction = false),
                ),
                // Fotoğraf çekme + galeriden seçme butonları
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Galeri butonu (sol)
                          GestureDetector(
                            onTap: _pickFromGallery,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.7),
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.photo_library_outlined,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(width: 32),
                          // Çekim butonu (orta)
                          GestureDetector(
                            onTap: _takePhoto,
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // Denge için boşluk (sağ)
                          const SizedBox(width: 32 + 48),
                        ],
                      ),
                    ),
                  ),
                ),
              ],

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ProjectSizes.paddingSm,
                    vertical: ProjectSizes.borderRadiusSm,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black26,
                        ),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: ProjectSizes.iconM + 2,
                        ),
                      ),
                      if (_mode == ScanMode.barcode && _streaming)
                        ScannerStatusBadge(
                          label: l10n.scanner_barcode_scanning,
                          icon: Icons.qr_code_scanner,
                          color: ProjectColors.green,
                        ),
                      if (_mode == ScanMode.food)
                        ScannerStatusBadge(
                          label: l10n.scanner_food_mode,
                          icon: Icons.restaurant,
                          color: ProjectColors.orange,
                        ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: ProjectSizes.paddingMd),
                    child: ScannerModeTabs(
                      currentMode: _mode,
                      onModeChanged: _switchMode,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
