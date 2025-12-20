import 'package:flutter/material.dart';

// Import your app files
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

// Database imports - simple and clean
import 'database/database_helper.dart';

void main() {
  // Initialize database FIRST
  DatabaseHelper.initialize();
  
  // Run the app
  runApp(const CleanRouteApp());
}

class CleanRouteApp extends StatelessWidget {
  const CleanRouteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanRoute Tech',
      debugShowCheckedModeBanner: false,
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