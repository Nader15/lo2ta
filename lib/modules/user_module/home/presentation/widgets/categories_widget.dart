import 'package:flutter/material.dart';

class DrinkCategory {
  final String name;
  final Color bgColor;
  final String emoji;

  const DrinkCategory({
    required this.name,
    required this.bgColor,
    required this.emoji,
  });
}

class CategoriesWidget extends StatefulWidget {
  CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget>
    with SingleTickerProviderStateMixin {
  final List<DrinkCategory> categories = [
    DrinkCategory(name: 'Energy Drink', bgColor: Color(0xFF7B5FD4), emoji: '⚡'),
    DrinkCategory(name: 'Chocolate', bgColor: Color(0xFFD4A574), emoji: '🍫'),
    DrinkCategory(name: 'Milk Drinks', bgColor: Color(0xFFB0C4E8), emoji: '🥛'),
    DrinkCategory(name: 'Zero Sugar', bgColor: Color(0xFFA8D8A8), emoji: '🌿'),
  ];

  int _selectedCategory = 0;

  late AnimationController _heroController;

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = _selectedCategory == index;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedCategory = index);
              _heroController.forward(from: 0);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 80,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: cat.bgColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        cat.emoji,
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cat.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: 10.5,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFF6B4FD4)
                              : Colors.black54,
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
