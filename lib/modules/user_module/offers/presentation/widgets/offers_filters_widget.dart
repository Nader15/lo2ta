import 'package:flutter/material.dart';
import 'package:lo2ta/core/theme/app_theme.dart';

class OffersFiltersWidget extends StatefulWidget {
  final Function(String?) onFilterChanged;
  final Function(bool) onNearestToggled;

  const OffersFiltersWidget({
    super.key,
    required this.onFilterChanged,
    required this.onNearestToggled,
  });

  @override
  State<OffersFiltersWidget> createState() => _OffersFiltersWidgetState();
}

class _OffersFiltersWidgetState extends State<OffersFiltersWidget> {
  String _selectedFilter = 'الكل';
  bool _isNearestSelected = false;

  final List<Map<String, String>> _filters = [
    {'label': 'الكل', 'emoji': '🌟'},
    {'label': 'الأقرب', 'emoji': '📍'},
    {'label': 'تسوق', 'emoji': '🛒'},
    {'label': 'اكل', 'emoji': '🍔'},
    {'label': 'مشروبات', 'emoji': '🥤'},
    {'label': 'حلواني', 'emoji': '🍰'},
    {'label': 'صيدليات', 'emoji': '💊'},
    {'label': 'ملابس', 'emoji': '👗'},
    {'label': 'احذية', 'emoji': '👟'},
    {'label': 'مكتبات', 'emoji': '📚'},
    {'label': 'جزارين', 'emoji': '🥩'},
    {'label': 'دواجن', 'emoji': '🍗'},

  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter['label'];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter['label']!;
                if (filter['label'] == 'الأقرب') {
                  _isNearestSelected = true;
                  widget.onNearestToggled(true);
                  // Don't change category filter if nearest is toggled? 
                  // Actually, let's treat "الأقرب" as a category filter for now or a sort toggle.
                  // Usually, users want to see nearest among all or within a category.
                  // For simplicity, let's make it a mutually exclusive filter for now.
                  widget.onFilterChanged(null);
                } else {
                  _isNearestSelected = false;
                  widget.onNearestToggled(false);
                  widget.onFilterChanged(filter['label'] == 'الكل' ? null : filter['label']);
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          AppTheme.primaryColor,
                          AppTheme.primaryColor.withValues(alpha: 0.8),
                        ],
                      )
                    : null,
                color: isSelected ? null : Colors.white.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : AppTheme.primaryColor.withValues(alpha: 0.1),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryColor.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  Text(
                    filter['emoji']!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    filter['label']!,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
