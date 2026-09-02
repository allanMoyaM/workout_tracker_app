import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../view_model/signup_view_model.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_color_scheme.dart';
import '../../core/widgets/loading_indicator.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(),
      child: Scaffold(
        backgroundColor: colors.background,
        body: const SingleChildScrollView(
          child: Column(
            children: [
              _HeroSection(),
              _FormSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      height: 200,
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
          Positioned(
            bottom: 24,
            left: 24,
            child: Text(
              l10n.createAccount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
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
    final l10n = AppLocalizations.of(context)!;
    return Consumer<SignUpViewModel>(
      builder: (context, vm, _) {
        if (vm.status == SignUpStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showConfirmEmailDialog(context, l10n);
          });
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldLabel(l10n.emailAddress, colors),
              const SizedBox(height: 8),
              _InputField(
                hint: l10n.emailHint,
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
                onChanged: vm.onEmailChanged,
                colors: colors,
              ),
              const SizedBox(height: 24),
              _FieldLabel(l10n.password, colors),
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
              const SizedBox(height: 24),
              _FieldLabel(l10n.confirmPassword, colors),
              const SizedBox(height: 8),
              _InputField(
                hint: '••••••••',
                icon: Icons.lock_outline,
                obscureText: !vm.isPasswordVisible,
                onChanged: vm.onConfirmPasswordChanged,
                colors: colors,
              ),
              if (vm.errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(vm.errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
              ],
              const SizedBox(height: 32),
              _SignUpButton(label: l10n.signUp, onTap: vm.signUp, isLoading: vm.isLoading),
              const SizedBox(height: 36),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: RichText(
                    text: TextSpan(
                      text: '${l10n.alreadyHaveAccount}  ',
                      style: TextStyle(color: colors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1),
                      children: [
                        TextSpan(
                          text: l10n.logIn,
                          style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w800, letterSpacing: 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmEmailDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Icon(Icons.mark_email_read_outlined, color: AppColors.accent, size: 48),
        content: Text(
          l10n.checkYourEmail,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // cierra dialog
              Navigator.of(context).pop(); // vuelve a login
            },
            child: Text(l10n.logIn, style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
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

class _SignUpButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLoading;
  const _SignUpButton({required this.label, required this.onTap, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: isLoading
              ? const LoadingIndicator()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label, style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: 2)),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward, color: Colors.black, size: 18),
                  ],
                ),
        ),
      ),
    );
  }
}
