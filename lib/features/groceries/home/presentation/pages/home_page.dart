import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../core/widgets/product_widget.dart';
import '../../../../unique_common_widget/unique_common_data.dart';
import '../../../../unique_common_widget/unique_common_type.dart';
import '../../../../unique_common_widget/unique_common_widget.dart';
import '../providers/home_provider.dart';

class GroceriesHomePage extends ConsumerStatefulWidget {
  const GroceriesHomePage({super.key});

  @override
  ConsumerState<GroceriesHomePage> createState() => _GroceriesHomePageState();
}

class _GroceriesHomePageState extends ConsumerState<GroceriesHomePage> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentBannerIndex = 0;

  final List<UniqueCommonData> _banners = [
    UniqueCommonData(
      type: UniqueCommonType.lottie,
      content: 'https://assets9.lottiefiles.com/packages/lf20_m6cuL6.json',
      metadata: {'repeat': true},
    ),
    UniqueCommonData(
      type: UniqueCommonType.video,
      content: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    ),
    UniqueCommonData(
      type: UniqueCommonType.webview,
      content: 'https://www.bigbasket.com/offers/',
    ),
  ];

  final List<Map<String, dynamic>> _stepWiseOffers = [
    {
      'title': 'Fresh Fruits & Vegetables',
      'banner': UniqueCommonData(
        type: UniqueCommonType.html,
        content: '<div style="background: linear-gradient(90deg, #ff9a9e 0%, #fecfef 99%, #fecfef 100%); padding: 20px; text-align: center; border-radius: 12px; color: white;"><h1>Up to 40% OFF</h1><p>On Organic Produce</p></div>',
      ),
      'products': [
        {'name': 'Organic Apples', 'price': '\$4.99', 'image': 'https://vignette.wikia.nocookie.net/recipes/images/b/b3/Red_Apples.jpg/revision/latest?cb=20101117174623'},
        {'name': 'Fresh Bananas', 'price': '\$0.99', 'image': 'https://th.bing.com/th/id/OIP.Aay8-27kR1N3k0A-p8N-OAHaFj?rs=1&pid=ImgDetMain'},
        {'name': 'Baby Spinach', 'price': '\$2.49', 'image': 'https://th.bing.com/th/id/OIP.1G4n8cQf9m6-8-0-1G-4QAAAA?rs=1&pid=ImgDetMain'},
      ]
    },
    {
      'title': 'Daily Essentials',
      'banner': UniqueCommonData(
        type: UniqueCommonType.lottie,
        content: 'https://assets2.lottiefiles.com/packages/lf20_q5pk6p.json',
      ),
      'products': [
        {'name': 'Whole Milk', 'price': '\$3.49', 'image': 'https://th.bing.com/th/id/OIP.vW0H-QG5Q-z-G-D-v-W-0-H-QAAAA?rs=1&pid=ImgDetMain'},
        {'name': 'Brown Bread', 'price': '\$2.29', 'image': 'https://th.bing.com/th/id/OIP.Gk-n-W-h-F-V-f-C-B-e-z-C-P-wAAAA?rs=1&pid=ImgDetMain'},
        {'name': 'Grade A Eggs', 'price': '\$3.99', 'image': 'https://th.bing.com/th/id/OIP.f-Q-C-u-q-r-P-N-Y-J-W-S-z-A?rs=1&pid=ImgDetMain'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    ref.watch(homeProvider); // Keep the provider watch if needed for state

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          child: UniqueCommonWidget(
            data: _banners[0],
          ),
        ),
        _buildCarouselBanners(),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            'Exclusive Offers for You',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        ..._stepWiseOffers.map((offer) => _buildStepWiseOffer(offer)),
        // const Padding(
        //   padding: EdgeInsets.fromLTRB(16, 32, 16, 8),
        //   child: Text(
        //     'Featured Promotions',
        //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //   ),
        // ),
        //
        const SizedBox(height: 32),
      ],
    );

  }

  Widget _buildCarouselBanners() {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: _banners.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: UniqueCommonWidget(
                data: _banners[index],
              ),
            );
          },
          options: CarouselOptions(
            height: 180,
            viewportFraction: 0.85,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _banners.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _currentBannerIndex == entry.key ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _currentBannerIndex == entry.key
                      ? Colors.green.shade600
                      : Colors.grey.shade300,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStepWiseOffer(Map<String, dynamic> offer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            offer['title'],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 140,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: UniqueCommonWidget(data: offer['banner']),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: offer['products'].length,
            itemBuilder: (context, index) {
              final product = offer['products'][index];
              return buildProductCard(product);
            },
          ),
        ),
      ],
    );
  }

}
