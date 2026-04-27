import 'package:flutter/material.dart';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'create_offer_page.dart';

class ManageOffersPage extends StatelessWidget {
  const ManageOffersPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Offers')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(width: 60, height: 60, decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.local_offer, color: AppTheme.primaryColor)),
            title: Text('Deal Title Here', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
            subtitle: const Text('Ends in 5 days'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}), IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () {})]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateOfferPage())),
        label: const Text('ADD DEAL'),
        icon: const Icon(Icons.add),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}
