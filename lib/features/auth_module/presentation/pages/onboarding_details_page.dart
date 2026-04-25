import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'package:lo2ta/features/auth_module/presentation/widgets/premium_button.dart';
import 'package:lo2ta/features/auth_module/presentation/pages/login_page.dart';

class LocationSelectionPage extends StatefulWidget {
  const LocationSelectionPage({super.key});
  @override
  State<LocationSelectionPage> createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  String? _selectedCity;
  final List<String> _cities = ['Cairo', 'Giza', 'Alexandria', 'Mansoura', 'Tanta', 'Port Said'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Location')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Select your city to see nearby deals',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32),
            Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5, crossAxisSpacing: 16, mainAxisSpacing: 16), itemCount: _cities.length, itemBuilder: (context, index) {
              bool isSelected = _selectedCity == _cities[index];
              return GestureDetector(
                onTap: () => setState(() => _selectedCity = _cities[index]),
                child: AnimatedContainer(
                  duration: 300.ms,
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color:
                          isSelected ? AppTheme.primaryColor : Colors.grey[300]!,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _cities[index],
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: (index * 100).ms).scale();
            })),
            PremiumButton(text: 'CONTINUE', onPressed: _selectedCity == null ? () {} : () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InterestSelectionPage()))),
          ],
        ),
      ),
    );
  }
}

class InterestSelectionPage extends StatefulWidget {
  const InterestSelectionPage({super.key});
  @override
  State<InterestSelectionPage> createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage> {
  final List<String> _interests = ['Supermarkets', 'Pharmacies', 'Electronics', 'Fashion', 'Beauty', 'Home', 'Health', 'Pets'];
  final Set<String> _selected = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interests')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'What are you looking for?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32),
            Expanded(child: Wrap(spacing: 12, runSpacing: 12, children: _interests.map((interest) {
              bool isSelected = _selected.contains(interest);
              return FilterChip(label: Text(interest), selected: isSelected, onSelected: (val) => setState(() { if (val) _selected.add(interest); else _selected.remove(interest); }), selectedColor: AppTheme.primaryColor.withOpacity(0.2), checkmarkColor: AppTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)));
            }).toList())),
            PremiumButton(text: 'FINISH', onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()))),
          ],
        ),
      ),
    );
  }
}
