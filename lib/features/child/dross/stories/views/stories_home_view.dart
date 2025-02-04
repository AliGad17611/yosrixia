import 'package:flutter/widgets.dart';
import 'package:yosrixia/features/child/dross/stories/views/widgets/stories_home_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class StoriesHomeView extends StatelessWidget {
  const StoriesHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: StoriesHomeViewBody(),);
  }
}