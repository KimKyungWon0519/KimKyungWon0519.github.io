import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';

class CommentField extends HookWidget {
  const CommentField({super.key});

  @override
  Widget build(BuildContext context) {
    final TabController tabController = useTabController(initialLength: 2);
    final double height = MediaQuery.sizeOf(context).height;

    return Container(
      height: height * 0.3,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          _Header(controller: tabController),
          _Body(controller: tabController),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final TabController controller;

  const _Header({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      dividerColor: Colors.transparent,
      unselectedLabelColor: Colors.grey,
      physics: const NeverScrollableScrollPhysics(),
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorSize: TabBarIndicatorSize.tab,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      indicator: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      labelColor: Theme.of(context).colorScheme.primaryContainer,
      tabs: [
        Tab(text: Messages.of(context).write),
        Tab(text: Messages.of(context).preview),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final TabController controller;

  const _Body({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(8),
        child: TabBarView(
          controller: controller,
          children: const [
            _InputField(),
            _Preview(),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField();

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.primaryContainer;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        expands: true,
        maxLines: null,
        maxLength: 500,
        cursorColor: color,
        style: TextStyle(color: color),
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          counterStyle: TextStyle(color: color),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
          ),
        ),
      ),
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return Markdown(data: 'data');
  }
}
