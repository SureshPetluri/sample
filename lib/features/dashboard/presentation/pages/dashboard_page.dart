import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/app/routes/app_routes.dart';
import 'package:sample/core/utils/constants.dart';
import 'package:sample/core/utils/navigation_utils.dart';
import 'package:sample/core/widgets/app_text_field.dart';

class DashBoardPage extends ConsumerStatefulWidget {
  final Widget child;

  const DashBoardPage({super.key, required this.child});

  @override
  ConsumerState<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends ConsumerState<DashBoardPage> {
  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// 🔹 Top Header (Address & Tabs)
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Column(
                  children: [
                    /// Location Row
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
                              Icon(Icons.keyboard_arrow_down),
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
                                  SizedBox(width: 2),
                                  Text(
                                    '₹0',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () {
                                NavigationUtils.push(
                                  context,
                                  AppRoutes.profile,
                                );
                              },
                              child: const Icon(Icons.account_circle, size: 24),
                            ),
                          ],
                        ),
                      ],
                    ),

                    if (isHome) ...[
                      const SizedBox(height: 4),

                      /// Tabs
                      Row(
                        children: [
                          Flexible(
                            child: _buildCustomTab(
                              label: 'Sample',
                              isActive: activeTabIndex == 0,
                              onTap: () => NavigationUtils.go(
                                context,
                                AppRoutes.groceriesHome,
                              ),
                              primaryColor: primaryTeal,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: _buildCustomTab(
                              label: 'Assistance',
                              isActive: activeTabIndex == 1,
                              onTap: () => NavigationUtils.go(
                                context,
                                AppRoutes.assistantHome,
                              ),
                              primaryColor: primaryTeal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),

            /// 🔹 Pinned Search Bar
            SliverAppBar(
              pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isWeb(context)) ...[
                    const Text("Sample"),
                    const SizedBox(width: 12),
                  ],
                  Flexible(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isWeb(context) ? 400 : double.infinity,
                      ),
                      child: AppTextField(
                        hintText: "Enter your name",
                        controller: nameController,
                        prefixIcon: const Icon(Icons.search),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  if (isWeb(context)) ...[
                    const SizedBox(width: 12),
                    const Text("Categories"),
                    const SizedBox(width: 12),
                    const Icon(Icons.shopping_cart),
                  ],
                ],
              ),
            ),

            /// 🔹 Actual Page Content
            SliverFillRemaining(
              hasScrollBody: false,
              child: widget.child,
            ),
          ],
        ),
      ),
      bottomNavigationBar: activeTabIndex == 0
          ? BottomNavigationBar(
              currentIndex: _calculateGroceriesIndex(location),
              onTap: (index) {
                switch (index) {
                  case 0:
                    NavigationUtils.push(context, AppRoutes.groceriesHome);
                    break;
                  case 1:
                    NavigationUtils.push(context, AppRoutes.brands);
                    break;
                  case 2:
                    NavigationUtils.push(context, AppRoutes.categories);
                    break;
                }
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.branding_watermark),
                  label: 'Brands',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined),
                  label: 'Categories',
                ),
              ],
            )
          : BottomNavigationBar(
              currentIndex: _calculateAssistantIndex(location),
              onTap: (index) {
                switch (index) {
                  case 0:
                    NavigationUtils.push(context, AppRoutes.assistantHome);
                    break;
                  case 1:
                    NavigationUtils.push(context, AppRoutes.services);
                    break;
                }
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cleaning_services),
                  label: 'Services',
                ),
              ],
            ),
    );
  }

  int _calculateGroceriesIndex(String location) {
    if (location.startsWith(AppRoutes.brands)) return 1;
    if (location.startsWith(AppRoutes.categories)) return 2;
    return 0;
  }

  int _calculateAssistantIndex(String location) {
    if (location.startsWith(AppRoutes.services)) return 1;
    return 0;
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
