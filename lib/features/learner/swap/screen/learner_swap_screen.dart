import 'package:flutter/material.dart';

class LearnerSwapScreen extends StatelessWidget {
  const LearnerSwapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Swaps'),
          scrolledUnderElevation: 0,
          elevation: 0,
          centerTitle: false,
          bottom: TabBar(
            isScrollable: true,
            splashBorderRadius: BorderRadius.all(Radius.circular(8)),
            tabAlignment: TabAlignment.start,
            padding: EdgeInsets.symmetric(horizontal: 10),
            labelPadding: EdgeInsets.symmetric(horizontal: 15),
            dividerColor: Theme.of(context).colorScheme.surface,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Pending Swaps')),
            Center(child: Text('Active Swaps')),
            Center(child: Text('Completed Swaps')),
          ],
        ),
      ),
    );
  }
}
