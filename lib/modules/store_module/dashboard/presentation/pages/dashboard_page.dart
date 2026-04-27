import 'package:flutter/material.dart';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'package:lo2ta/modules/auth_module/presentation/widgets/premium_button.dart';

class StoreDashboardPage extends StatelessWidget {
  const StoreDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                children: [
                  CircleAvatar(radius: 24, backgroundColor: AppTheme.primaryColor, child: Icon(Icons.store, color: Colors.white)),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome Back,', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                      Text('Store Name', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text('Performance Stats', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildStatCard('Active Offers', '12', Icons.local_offer, Colors.blue, context),
                  _buildStatCard('Total Clicks', '1.2k', Icons.touch_app, Colors.orange, context),
                  _buildStatCard('Profile Views', '340', Icons.visibility, Colors.green, context),
                  _buildStatCard('Followers', '85', Icons.favorite, Colors.red, context),
                ],
              ),
              const SizedBox(height: 32),
              Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              PremiumButton(
                text: 'CREATE NEW OFFER',
                onPressed: () {
                  // Navigate to Offer Form here soon
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  side: const BorderSide(color: AppTheme.primaryColor),
                ),
                onPressed: () {},
                child: Text('VIEW STORE PROFILE', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppTheme.primaryColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          Text(title, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
