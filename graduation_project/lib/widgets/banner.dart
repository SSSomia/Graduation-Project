import 'package:flutter/material.dart';

class PromoBannerList extends StatelessWidget {
  const PromoBannerList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: const [
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
        ],
      ),
    );
  }
}

class PromoBanner extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final String tag;

  const PromoBanner({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 36),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const Spacer(),
          Text(
            tag,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
