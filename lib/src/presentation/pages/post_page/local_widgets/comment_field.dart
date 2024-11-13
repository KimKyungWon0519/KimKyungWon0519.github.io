import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kkw_blog/resource/assets.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';
import 'package:kkw_blog/resource/values/theme.dart';
import 'package:kkw_blog/src/core/utils/response_result.dart';
import 'package:kkw_blog/src/presentation/riverpods/post_notifier.dart';
import 'dart:html' as html;

import 'package:kkw_blog/src/presentation/widgets/error_dialog.dart';
import 'package:kkw_blog/src/presentation/widgets/loading_progress.dart';

class _ControllersProvider extends InheritedWidget {
  final TabController tabController;
  final TextEditingController textEditingController;
  final ScrollController scrollController;

  const _ControllersProvider({
    required this.tabController,
    required this.textEditingController,
    required this.scrollController,
    required super.child,
  });

  static _ControllersProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ControllersProvider>();
  }

  static _ControllersProvider of(BuildContext context) {
    final _ControllersProvider? result = maybeOf(context);
    return result!;
  }

  @override
  bool updateShouldNotify(covariant _ControllersProvider oldWidget) =>
      oldWidget.tabController != tabController ||
      oldWidget.textEditingController != textEditingController ||
      oldWidget.scrollController != scrollController;
}

class CommentField extends HookWidget {
  final ScrollController controller;

  const CommentField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return _ControllersProvider(
      tabController: useTabController(initialLength: 2),
      textEditingController: useTextEditingController(),
      scrollController: controller,
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: const Column(
          children: [
            _Header(),
            Expanded(
              child: _Body(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: TabBar(
                controller: _ControllersProvider.of(context).tabController,
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
  const _Body();

  @override
  Widget build(BuildContext context) {
    final _ControllersProvider controllersProvider =
        _ControllersProvider.of(context);
    final TextEditingController textEditingController =
        controllersProvider.textEditingController;
    final ScrollController scrollController =
        controllersProvider.scrollController;
    final TabController tabController = controllersProvider.tabController;
    final ValueNotifier<String> text = useState('');

    useEffect(() {
      void updateText() {
        text.value = textEditingController.text;
      }

      tabController.addListener(updateText);

      return () => tabController.removeListener(updateText);
    }, [textEditingController]);

    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                _InputField(),
                _Preview(),
              ],
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.primary,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: _AuthPanel(),
          ),
        ],
      ),
    );
  }
}

class _InputField extends ConsumerWidget {
  const _InputField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _ControllersProvider controllersProvider = _ControllersProvider.of(context);
    final bool isLogin =
        ref.watch(postNotifierProvider.select((value) => value.isLogin));
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
          readOnly: !isLogin,
          scrollController: controllersProvider.scrollController,
          controller: controllersProvider.textEditingController,
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
            hintText: !isLogin ? Messages.of(context).blockedFieldHint : null,
          ),
        ),
      ),
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview();

  @override
  Widget build(BuildContext context) {
    _ControllersProvider controllersProvider = _ControllersProvider.of(context);

    return Markdown(
      data: controllersProvider.textEditingController.text,
      controller: controllersProvider.scrollController,
      styleSheet: customMarkdownStyleSheet(context),
    );
  }
}

class _CompletedButton extends ConsumerWidget {
  const _CompletedButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    bool isLogin =
        ref.watch(postNotifierProvider.select((value) => value.isLogin));

    return ElevatedButton(
      onPressed: isLogin ? () => _submit(context, ref) : null,
      style: ButtonStyle(
        mouseCursor: WidgetStatePropertyAll(
            isLogin ? null : SystemMouseCursors.forbidden),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.all(16),
        ),
        backgroundColor: WidgetStatePropertyAll(colorScheme.surface),
      ),
      child: Text(
        Messages.of(context).completedWriting,
        style: TextStyle(color: colorScheme.primary),
      ),
    );
  }

  void _submit(BuildContext context, WidgetRef ref) async {
    TextEditingController textEditingController =
        _ControllersProvider.of(context).textEditingController;
    String content =
        _ControllersProvider.of(context).textEditingController.text;

    if (content.isEmpty) return;

    showLoadingDialog(context);

    ResponseResult? responseResult = await ref
        .read(postNotifierProvider.notifier)
        .submitComment(content)
        .then((value) {
      context.pop();

      return value;
    });

    if (responseResult != null && responseResult.isSuccess) {
      textEditingController.clear();

      ref.read(postNotifierProvider.notifier).updateComment();
    } else {
      showErrorDialog(
        context: context,
        errorMsg: Messages.of(context).failureCommentSubmit,
      );
    }
  }
}

class _AuthPanel extends ConsumerWidget {
  const _AuthPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLogin =
        ref.watch(postNotifierProvider.select((value) => value.isLogin));

    return isLogin ? const _LogoutPanel() : const _LoginPanel();
  }
}

class _LoginPanel extends StatelessWidget {
  const _LoginPanel();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('login with'),
        SizedBox(height: 8),
        _GithubLogin(),
      ],
    );
  }
}

class _LogoutPanel extends ConsumerWidget {
  const _LogoutPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () => _logout(ref),
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
      label: Text(Messages.of(context).logout),
      icon: const Icon(Icons.logout_rounded),
    );
  }

  void _logout(WidgetRef ref) {
    PostNotifier postNotifier = ref.read(postNotifierProvider.notifier);

    postNotifier.logout().then((value) => postNotifier.updateUser());
  }
}

class _GithubLogin extends HookConsumerWidget {
  const _GithubLogin();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _loginWithGithub(ref),
      child: Container(
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
      ),
    );
  }

  void _loginWithGithub(WidgetRef ref) async {
    PostNotifier postNotifier = ref.read(postNotifierProvider.notifier);

    String currentURL = html.document.window?.location.toString() ?? '';

    postNotifier.loginWithGithub(currentURL);
  }
}
