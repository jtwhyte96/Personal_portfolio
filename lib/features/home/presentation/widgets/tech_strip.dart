import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_chip.dart';

/// Technology and skills strip showcasing core capabilities.
/// Data-driven from [AppConstants.skills].
class TechStrip extends StatelessWidget {
  const TechStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surfacePrimary,
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.borderSubtle, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: AppConstants.skills.map((skill) {
                  return AppChip(
                    label: skill.name,
                    icon: skill.icon,
                    isInteractive: true,
                    accentColor: _getAccentForSkill(skill.name),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getAccentForSkill(String name) {
    switch (name) {
      case 'Java':
        return AppColors.accentCyan;
      case 'Flutter':
      case 'Dart':
        return AppColors.accentBlue;
      case 'AI Tools':
      case 'Prompt Engineering':
        return AppColors.accentViolet;
      case 'UI/UX Design':
        return const Color(0xFFF472B6);
      case 'Git & GitHub':
        return AppColors.accentEmerald;
      default:
        return AppColors.accentViolet;
    }
  }
}
