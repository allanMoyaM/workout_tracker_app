import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_color_scheme.dart';

class EnerGymAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EnerGymAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final colors = AppColorScheme.of(context);
    return AppBar(
      backgroundColor: colors.background,
      elevation: 0,
      leadingWidth: 52,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: colors.inputBackground,
          child: Icon(Icons.person, color: AppColors.accent, size: 18),
        ),
      ),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'ENER',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            TextSpan(
              text: 'GYM',
              style: TextStyle(
                color: AppColors.accentBlue,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.bolt, color: AppColors.accent, size: 22),
        ),
      ],
    );
  }
}
