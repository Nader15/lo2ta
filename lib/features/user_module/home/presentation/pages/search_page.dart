import 'package:flutter/material.dart';
import 'package:lo2ta/core/theme/app_theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFiltering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Container(
            height: 48,
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16)),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(hintText: 'Search products or stores', prefixIcon: Icon(Icons.search), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 10)),
            ),
          ),
        ),
        actions: [IconButton(icon: Icon(_isFiltering ? Icons.close : Icons.tune, color: AppTheme.primaryColor), onPressed: () => setState(() => _isFiltering = !_isFiltering))],
      ),
      body: Column(
        children: [
          if (_isFiltering) _buildFilterPanel(),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Discover the best deals near you',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPanel() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.grey[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Distance Range', style: Theme.of(context).textTheme.titleSmall),
          Slider(value: 5, min: 1, max: 20, onChanged: (v){}, activeColor: AppTheme.primaryColor),
          Text('Within 5.0 km', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 24),
          Text('Categories', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: ['Food', 'Health', 'Style', 'Home'].map((c) => Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(c), selected: false, onSelected: (v){}))).toList()),
          ),
        ],
      ),
    );
  }
}
