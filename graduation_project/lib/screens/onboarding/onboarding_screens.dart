import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/signup/signup_page.dart';
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
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              buildPage(
                animation: "assets/animation/firstImage.json",
                title: "Explore Products",
                description: "Find your favorite items from a wide collection.",
              ),
              buildPage(
                animation: "assets/animation/thirdImage.json",
                title: "Secure Payments",
                description: "Fast and secure checkout with multiple payment options.",
              ),
              buildPage(
                animation: "assets/animation/secondImage.json",
                title: "Fast Delivery",
                description: "Get your items delivered to your doorstep in no time!",
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
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Colors.blue,
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
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()),
                              );
                      // Navigate to Login or Home Screen
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Get Started"),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => _controller.jumpToPage(2),
                        child: Text("Skip"),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

 Widget buildPage({required String animation, required String title, required String description}) {
  return Column(
    children: [
      SizedBox(height: 200),
      Lottie.asset(animation, height: 400),
      SizedBox(height: 20),
      Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
      SizedBox(height: 40),
    ],
  );
}

}
