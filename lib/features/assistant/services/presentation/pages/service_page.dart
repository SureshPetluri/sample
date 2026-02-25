import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/service_provider.dart';

class ServiceScreen extends ConsumerStatefulWidget {
  const ServiceScreen({super.key});

  @override
  ConsumerState<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends ConsumerState<ServiceScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(serviceCategoriesProvider);
    final selectedIndex = ref.watch(selectedCategoryIndexProvider);

    return Column(
        children: [
          // Split View
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Categories
                Container(
                  width: 100, // Fixed width for left pane
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      right: BorderSide(color: Color(0xFFF0F0F0), width: 1),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    child: Stack(
                      children: [
                        Column(
                          children: List.generate(categories.length, (index) {
                            final category = categories[index];
                            final isSelected = selectedIndex == index;
                            return InkWell(
                              onTap: () {
                                ref.read(selectedCategoryIndexProvider.notifier).state = index;

                                // Scroll to center
                                final double itemHeight = 100.0;

                                if (_scrollController.hasClients) {
                                  final double viewportHeight = _scrollController.position.viewportDimension;
                                  final double centerOffset = (index * itemHeight) + (itemHeight / 2) - (viewportHeight / 2);
                                  
                                  final double maxScroll = _scrollController.position.maxScrollExtent;
                                  final double targetOffset = centerOffset.clamp(0.0, maxScroll);

                                  _scrollController.animateTo(
                                    targetOffset,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFFF8F9FA) : Colors.white,
                                  border: Border(
                                    bottom: const BorderSide(color: Color(0xFFF0F0F0), width: 1),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon Placeholder wrapped in standard container
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        // Use image if exists, else icon
                                        child: Center(
                                          child: Icon(
                                            _getIconForCategory(index),
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${category.title} (${category.count})',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                        color: isSelected ? Colors.black : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        // Animated Vertical Indicator Line
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          top: selectedIndex * 100.0,
                          left: 0,
                          child: Container(
                            width: 3,
                            height: 100,
                            color: Colors.red[400], // Red indicator line
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Right Sub-services
                Expanded(
                  child: Container(
                    color: const Color(0xFFF5F6F8), // Light greyish blue background
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'IN THE SPOTLIGHT',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.add, size: 14, color: Colors.blue),
                                    SizedBox(width: 4),
                                    Text(
                                      'Add New',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // List
                        Expanded(
                          child: ListView.separated(
                            physics: const ClampingScrollPhysics(),
                            itemCount: categories[selectedIndex].items.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final item = categories[selectedIndex].items[index];
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.02),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.red[400],
                                      size: 18,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

    );
  }

  IconData _getIconForCategory(int index) {
    switch (index) {
      case 0:
        return Icons.agriculture;
      case 1:
        return Icons.biotech; // Astronomy proxy
      case 2:
        return Icons.flight_takeoff;
      case 3:
        return Icons.fitness_center;
      case 4:
        return Icons.games;
      default:
        return Icons.category;
    }
  }
}
