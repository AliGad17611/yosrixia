import 'package:flutter/material.dart';
import 'package:yosrixia/core/helper/global_variable.dart';
import 'package:yosrixia/features/child/dross/stories/helper/stories_map.dart';
import 'package:yosrixia/features/child/dross/stories/models/story_model.dart';
import 'package:yosrixia/features/child/dross/stories/views/widgets/story_widget.dart';

class StoryViewBody extends StatelessWidget {
  const StoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<StoryModel> storiesList = storiesMap[storyTitle] ?? [];
    final PageController pageController = PageController(initialPage: 0);
    return  SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: pageController,
          itemCount: storiesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: StoryWidget(storyModel: storiesList[index]),
            );
          },
        ),
      ),
    );
  }
}
