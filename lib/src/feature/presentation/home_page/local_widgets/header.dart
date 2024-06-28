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
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Align(
        alignment: Alignment.center,
        child: Text(
          '안녕하세요. 플러터 개발자 김경원입니다.\n이 블로그를 모두에게 도움이 되는 블로그로 채우도록 노력하겠습니다.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
