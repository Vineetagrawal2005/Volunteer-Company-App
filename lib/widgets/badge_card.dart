import 'package:flutter/material.dart';
import 'package:volunteer_companion_app/core/constants/app_design.dart';

class BadgeCard extends StatelessWidget {
  final String name;
  final String description;
  final bool isUnlocked;
  const BadgeCard({
    super.key,
    required this.name,
    required this.description,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    Color colour = isUnlocked ? AppColors.accent : AppColors.textSecondary;
    return Container(
      padding: const EdgeInsets.all(AppDimens.small),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radius),
        color: AppColors.cardBackground,
        border: Border.all(color: colour, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.verified, color: colour),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colour,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colour,
            ),
          ),
        ],
      ),
    );
  }
}
