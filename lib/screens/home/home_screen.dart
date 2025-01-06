import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:hero_minds/controllers/home_controller.dart';
import 'package:hero_minds/provider/theme_provider.dart';
import 'package:hero_minds/screens/home/profile_screen.dart';
import 'package:hero_minds/widgets/Common/custom_app_bar.dart';
import 'package:hero_minds/widgets/Common/gradient_layer.dart';
import 'package:hero_minds/widgets/Home/home_buttons.dart';
import 'package:hero_minds/widgets/Home/home_greeting_text.dart';
import 'package:hero_minds/widgets/Home/home_quote.dart';
import 'package:hero_minds/widgets/Popup/popup_screen.dart';
import 'package:hero_minds/widgets/Popup/daily_checkin_pop.dart';
import 'package:hero_minds/controllers/daily_checkin_controller.dart';
import 'package:hero_minds/screens/daily-checkin/daily_checkin_screen.dart';
import 'package:hero_minds/provider/auth_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _userFullName = 'User';
  String _dailyQuote = 'Quote of the day!';
  final UserController _userController = UserController();
  final _dailyCheckInController = DailyCheckInController(); // Define controller

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _fetchData(); // Fetch user and quote data

    final showPopup =
        await _shouldShowPopup(); // Check if popup should be shown by date
    if (showPopup) {
      await _showDailyQuotePopup(); // daily quote popup
      _showDailyCheckInPopup(); // daily checkin pop after quote popup
    }
  }

  Future<void> _fetchData() async {
    try {
      final user = await _userController.fetchUserData();
      final quote = await _userController.fetchDailyQuote();
      setState(() {
        _userFullName = user?.firstName ?? 'User';
        _dailyQuote = quote ?? 'No quote available today!';
      });
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
  }

  Future<bool> _shouldShowPopup() async {
    try {
      final userId = "u_id";
      final databaseRef = FirebaseDatabase.instance.ref();
      final snapshot = await databaseRef
          .child('users/$userId/daily_checkin/lastSeenDate')
          .get();

      if (snapshot.exists) {
        final lastSeenDate = snapshot.value as String;
        final currentDate = DateFormat('MMMM d, yyyy').format(DateTime.now());

        debugPrint("Last seen date: $lastSeenDate");
        debugPrint("Current date: $currentDate");

        if (lastSeenDate == currentDate) {
          return false; // Popup already shown today
        }
      }
    } catch (e) {
      debugPrint("Error fetching last seen date: $e");
    }
    return true; // Show popup if no date is stored or it's a new day
  }

  Future<void> _updateLastSeenDate() async {
    try {
      final userId = ref.read(authProvider).userId;
      final currentDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
      final databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef
          .child('users/$userId/daily_checkin/$currentDate')
          .update({'last_seen_date': currentDate});
      debugPrint("Last seen date updated to: $currentDate");
    } catch (e) {
      debugPrint("Error updating last seen date: $e");
    }
  }

  Future<void> _showDailyQuotePopup() async {
    if (_dailyQuote.isNotEmpty) {
      // Await the completion of the dialog to ensure sequential flow
      await showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissal by tapping outside
        builder: (BuildContext context) {
          return DailyQuotePopup(
            quote: _dailyQuote,
            onClose: () async {
              await _updateLastSeenDate(); // Save the current date in the database
              Navigator.of(context).pop(); // Close the popup
            },
          );
        },
      );
    }
  }

  // void _showDailyCheckInPopup() {
  //   final userId = ref.read(authProvider).userId;
  //   final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //   _dailyCheckInController
  //       .isDailyCheckInCompleted(userId!, currentDate)
  //       .then((isCompleted) {
  //     if (!isCompleted) {
  //       showDialog(
  //         context: context,
  //         barrierDismissible:
  //             false, // Prevent dismissing the popup without action
  //         builder: (BuildContext context) {
  //           return DailyCheckInPopup(
  //             onNavigateToCheckIn: () {
  //               // Navigator.of(context).pop(); // Close the popup
  //               // Navigate directly without using named routes
  //               Navigator.of(context).push(
  //                 MaterialPageRoute(
  //                   builder: (context) =>
  //                       DailyCheckInScreen(), // Replace with your widget
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //       );
  //     }
  //   }).catchError((error) {
  //     debugPrint("Error checking daily check-in status: $error");
  //   });
  // }
  void _showDailyCheckInPopup() {
    final userId = ref.read(authProvider).userId;

    if (userId == null) {
      debugPrint("Error: User ID is null. Cannot proceed with daily check-in.");
      return; // Exit early if userId is null
    }

    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    _dailyCheckInController
        .isDailyCheckInCompleted(userId, currentDate)
        .then((isCompleted) {
      if (!isCompleted) {
        showDialog(
          context: context,
          barrierDismissible:
              false, // Prevent dismissing the popup without action
          builder: (BuildContext context) {
            return DailyCheckInPopup(
              onNavigateToCheckIn: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        DailyCheckInScreen(), // Replace with your widget
                  ),
                );
              },
            );
          },
        );
      }
    }).catchError((error) {
      debugPrint("Error checking daily check-in status: $error");
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
      builder: (ctx) => const ProfilePage(),
    );
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
                  onPressed: _openProfileOverlay,
                ),
                GradientLayer(colors: [
                  Colors.black.withOpacity(0.2),
                  ...theme.backgroundGradient,
                ]),
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
                              quote: '💡 $_dailyQuote',
                            ),
                          ),
                          const SizedBox(height: 16),
                          const HomeButtons(),
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
