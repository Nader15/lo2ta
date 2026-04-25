import 'package:flutter/material.dart';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'package:lo2ta/features/store_module/dashboard/presentation/pages/dashboard_page.dart';
import 'package:lo2ta/features/store_module/manage_offers/presentation/pages/manage_offers_page.dart';
import 'package:lo2ta/features/user_module/home/presentation/pages/profile_page.dart';

class StoreMainWrapper extends StatefulWidget {
  const StoreMainWrapper({super.key});
  @override
  State<StoreMainWrapper> createState() => _StoreMainWrapperState();
}

class _StoreMainWrapperState extends State<StoreMainWrapper> {
  int _index = 0;
  final List<Widget> _pages = [
    const StoreDashboardPage(),
    const ManageOffersPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (val) => setState(() => _index = val),
        selectedItemColor: AppTheme.primaryColor,
        items: const [BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Stats'), BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Offers'), BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')],
      ),
    );
  }
}
