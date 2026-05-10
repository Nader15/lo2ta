import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'package:lo2ta/modules/user_module/home/presentation/pages/home_page.dart';
import 'package:lo2ta/modules/user_module/profile/presentation/pages/profile_page.dart';

import 'package:lo2ta/modules/user_module/offers/presentation/pages/offers_page.dart';
import 'package:lo2ta/modules/user_module/stores/presentation/pages/stores_page.dart';

// ─── Nav Item Model ──────────────────────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

const List<_NavItem> _navItems = [
  _NavItem(
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    label: 'الرئيسية',
  ),
  _NavItem(
    icon: Icons.local_offer,
    activeIcon: Icons.local_offer,
    label: 'عروض لقطة',
  ),
  _NavItem(
    icon: Icons.store,
    activeIcon: Icons.store,
    label: 'أماكن',
  ),
  _NavItem(
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
    label: 'حسابي',
  ),
];

// ─── Main Wrapper ────────────────────────────────────────────────────────────

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  final List<Widget> _pages = [
    UserHomePage(),
    const OffersListPage(),
    const StoresListPage(),
    const ProfilePage(),
  ];

  void _onTap(int val) {
    HapticFeedback.lightImpact();
    setState(() => _index = val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // content flows under the floating navbar
      backgroundColor: Colors.transparent,
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: _AppBottomNavbar(
        currentIndex: _index,
        onTap: _onTap,
      ),
    );
  }
}

// ─── Glassmorphic Bottom Navbar ──────────────────────────────────────────────

class _AppBottomNavbar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _AppBottomNavbar({required this.currentIndex, required this.onTap});

  @override
  State<_AppBottomNavbar> createState() => _AppBottomNavbarState();
}

class _AppBottomNavbarState extends State<_AppBottomNavbar>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnims;
  late List<Animation<double>> _slideAnims;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _navItems.length,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );
    _scaleAnims = _controllers
        .map(
          (c) => Tween<double>(
            begin: 1.0,
            end: 1.15,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOutBack)),
        )
        .toList();
    _slideAnims = _controllers
        .map(
          (c) => Tween<double>(
            begin: 0.0,
            end: -5.0,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOutCubic)),
        )
        .toList();

    _controllers[widget.currentIndex].forward();
  }

  @override
  void didUpdateWidget(_AppBottomNavbar old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      _controllers[old.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding + 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            // height: 68,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.88),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: AppTheme.accentColor.withValues(alpha: 0.13),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentColor.withValues(alpha: 0.13),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) {
                return _NavButton(
                  item: _navItems[index],
                  isActive: widget.currentIndex == index,
                  scaleAnim: _scaleAnims[index],
                  slideAnim: _slideAnims[index],
                  onTap: () => widget.onTap(index),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Individual Nav Button ───────────────────────────────────────────────────

class _NavButton extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final Animation<double> scaleAnim;
  final Animation<double> slideAnim;
  final VoidCallback onTap;

  const _NavButton({
    required this.item,
    required this.isActive,
    required this.scaleAnim,
    required this.slideAnim,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        height: 68,
        child: AnimatedBuilder(
          animation: scaleAnim,
          builder: (context, child) => Transform.translate(
            offset: Offset(0, slideAnim.value),
            child: Transform.scale(scale: scaleAnim.value, child: child),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Icon pill ─────────────────────────────────────────
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                width: isActive ? 52 : 40,
                height: 34,
                decoration: isActive
                    ? BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.accentColor,
                            AppTheme.accentColor.withValues(alpha: 0.75),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.accentColor.withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      )
                    : null,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, anim) =>
                        ScaleTransition(scale: anim, child: child),
                    child: Icon(
                      isActive ? item.activeIcon : item.icon,
                      key: ValueKey(isActive),
                      size: 22,
                      color: isActive ? Colors.white : const Color(0xFFAAAAAA),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // ── Label ─────────────────────────────────────────────
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: isActive
                      ? AppTheme.accentColor
                      : const Color(0xFFAAAAAA),
                  fontWeight: FontWeight.w600,
                ),
                child: Text(item.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
