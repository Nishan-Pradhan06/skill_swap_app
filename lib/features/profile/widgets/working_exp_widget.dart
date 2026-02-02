import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/utils/image_url_utils.dart';

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
        imageUrl.startsWith('http')
            ? Image.network(
                ImageUrlUtils.getImageUrl(imageUrl),
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              )
            : Image.file(
                File(imageUrl),
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
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
