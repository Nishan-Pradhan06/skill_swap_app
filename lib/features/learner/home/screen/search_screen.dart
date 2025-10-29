import 'package:flutter/material.dart';
import 'package:skill_swap/core/widgets/custom_appbar.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_padding.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allItems = [
    'Apple',
    'Banana',
    'Cherry',
    'Mango',
    'Orange',
    'Pineapple',
  ];
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
    _searchController.addListener(_filterList);
  }

  void _filterList() {
    setState(() {
      _filteredItems = _allItems
          .where(
            (item) => item.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkTextTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: CustomPadding(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(),
              CustomTextField(
                hint: 'Search',
                borderColor: Colors.transparent,
                borderRadius: 18,
                leading: Icon(Icons.search),
                controller: _searchController,
                type: CustomTextFieldType.text,
                fillColor: darkTextTheme
                    ? const Color(0XFF272c29)
                    : AppTheme.surfaceLight,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredItems.length,
                  itemBuilder: (_, index) {
                    final item = _filteredItems[index];
                    return ListTile(
                      title: Text(item),
                      onTap: () => Navigator.pop(context, item),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
