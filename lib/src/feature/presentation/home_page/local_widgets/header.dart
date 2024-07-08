import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _Label(),
        _Introduction(),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(),
        const SizedBox(width: 16),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '얼렁뚱땅 개발 블로그',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Text('김경원의 블로그'),
          ],
        ),
      ],
    );
  }
}

class _Introduction extends StatelessWidget {
  const _Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          wrappedKorean(
              '안녕하세요. 플러터 개발자 김경원입니다.\n이 블로그를 모두에게 도움이 되는 블로그로 채우도록 노력하겠습니다.'),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String wrappedKorean(String text) {
    final RegExp emoji = RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
    String fullText = '';
    List<String> words = text.split(' ');
    for (var i = 0; i < words.length; i++) {
      fullText += emoji.hasMatch(words[i])
          ? words[i]
          : words[i]
              .replaceAllMapped(RegExp(r'(\S)(?=\S)'), (m) => '${m[1]}\u200D');
      if (i < words.length - 1) fullText += ' ';
    }

    return fullText;
  }
}
