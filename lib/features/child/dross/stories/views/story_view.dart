import 'package:flutter/widgets.dart';
import 'package:yosrixia/features/child/dross/stories/views/widgets/story_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(
      child: StoryViewBody(),
    );
  }
}
