import 'package:flutter/widgets.dart';
import 'package:kkw_blog/src/presentation/pages/post_page/local_widgets/comment_view.dart';

class CommentListview extends StatelessWidget {
  const CommentListview({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: CommentView(),
      ),
      itemCount: 10,
    );
  }
}
