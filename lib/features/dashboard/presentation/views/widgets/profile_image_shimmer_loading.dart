import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileImageShimmerLoading extends StatelessWidget {
  const ProfileImageShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white.withAlpha(100),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
