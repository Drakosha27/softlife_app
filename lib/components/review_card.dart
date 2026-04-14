import 'package:flutter/material.dart';
import '../models/models.dart';

class ReviewCard extends StatelessWidget {
  final ReviewPost post;

  const ReviewCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.pink[50]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.pink[50],
                backgroundImage: AssetImage(post.userAvatar),
                radius: 20,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFFAD1457),
                    ),
                  ),
                  Text(
                    post.timeAgo,
                    style: TextStyle(
                      color: Colors.pink[200],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post.message,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF880E4F),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
