import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_a/utils/constants/colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideUpAnimation;
  late Animation<double> _scaleUpAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ), // Giriş animasyonu biraz daha belirgin olsun
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideUpAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), // Çok derinlerden gelmesine gerek yok
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _scaleUpAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.white,
      body: Center(
        // AnimatedBuilder'ı sildik, Transition widget'ları doğrudan animasyonu dinler.
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: SlideTransition(
            position: _slideUpAnimation,
            child: ScaleTransition(
              scale: _scaleUpAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildAnimatedLogo(),
                  const SizedBox(height: 36),
                  Text(
                    'İçerik Yükleniyor...', // Daha genel bir yükleme metni
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(ProjectColors.orange),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Karmaşayı önlemek için logoyu ayrı bir metoda aldım
  Widget _buildAnimatedLogo() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFAF9F1).withOpacity(0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Lottie.asset(
          'assets/images/login/sad.json',
          repeat: true,
          width: 140,
          height: 140,
        ),
      ),
    );
  }
}
