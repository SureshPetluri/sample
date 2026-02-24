import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/app/routes/app_routes.dart';
import 'package:sample/core/utils/navigation_utils.dart';

class DashBoardPage extends ConsumerWidget {
  final Widget child;

  const DashBoardPage({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final bool isHome =
        location == AppRoutes.groceriesHome ||
        location == AppRoutes.assistantHome;

    int activeTabIndex =
        (location == AppRoutes.assistantHome ||
            location.startsWith('${AppRoutes.assistantHome}/'))
        ? 1
        : 0;

    const Color primaryTeal = Color(0xFF003D3D);

    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Standard Zepto Header
            Container(
              // color: primaryTeal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  // Location Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: const [
                            Flexible(
                              child: Text(
                                'Serilingampally - Hitech City Main Road...',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.wallet,
                                  color: Colors.deepPurple,
                                  size: 14,
                                ),
                                SizedBox(width:2),
                                Text(
                                  '₹0',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 6),
                          InkWell(
                            onTap: (){
                              NavigationUtils.push(context,AppRoutes.profile);
                            },
                            child: Icon(
                              Icons.account_circle,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  if (isHome) ...[
                    const SizedBox(height: 4),
                    // Tabs Row
                    Row(
                      children: [
                        Flexible(
                          child: _buildCustomTab(
                            label: 'Sample',
                            isActive: activeTabIndex == 0,
                            onTap: () => NavigationUtils.go(context,AppRoutes.groceriesHome),
                            primaryColor: primaryTeal,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: _buildCustomTab(
                            label: 'Assistance',
                            isActive: activeTabIndex == 1,
                            onTap: () => NavigationUtils.go(context,AppRoutes.assistantHome),
                            primaryColor: primaryTeal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTab({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    required Color primaryColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(6),
          // In the image, the active tab looks like it's embossed or has a slight border
          border: isActive
              ? Border.all(color: Colors.white.withOpacity(0.2), width: 1)
              : null,
          boxShadow: isActive
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Text(
          label,
          maxLines: 1,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: isActive ? Colors.white : Colors.deepPurple[800],
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }
}
