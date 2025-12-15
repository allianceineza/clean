import 'package:flutter/material.dart';
import 'pages/schedule_page.dart';
import 'pages/recycle_page.dart';
import 'pages/events_page.dart';
import 'pages/tips_page.dart';
import 'pages/blog_page.dart';
import 'pages/donate_page.dart';
import 'screens/home_screen.dart';
import 'screens/support_screen.dart';
import 'screens/billing_screen.dart';
import 'screens/more_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const CleanRouteApp());
}

class CleanRouteApp extends StatelessWidget {
  const CleanRouteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanRoute Tech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      // Define routes here
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/schedule': (context) => const SchedulePage(),
        '/recycle': (context) => const RecyclePage(),
        '/events': (context) => const EventsPage(),
        '/tips': (context) => const TipsPage(),
        '/blog': (context) => const BlogPage(),
        '/donate': (context) => const DonatePage(),
        '/support': (context) => const SupportScreen(),
        '/billing': (context) => const BillingScreen(),
        '/more': (context) => const MoreScreen(),
      },
    );
  }
}
