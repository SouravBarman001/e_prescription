import 'package:flutter/material.dart';
import 'package:flutter_prescription/features/prescription/views/prescription_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Import your existing screens
// import 'prescription_screen_new.dart';
// import 'theme.dart';

class MainLayoutDashboardScreen extends StatefulWidget {
  const MainLayoutDashboardScreen({super.key});

  @override
  State<MainLayoutDashboardScreen> createState() => _MainLayoutDashboardScreenState();
}

class _MainLayoutDashboardScreenState extends State<MainLayoutDashboardScreen> {
  int _selectedIndex = 0;
  bool _isSidebarExpanded = true;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.dashboard_outlined,
      activeIcon: Icons.dashboard,
      label: 'Dashboard',
    ),
    NavigationItem(
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today,
      label: 'Appointments',
    ),
    NavigationItem(
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      label: 'Patients',
    ),
    NavigationItem(
      icon: Icons.video_call_outlined,
      activeIcon: Icons.video_call,
      label: 'Telemedicine',
    ),
    NavigationItem(
      icon: Icons.description_outlined,
      activeIcon: Icons.description,
      label: 'Prescription',
    ),
    NavigationItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      body: Row(
        children: [
          // Sidebar - Hidden on mobile
          if (!isMobile)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _isSidebarExpanded ? 250.w : 70.w,
              child: _buildSidebar(),
            ),

          // Main content area
          Expanded(
            child: Column(
              children: [
                _buildTopBar(isMobile),
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ],
      ),
      // Mobile drawer
      drawer: isMobile ? _buildMobileDrawer() : null,
    );
  }

  Widget _buildSidebar() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Logo section
          Container(
            height: 70.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A9B8E),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(
                    Icons.local_hospital,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                if (_isSidebarExpanded) ...[
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'MediCare',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),

          // Navigation items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: _navigationItems.length,
              itemBuilder: (context, index) {
                return _buildNavItem(index);
              },
            ),
          ),

          // Collapse button
          Divider(height: 1, color: Colors.grey.shade200),
          InkWell(
            onTap: () {
              setState(() {
                _isSidebarExpanded = !_isSidebarExpanded;
              });
            },
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Icon(
                    _isSidebarExpanded
                        ? Icons.chevron_left
                        : Icons.chevron_right,
                    color: Colors.grey.shade600,
                  ),
                  if (_isSidebarExpanded) ...[
                    SizedBox(width: 12.w),
                    Text(
                      'Collapse',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = _navigationItems[index];
    final isSelected = _selectedIndex == index;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF4A9B8E).withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? item.activeIcon : item.icon,
                  color: isSelected
                      ? const Color(0xFF4A9B8E)
                      : Colors.grey.shade600,
                  size: 22,
                ),
                if (_isSidebarExpanded) ...[
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected
                            ? const Color(0xFF4A9B8E)
                            : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF4A9B8E),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.local_hospital,
                      color: Color(0xFF4A9B8E),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'MediCare',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _navigationItems.length,
                itemBuilder: (context, index) {
                  final item = _navigationItems[index];
                  final isSelected = _selectedIndex == index;
                  return ListTile(
                    leading: Icon(
                      isSelected ? item.activeIcon : item.icon,
                      color: isSelected
                          ? const Color(0xFF4A9B8E)
                          : Colors.grey.shade600,
                    ),
                    title: Text(
                      item.label,
                      style: TextStyle(
                        fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected
                            ? const Color(0xFF4A9B8E)
                            : Colors.grey.shade700,
                      ),
                    ),
                    selected: isSelected,
                    selectedTileColor:
                    const Color(0xFF4A9B8E).withOpacity(0.1),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(bool isMobile) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          // Menu button for mobile
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),

          // Clinic selector
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF4A9B8E),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 8.w),
                if (!isMobile)
                  const Text(
                    'All Clinics',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                SizedBox(width: 4.w),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),

          const Spacer(),

          // Search bar (hide on small mobile)
          if (!isMobile || MediaQuery.of(context).size.width > 600)
            Container(
              width: 300.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by patient name or ID, age, date',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade500,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                ),
              ),
            ),

          SizedBox(width: 16.w),

          // Notifications
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, size: 24),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),

          SizedBox(width: 8.w),

          // Settings
          IconButton(
            icon: const Icon(Icons.settings_outlined, size: 24),
            onPressed: () {},
          ),

          SizedBox(width: 8.w),

          // User profile (hide text on mobile)
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFF4A9B8E),
                  child: const Text(
                    'KN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (!isMobile) ...[
                  SizedBox(width: 8.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Katerina Neilson',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      Text(
                        'My profile',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    // Return different screens based on selected index
    switch (_selectedIndex) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const AppointmentsScreen();
      case 2:
        return const PatientsScreen();
      case 3:
        return const TelemedicineScreen();
      case 4:
        return const PrescriptionScreenNew();
      // Return your PrescriptionScreenNew here
      //   return const Center(
      //     child: Text('Prescription Screen - Use PrescriptionScreenNew()'),
      //   );
      case 5:
        return const SettingsScreen();
      default:
        return const DashboardScreen();
    }
  }
}

// Navigation Item Model
class NavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

// Placeholder Dashboard Screen
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width < 768 ? 1 :
              MediaQuery.of(context).size.width < 1024 ? 2 : 4,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard(
                  'Total Patients',
                  '1,234',
                  Icons.people,
                  const Color(0xFF4A9B8E),
                ),
                _buildStatCard(
                  'Appointments Today',
                  '45',
                  Icons.calendar_today,
                  const Color(0xFF7C4DFF),
                ),
                _buildStatCard(
                  'Pending Tests',
                  '23',
                  Icons.science,
                  const Color(0xFFFF9800),
                ),
                _buildStatCard(
                  'Prescriptions',
                  '89',
                  Icons.description,
                  const Color(0xFF4CAF50),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Placeholder screens
class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Appointments Screen'));
  }
}

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Patients Screen'));
  }
}

class TelemedicineScreen extends StatelessWidget {
  const TelemedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Telemedicine Screen'));
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings Screen'));
  }
}

// AppTheme class (use your existing theme.dart)
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF1976D2),
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1976D2)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF1976D2)),
      dividerColor: Colors.grey.shade300,
    );
  }
}