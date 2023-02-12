import 'package:flutter/material.dart';

import 'applied_internships.dart';
import 'posted internships/posted_internships.dart';

class InternshipTabView extends StatelessWidget {
  const InternshipTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: const Color(0xFFF7F6F8),
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              labelColor: const Color(0xFF4D5470),
              unselectedLabelStyle: const TextStyle(fontSize: 20),
              labelStyle: const TextStyle(fontSize: 20),
              indicatorColor: Colors.black.withOpacity(0.7),
              tabs: const [
                Tab(
                  text: "Applications",
                ),
                Tab(
                  text: "Posted",
                ),
              ],
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: TabBarView(
            children: [
              AppliedInternships(),
              PostedInternships(),
            ],
          ),
        ),
      ),
    );
  }
}
