import 'package:flutter/material.dart';
import '../models/models.dart';
import 'review_card.dart';

class ActivitySection extends StatelessWidget {
  final List<ReviewPost> posts;

  const ActivitySection({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Customer Favorites',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFAD1457),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return ReviewCard(post: post);
          },
        ),
      ],
    );
  }
}
