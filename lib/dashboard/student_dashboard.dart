import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/authentication_screens/signin.dart';
import 'package:school_management_system/dashboard/Drawer_Screens/NoticesScreen.dart';
import 'package:school_management_system/dashboard/Drawer_Screens/admitcardScreen.dart';

import 'package:school_management_system/dashboard/Drawer_Screens/attendance_screen.dart';
import 'package:school_management_system/dashboard/Drawer_Screens/compositeMarksheetScreen.dart';
import 'package:school_management_system/dashboard/Drawer_Screens/profile_screen.dart';
import 'package:school_management_system/dashboard/Drawer_Screens/singleMarksheetScreen.dart';
import 'package:school_management_system/dashboard/Drawer_Screens/student_fee_screen.dart';

import 'package:school_management_system/dashboard/sections/dashboard_cards_row/dashboard_cards_row.dart';
import 'package:school_management_system/dashboard/sections/noticesSection.dart';
import 'package:school_management_system/dashboard/sections/userIDSection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/theme_controller.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> spClear() async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    // CRITICAL: DO NOT set backgroundColor on Scaffold
    // Let it inherit from theme
    return Scaffold(
      key: _scaffoldKey,
      // ❌ DO NOT DO THIS: backgroundColor: Colors.white,
      // ❌ DO NOT DO THIS: backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // ✅ Just leave it empty - it will use the theme automatically
      
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text('Student Dashboard'),
        actions: [
          // Theme toggle button with Obx for reactive icon
          Obx(() => IconButton(
                onPressed: () {
                  themeController.toggleTheme();
                  print('Theme toggled! Dark mode: ${themeController.isDarkMode}');
                },
                icon: Icon(
                  themeController.isDarkMode 
                      ? Icons.light_mode 
                      : Icons.dark_mode,
                ),
                tooltip: themeController.isDarkMode 
                    ? 'Switch to Light Mode' 
                    : 'Switch to Dark Mode',
              )),

          // Sign Out button
          TextButton(
            onPressed: () async {
              await spClear();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SigninScreen(),
                  ),
                );
              }
            },
            child: Text(
              "Sign out",
              style: TextStyle(
                color: Theme.of(context).appBarTheme.foregroundColor,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text(
                      "L",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Student Name",
                    style: TextStyle(
                      color: Theme.of(context).appBarTheme.foregroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "student@email.com",
                    style: TextStyle(
                      color: Theme.of(context).appBarTheme.foregroundColor?.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Drawer items
            ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            const Divider(height: 1),

            ListTile(
              leading: Icon(
                Icons.event_available,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "Attendance",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendanceScreen()),
                );
              },
            ),
            const Divider(height: 1),

            ListTile(
              leading: Icon(
                Icons.grading,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "Academic Progress",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MarksheetScreen()),
                ); 
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: Icon(
                Icons.grading,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "Composite Marksheet",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompositeMarksheetScreen()),
                ); 
              },
            ),
            const Divider(height: 1),

            ListTile(
              leading: Icon(
                Icons.payments,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "Fee Details",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentFeeScreen()),
                );
              },
            ),
            const Divider(height: 1),
             ListTile(
              leading: Icon(Icons.notifications_none_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "Notices",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoticesScreen()),
                );
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: Icon(Icons.notifications_none_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "Admit Card",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdmitCardScreen()),
                );
              },
            ),
            const Divider(height: 1),

          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            children: const [
              // User ID Section
              UserIDSection(),
              SizedBox(height: 15),

              // Notices Section (Horizontal Scroll)
              NoticesSection(),
              SizedBox(height: 20),

              // Dashboard Cards Row (3 cards)
              DashboardCardsRow(),
            ],
          ),
        ),
      ),
    );
  }
}