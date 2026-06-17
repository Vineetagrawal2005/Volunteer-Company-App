import 'package:flutter/material.dart';
import 'package:volunteer_companion_app/core/constants/app_design.dart';
import 'package:volunteer_companion_app/core/constants/tag_images.dart';
import 'package:volunteer_companion_app/model/event_model.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback onRegister;
  const EventCard({super.key, required this.event, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    Color colour = event.isRegisteredByMe
        ? AppColors.success
        : AppColors.primary;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radius),
        color: AppColors.cardBackground,
        border: Border.all(color: colour, width: 3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.radius),
                border: Border.all(color: colour, width: 1.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.radius),
                child: Image.asset(
                  tagImage[event.tag] ?? "assets/images/workshop.png",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: AppTextStyles.subheading,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(event.date, style: AppTextStyles.subheading),
                        Text(event.tag, style: AppTextStyles.caption),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(event.location, style: AppTextStyles.subheading),
                const SizedBox(height: 4),
                Text(event.description, style: AppTextStyles.body),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed:
                      onRegister, // remove the null logic — always tappable now
                  style: ElevatedButton.styleFrom(backgroundColor: colour),
                  child: Text(
                    event.isRegisteredByMe ? "Unregister" : "Register",
                    style: AppTextStyles.button,
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
