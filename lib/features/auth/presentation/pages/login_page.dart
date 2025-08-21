import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/services/auth_service.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final authService = sl<AuthService>();
      final user = await authService.signInWithGoogle();

      if (user != null && mounted) {
        context.go(AppRoutes.home);
      } else {
        _showErrorSnackBar('เข้าสู่ระบบไม่สำเร็จ กรุณาลองใหม่อีกครั้ง');
      }
    } catch (e) {
      _showErrorSnackBar('เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: AppColors.error),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacing24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // EV-X Logo only
              Image.asset(
                'assets/images/logo.png',
                width: 300,
                height: 120,
                fit: BoxFit.contain,
              ),

              const Spacer(),

              // Sign In Button
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _signInWithGoogle,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.onPrimary,
                        ),
                      )
                    : SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          'assets/images/google_logo.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                label: Text(
                  _isLoading ? 'กำลังเข้าสู่ระบบ...' : 'เข้าสู่ระบบด้วย Google',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.spacing16,
                  ),
                ),
              ),

              const SizedBox(height: AppConstants.spacing40),
            ],
          ),
        ),
      ),
    );
  }
}
