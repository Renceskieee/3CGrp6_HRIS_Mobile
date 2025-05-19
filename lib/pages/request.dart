// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hris_mobile/forms/leave_request.dart';
import 'package:hris_mobile/forms/payroll_request.dart';
import 'package:hris_mobile/forms/employment_request.dart';
import 'package:hris_mobile/pages/settings.dart';

class RequestScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  const RequestScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Leave Request',
      'Payroll and Compensation Request',
      'Employment and Documentation Request',
    ];

    void handleCategoryTap(String category) {
      if (category == 'Leave Request') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LeaveRequestScreen()),
        );
      } else if (category == 'Payroll and Compensation Request') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PayrollRequestScreen()),
        );
      } else if (category == 'Employment and Documentation Request') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EmploymentRequestScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$category clicked')));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(109, 35, 35, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Request Categories',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(109, 35, 35, 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            Icons.person,
                            size: 30,
                            color: Color.fromRGBO(109, 35, 35, 1),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => SettingsPage(
                                      user: user,
                                      onProfileUpdated: (updatedUser) {
                                        // Handle profile update if needed
                                      },
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user['f_name']} ${user['l_name']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'HRIS User',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ...categories.map((category) {
              return ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/form.svg',
                  width: 24,
                  height: 24,
                  color: const Color.fromRGBO(109, 35, 35, 1),
                ),
                title: Text(
                  category,
                  style: const TextStyle(color: Color.fromRGBO(109, 35, 35, 1)),
                ),
                tileColor: const Color.fromRGBO(229, 208, 172, 1),
                onTap: () {
                  Navigator.pop(context);
                  handleCategoryTap(category);
                },
              );
            }),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            color: const Color.fromRGBO(229, 208, 172, 1),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: InkWell(
              onTap: () => handleCategoryTap(categories[index]),
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 120,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/form.svg',
                      width: 40,
                      height: 40,
                      color: const Color.fromRGBO(109, 35, 35, 1),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            categories[index],
                            style: const TextStyle(
                              color: Color.fromRGBO(109, 35, 35, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Click to submit a new request',
                            style: TextStyle(
                              color: Colors.brown[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromRGBO(109, 35, 35, 1),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
