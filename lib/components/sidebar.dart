import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hris_mobile/modals/logout_modal.dart';
import 'package:hris_mobile/pages/login.dart';

class Sidebar extends StatefulWidget {
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
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool isFormsExpanded = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.isExpanded ? 300 : 80,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(254, 249, 225, 1),
        border: Border(
          right: BorderSide(
            color: Color.fromRGBO(200, 200, 200, 1),
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildNavItem(0, 'assets/icons/dashboard.svg', 'Dashboard'),
          _buildNavItem(1, 'assets/icons/notification.svg', 'Notifications'),
          _buildNavItem(2, 'assets/icons/calendar.svg', 'Calendar'),
          const Divider(),
          _buildDropdownToggle(),
          if (isFormsExpanded && widget.isExpanded) ...[
            _buildSubItem(5, "Employee's Leave Card"),
            _buildSubItem(6, "Employee's Leave Card Back"),
            _buildSubItem(7, "Employee's Leave Form"),
            _buildSubItem(8, "Employee's Leave Form Back"),
          ],
          _buildNavItem(3, 'assets/icons/settings.svg', 'Settings'),
          _buildNavItem(4, 'assets/icons/log-out.svg', 'Log Out'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    bool isActive = widget.activeIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            if (label == 'Log Out') {
              showLogoutConfirmationDialog(context, () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              });
            } else {
              widget.onNavItemSelect(index);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
              mainAxisAlignment: widget.isExpanded
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
                if (widget.isExpanded) ...[
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

  Widget _buildDropdownToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            setState(() {
              isFormsExpanded = !isFormsExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: widget.isExpanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(163, 29, 29, 1),
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/forms.svg',
                    height: 24,
                    width: 24,
                  ),
                ),
                if (widget.isExpanded) ...[
                  const SizedBox(width: 12),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Expanded(
                          child: Text(
                            'Forms',
                            style: TextStyle(
                              color: Color.fromRGBO(163, 29, 29, 1),
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Icon(
                          isFormsExpanded
                              ? Icons.expand_less
                              : Icons.expand_more,
                          size: 20,
                          color: const Color.fromRGBO(163, 29, 29, 1),
                        ),
                      ],
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

  Widget _buildSubItem(int index, String label) {
    bool isActive = widget.activeIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            if (label == 'Log Out') {
              showLogoutConfirmationDialog(context, () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              });
            } else {
              widget.onNavItemSelect(index);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
              mainAxisAlignment: widget.isExpanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                const SizedBox(width: 4),
                SvgPicture.asset(
                  'assets/icons/form.svg',
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(163, 29, 29, 1),
                    BlendMode.srcIn,
                  ),
                ),
                if (widget.isExpanded) ...[
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
