import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kkw_blog/resource/assets.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/resource/values/theme.dart';

class CommentField extends HookWidget {
  final ScrollController controller;

  const CommentField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final TabController tabController = useTabController(initialLength: 2);

    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          _Header(controller: tabController),
          Expanded(
            child: _Body(
              controller: tabController,
              scrollController: controller,
            ),
          ),
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
    return ColoredBox(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: TabBar(
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
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                tabs: [
                  Tab(
                    text: Messages.of(context).write,
                    height: double.infinity,
                  ),
                  Tab(
                    text: Messages.of(context).preview,
                    height: double.infinity,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(8),
              child: const _CompletedButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends HookWidget {
  final ScrollController scrollController;
  final TabController controller;

  const _Body({
    required this.scrollController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController =
        useTextEditingController();
    final ValueNotifier<String> text = useState('');

    useEffect(() {
      void updateText() {
        text.value = textEditingController.text;
      }

      controller.addListener(updateText);

      return () => controller.removeListener(updateText);
    }, [textEditingController]);

    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                _InputField(
                  controller: textEditingController,
                  scrollController: scrollController,
                ),
                _Preview(
                  text: text.value,
                  scrollController: scrollController,
                ),
              ],
            ),
          ),
          const _LoginPanel(),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final ScrollController scrollController;
  final TextEditingController controller;

  const _InputField({
    required this.scrollController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        child: TextField(
          scrollController: scrollController,
          controller: controller,
          expands: true,
          maxLines: null,
          maxLength: 500,
          cursorColor: color,
          style: TextStyle(color: color, fontSize: 12),
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.onPrimary,
            hoverColor: Theme.of(context).colorScheme.onPrimary,
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
      ),
    );
  }
}

class _Preview extends StatelessWidget {
  final ScrollController scrollController;
  final String text;

  const _Preview({
    required this.text,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: text,
      controller: scrollController,
      styleSheet: customMarkdownStyleSheet(context),
    );
  }
}

class _CompletedButton extends StatelessWidget {
  const _CompletedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.all(16),
        ),
      ),
      child: Text(Messages.of(context).completedWriting),
    );
  }
}

class _LoginPanel extends StatelessWidget {
  const _LoginPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _GithubLogin(),
      ],
    );
  }
}

class _GithubLogin extends StatelessWidget {
  const _GithubLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(8),
      child: SvgPicture.asset(
        githubLogo,
      ),
    );
  }
}
