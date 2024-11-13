import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/resource/assets.dart' as Assets;

class BlogTitle extends StatelessWidget {
  const BlogTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ProfileImage(),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _Title(),
            _SubTitle(),
          ],
        ),
      ],
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          width: 1,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.hardEdge,
      child: SvgPicture.asset(Assets.profile),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Text(
      Messages.of(context).blogTitle,
      style: themeData.textTheme.titleLarge?.copyWith(
        color: themeData.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Text(
      Messages.of(context).subTitle,
      style: themeData.textTheme.bodyMedium,
    );
  }
}
