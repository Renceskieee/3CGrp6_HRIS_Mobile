import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // ... (existing code)
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ... (existing code)
  @override
  Widget build(BuildContext context) {
    // ... (existing code)
    return Scaffold(
      // ... (existing code)
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ... (existing code)
            _buildFormsCard(),
            const SizedBox(height: 16),
            _buildPromoCard(
              iconPath: 'assets/icons/organization.svg',
              label: 'Organization',
              description: 'View your organization details.',
              buttonText: 'View',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Organization clicked')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormsCard() {
    // ... (existing code)
  }

  Widget _buildPromoCard({
    required String iconPath,
    required String label,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    // ... (existing code)
  }
} 