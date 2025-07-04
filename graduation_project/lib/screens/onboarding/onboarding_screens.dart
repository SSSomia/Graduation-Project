import 'package:flutter/material.dart';
import 'package:graduation_project/screens/auth/signup_page.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 255, 254),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              buildPage(
                animation: "assets/animation/secondImage.json",
                title: "Fast & Fixed Shipping!",
                description:
                    "Same shipping cost for all governorates.",
              ),
              buildPage(
                animation: "assets/animation/firstOrder.json",
                title: "15% OFF Your First Order!",
                description: "Sign up and save instantly.",
              ),
              buildPage(
                animation: "assets/animation/coupons.json",
                title: "Buy More, Save More!",
                description:
                    "Shop more and save more.",
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Color.fromARGB(255, 185, 28, 28),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: isLastPage
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                      // Navigate to Login or Home Screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 185, 28, 28),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => _controller.jumpToPage(2),
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                              color: Color.fromARGB(255, 185, 28, 28)),
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor:
                            const Color.fromARGB(255, 185, 28, 28),
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(
      {required String animation,
      required String title,
      required String description}) {
    return Column(
      children: [
        const SizedBox(height: 200),
        Lottie.asset(animation, height: 400),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
