import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_companion_app/core/constants/app_design.dart';
import 'package:volunteer_companion_app/provider/app_state_provider.dart';
import 'package:volunteer_companion_app/screen/badges_screen.dart';
import 'package:volunteer_companion_app/screen/events_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> screen = [EventsScreen(), BadgesScreen()];
  int curIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72.0),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.small),
          child: AppBar(
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.background,
                ),
                onPressed: () async {
                  await context.read<AppStateProvider>().logOutUser();
                  Navigator.pushReplacementNamed(context, "/logInScreen");
                },
              ),
            ],
            title: Text(
              "Volunteer Companion App",
              style: AppTextStyles.heading,
            ),
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.radius),
            ),
          ),
        ),
      ),
      body: IndexedStack(index: curIndex, children: screen),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppDimens.small),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimens.radius),
          child: BottomNavigationBar(
            backgroundColor: AppColors.primary,
            selectedItemColor: AppColors.background,
            unselectedItemColor: AppColors.background.withOpacity(0.5),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
              BottomNavigationBarItem(
                icon: Icon(Icons.verified),
                label: 'Badges',
              ),
            ],
            currentIndex: curIndex,
            onTap: (index) {
              setState(() {
                curIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
