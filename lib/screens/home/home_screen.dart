import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hero_minds/controllers/home_controller.dart';
import 'package:hero_minds/provider/theme_provider.dart';
import 'package:hero_minds/screens/home/profile_screen.dart';
import 'package:hero_minds/widgets/Common/custom_app_bar.dart';
import 'package:hero_minds/widgets/Common/gradient_layer.dart';
import 'package:hero_minds/widgets/Home/home_buttons.dart';
import 'package:hero_minds/widgets/Home/home_greeting_text.dart';
import 'package:hero_minds/widgets/Home/home_quote.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _userFullName = 'User';
  String _dailyQuote = 'Quote of the day!';
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
        useSafeArea: true,
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
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GreetingText(userFullName: _userFullName),
                          const SizedBox(height: 8),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: HomeQuote(
                              key: ValueKey<String>(_dailyQuote),
                              quote:
                                  '💡$_dailyQuote', // Adding light bulb emoji
                            ),
                          ),
                          const SizedBox(height: 16),
                          const HomeButtons()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
