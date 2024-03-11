// dashboard_link_widget.dart

import 'package:flutter/material.dart';

class DashboardLinkWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  DashboardLinkWidget({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18.0),
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}