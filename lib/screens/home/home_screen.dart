import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seniorpal/controllers/home_controller.dart';
import 'package:seniorpal/provider/theme_provider.dart';
import 'package:seniorpal/screens/home/profile_screen.dart';
import 'package:seniorpal/widgets/Common/custom_app_bar.dart';
import 'package:seniorpal/widgets/Common/gradient_layer.dart';
import 'package:seniorpal/widgets/Home/home_buttons.dart';
import 'package:seniorpal/widgets/Home/home_greeting_text.dart';
import 'package:seniorpal/widgets/Home/home_quote.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _userFullName = 'User';
  String _dailyQuote = 'Quote';
  final UserController _userController = UserController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final user = await _userController.fetchUserData();
    final quote = await _userController.fetchDailyQuote();
    setState(() {
      _userFullName = user != null ? user.firstName : 'User';
      _dailyQuote = quote;
    });
  }

  void _openProfileOverlay() {
    showModalBottomSheet(
        useSafeArea: true, // Important to ignore safe area space
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (ctx) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          // Background image with gradient overlay
          Positioned(
            top: -topPadding,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55 + topPadding,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(theme.backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Foreground content with AppBar
          Positioned.fill(
            child: Column(
              children: [
                CustomAppBar(
                    title: "Home",
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.black.withOpacity(0.2),
                    titleColor: Colors.white,
                    onPressed: _openProfileOverlay),
                GradientLayer(colors: [
                  Colors.black.withOpacity(0.2),
                  ...theme.backgroundGradient
                ])
              ],
            ),
          ),
          // The View Content must come here
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.5),
                  GreetingText(userFullName: _userFullName),
                  const SizedBox(height: 8),
                  HomeQuote(
                    quote: _dailyQuote,
                  ),
                  const SizedBox(height: 16),
                  const HomeButtons()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
