import 'package:flutter/material.dart';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'package:lo2ta/features/auth_module/presentation/widgets/premium_button.dart';

class CreateOfferPage extends StatefulWidget {
  const CreateOfferPage({super.key});
  @override
  State<CreateOfferPage> createState() => _CreateOfferPageState();
}

class _CreateOfferPageState extends State<CreateOfferPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _categories = ['Supermarket', 'Pharmacy', 'Fashion', 'Bakery'];
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Deal')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180, width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey[200]!)),
                child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_a_photo_outlined, size: 40, color: Colors.grey), SizedBox(height: 8), Text('Product Image')]),
              ),
              const SizedBox(height: 32),
              TextFormField(decoration: const InputDecoration(labelText: 'Title', hintText: 'e.g. 50% OFF Fresh Milk')),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(child: TextFormField(decoration: const InputDecoration(labelText: 'Original Price'))),
                const SizedBox(width: 16),
                Expanded(child: TextFormField(decoration: const InputDecoration(labelText: 'Offer Price'))),
              ]),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _selectedCategory = v),
              ),
              const SizedBox(height: 48),
              PremiumButton(text: 'PUBLISH OFFER', onPressed: () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }
}
