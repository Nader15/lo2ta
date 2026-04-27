import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'package:lo2ta/modules/auth_module/presentation/cubits/auth_cubit.dart';
import 'package:lo2ta/modules/auth_module/presentation/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Account')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: AppTheme.primaryColor,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'User Full Name',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'user@example.com',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 48),
              _buildListTile(Icons.favorite_border, 'My Favorites', () {}, context),
              _buildListTile(Icons.history, 'Recently Viewed', () {}, context),
              _buildListTile(
                Icons.notifications_none,
                'Notification Settings',
                () {},
                context
              ),
              _buildListTile(Icons.help_outline, 'Help & Support', () {}, context),
              const Divider(height: 40),
              _buildListTile(
                Icons.logout,
                'Log Out',
                () => context.read<AuthCubit>().logout(),
                color: Colors.red,
                context
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(
    IconData icon,
    String title,
    VoidCallback onTap,
    BuildContext context, {
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black87),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
