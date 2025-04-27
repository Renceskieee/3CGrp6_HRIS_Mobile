import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sidebar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onNavItemSelect;
  final bool isExpanded;

  const Sidebar({
    super.key,
    required this.activeIndex,
    required this.onNavItemSelect,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 200 : 80,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(254, 249, 225, 1),
        border: Border(
          right: BorderSide(
            color: Color.fromRGBO(200, 200, 200, 1),
            width: 1.0,
          ),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildNavItem(0, 'assets/icons/dashboard.svg', 'Dashboard'),
            _buildNavItem(1, 'assets/icons/notification.svg', 'Notifications'),
            _buildNavItem(2, 'assets/icons/calendar.svg', 'Calendar'),
            const Divider(),
            _buildNavItem(3, 'assets/icons/settings.svg', 'Settings'),
            _buildNavItem(4, 'assets/icons/log-out.svg', 'Log Out'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    bool isActive = activeIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () => onNavItemSelect(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: isActive
                  ? const Color.fromRGBO(229, 208, 172, 1)
                  : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: isExpanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(163, 29, 29, 1),
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset(
                    iconPath,
                    height: 24,
                    width: 24,
                  ),
                ),
                if (isExpanded) ...[
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Color.fromRGBO(163, 29, 29, 1),
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
