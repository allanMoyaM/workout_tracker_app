import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/login_view_model.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_color_scheme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    return Scaffold(
      backgroundColor: colors.background,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            _HeroSection(),
            _FormSection(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.accentBlue, AppColors.accentBlue.withOpacity(0.4)],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.6)],
              ),
            ),
          ),
          Positioned(
            top: 52,
            left: 0,
            right: 0,
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'ENER',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    const TextSpan(
                      text: 'GYM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 24,
            left: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ELITE PERFORMANCE',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'FUEL YOUR\nAMBITION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  const _FormSection();

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    return Consumer<LoginViewModel>(
      builder: (context, vm, _) {
        if (vm.status == LoginStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/home');
          });
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldLabel('EMAIL ADDRESS', colors),
              const SizedBox(height: 8),
              _InputField(
                hint: 'name@domain.com',
                icon: Icons.mail_outline,
                onChanged: vm.onEmailChanged,
                keyboardType: TextInputType.emailAddress,
                colors: colors,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _FieldLabel('PASSWORD', colors),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _InputField(
                hint: '••••••••',
                icon: Icons.lock_outline,
                obscureText: !vm.isPasswordVisible,
                onChanged: vm.onPasswordChanged,
                colors: colors,
                suffixIcon: GestureDetector(
                  onTap: vm.togglePasswordVisibility,
                  child: Icon(
                    vm.isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: colors.textSecondary,
                    size: 20,
                  ),
                ),
              ),
              if (vm.errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(vm.errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
              ],
              const SizedBox(height: 32),
              _LoginButton(onTap: vm.login, isLoading: vm.isLoading),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(child: Divider(color: colors.divider)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('OR CONTINUE WITH',
                        style: TextStyle(color: colors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1)),
                  ),
                  Expanded(child: Divider(color: colors.divider)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _SocialButton(label: 'Google', icon: _GoogleIcon(), onTap: vm.loginWithGoogle, colors: colors)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SocialButton(
                      label: 'Apple',
                      icon: Icon(Icons.apple, color: colors.textPrimary, size: 20),
                      onTap: vm.loginWithApple,
                      colors: colors,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'NEW TO ENERGYM?  ',
                    style: TextStyle(color: colors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1),
                    children: const [
                      TextSpan(
                        text: 'SIGN UP NOW',
                        style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w800, letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final AppColorScheme colors;
  const _FieldLabel(this.text, this.colors);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(color: colors.textSecondary, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.5));
  }
}

class _InputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final AppColorScheme colors;

  const _InputField({
    required this.hint,
    required this.icon,
    required this.colors,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.inputBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colors.inputBorder),
      ),
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: TextStyle(color: colors.textPrimary, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: colors.textSecondary, fontSize: 14),
          prefixIcon: Icon(icon, color: colors.textSecondary, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;
  const _LoginButton({required this.onTap, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: isLoading
              ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2.5))
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('LOG IN', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: 2)),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, color: Colors.black, size: 18),
                  ],
                ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;
  final AppColorScheme colors;
  const _SocialButton({required this.label, required this.icon, required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: colors.buttonSecondary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors.inputBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(label, style: TextStyle(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('G', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700));
  }
}
