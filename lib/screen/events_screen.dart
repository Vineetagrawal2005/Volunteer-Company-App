import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_companion_app/core/constants/app_design.dart';
import 'package:volunteer_companion_app/provider/app_state_provider.dart';
import 'package:volunteer_companion_app/widgets/event_card.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    setState(() {
      isLoading = true;
    });
    await context.read<AppStateProvider>().loadEvent();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final events = context.watch<AppStateProvider>().events ?? [];

    if (isLoading && events.isEmpty) {
      return Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    return RefreshIndicator(
      onRefresh: loadEvents,
      color: AppColors.primary,
      child: events.isEmpty
          ? ListView(
              children: [
                const SizedBox(height: 120),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.event_busy,
                        size: 48,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 12),
                      Text("No events yet", style: AppTextStyles.subheading),
                    ],
                  ),
                ),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppDimens.medium),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(
                  event: event,
                  onRegister: () {
                    if (event.isRegisteredByMe) {
                      context.read<AppStateProvider>().unregisterFromEvent(
                        event.id,
                      );
                    } else {
                      context.read<AppStateProvider>().regisForEvent(event.id);
                    }
                  },
                );
              },
            ),
    );
  }
}
