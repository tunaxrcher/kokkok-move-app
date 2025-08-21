import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_router.dart';
import 'home_content.dart';
import '../../../profile/presentation/widgets/my_pages_drawer.dart';

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<BottomNavigationBarItem> _navItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'โปรไฟล์',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.history_outlined),
      activeIcon: Icon(Icons.history),
      label: 'ประวัติ',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'หน้าแรก',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.support_agent_outlined),
      activeIcon: Icon(Icons.support_agent),
      label: 'ติดต่อ',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings),
      label: 'ตั้งค่า',
    ),
  ];

  final List<String> _routes = [
    AppRoutes.myPages,
    AppRoutes.history,
    AppRoutes.home,
    AppRoutes.contact,
    AppRoutes.settings,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    context.go(_routes[index]);
  }

  int _getIndexFromLocation(String location) {
    if (location == AppRoutes.myPages || location.startsWith('/profile'))
      return 0;
    if (location == AppRoutes.history) return 1;
    if (location == AppRoutes.home) return 2;
    if (location == AppRoutes.contact) return 3;
    if (location == AppRoutes.settings) return 4;
    return 2; // Default to home
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'หน้าของฉัน';
      case 1:
        return 'ประวัติการเดินทาง';
      case 2:
        return 'หน้าแรก';
      case 3:
        return 'ติดต่อเรา';
      case 4:
        return 'ตั้งค่า';
      default:
        return 'KOKKOK Move';
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    _currentIndex = _getIndexFromLocation(location);

    return Scaffold(
      appBar:
          _currentIndex !=
              2 // Show AppBar for other tabs, not Home
          ? AppBar(title: Text(_getPageTitle(_currentIndex)))
          : null,
      body: _currentIndex == 2 ? const HomeContent() : widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: _navItems,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.onSurfaceVariant,
        backgroundColor: AppColors.surface,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
