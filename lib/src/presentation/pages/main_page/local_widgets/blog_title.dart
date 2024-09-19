import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kkw_blog/src/core/constants/assets.dart' as Assets;

class BlogTitle extends StatelessWidget {
  const BlogTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileImage();
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.sp,
      height: 50.sp,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(Assets.profile),
        ),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
