import 'package:flutter/material.dart';
import 'package:graduation_project/screens/auth/signup_page.dart';
import 'package:graduation_project/widgets/banner.dart';

class NewOnboardingScreens extends StatefulWidget {
  const NewOnboardingScreens({super.key});

  @override
  State<NewOnboardingScreens> createState() => _NewOnboardingScreensState();
}

class _NewOnboardingScreensState extends State<NewOnboardingScreens> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<PromoBanner> _banners = const [
    PromoBanner(
      color: Colors.deepOrange,
      icon: Icons.local_shipping,
      title: 'Fast & Fixed Shipping!',
      subtitle: 'Same shipping cost for all governorates.',
      tag: 'Simple. Transparent. Affordable.',
    ),
    PromoBanner(
      color: Colors.orangeAccent,
      icon: Icons.card_giftcard,
      title: '15% OFF Your First Order!',
      subtitle: 'Sign up and save instantly.',
      tag: 'Enjoy your welcome gift!',
    ),
    PromoBanner(
      color: Colors.deepOrange,
      icon: Icons.stacked_line_chart,
      title: 'Buy More, Save More!',
      subtitle: 'Shop more and save more.',
      tag: 'Bigger orders = bigger discounts!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _banners.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return Center(child: _banners[index]);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_banners.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(4),
                width: _currentPage == index ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color:
                      _currentPage == index ? Colors.deepOrange : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                if (_currentPage == _banners.length - 1) {
                  // Navigate to home or login
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage()),
                  );
                } else {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                }
              },
              child: Text(
                  _currentPage == _banners.length - 1 ? 'Get Started' : 'Next'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
