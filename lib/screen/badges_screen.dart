import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_companion_app/core/constants/app_design.dart';
import 'package:volunteer_companion_app/provider/app_state_provider.dart';
import 'package:volunteer_companion_app/widgets/badge_card.dart';

class BadgeInfo {
  final String name;
  final String description;
  final int threshold;

  BadgeInfo({
    required this.name,
    required this.description,
    required this.threshold,
  });
}

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  static final List<BadgeInfo> badgeList = [
    BadgeInfo(
      name: "First Step",
      description: "Register for 1 event",
      threshold: 1,
    ),
    BadgeInfo(
      name: "Active Volunteer",
      description: "Register for 3 events",
      threshold: 3,
    ),
    BadgeInfo(
      name: "Community Pillar",
      description: "Register for 5 events",
      threshold: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final currentUser = appState.currentUser;

    int unlockedCount = badgeList
        .where((b) => appState.isBadgeUnlocked(b.threshold))
        .length;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppDimens.medium),
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimens.medium),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppDimens.radius),
              border: Border.all(color: AppColors.primary, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentUser?.name ?? "Volunteer",
                  style: AppTextStyles.head,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      currentUser?.email ?? "—",
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      currentUser?.phone ?? "—",
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.medium),
          Text(
            "$unlockedCount/${badgeList.length} Badges Earned",
            style: AppTextStyles.subheading,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radius),
            child: LinearProgressIndicator(
              value: badgeList.isEmpty ? 0 : unlockedCount / badgeList.length,
              backgroundColor: AppColors.textSecondary.withOpacity(0.2),
              color: AppColors.accent,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: AppDimens.medium),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppDimens.small,
              crossAxisSpacing: AppDimens.small,
              childAspectRatio: 1,
            ),
            itemCount: badgeList.length,
            itemBuilder: (context, index) {
              final badge = badgeList[index];
              final isUnlocked = appState.isBadgeUnlocked(badge.threshold);
              return BadgeCard(
                name: badge.name,
                description: badge.description,
                isUnlocked: isUnlocked,
              );
            },
          ),
        ],
      ),
    );
  }
}
