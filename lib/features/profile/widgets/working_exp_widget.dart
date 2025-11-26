import 'package:flutter/material.dart';

class WorkingExprienceList extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String companyName;
  final String location;
  final String experience;

  const WorkingExprienceList({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.companyName,
    required this.location,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(imageUrl, height: 60),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextTheme.of(
                context,
              ).bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(companyName),
            Text(
              location,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
            ),
            Text(
              experience,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
            ),
          ],
        ),
      ],
    );
  }
}
