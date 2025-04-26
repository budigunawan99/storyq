import 'package:flutter/material.dart';
import 'package:storyq/data/model/story.dart';
import 'package:storyq/screen/common/appbar.dart';
import 'package:storyq/screen/home/story_list_item.dart';

class HomeScreen extends StatefulWidget {
  final List<Story> stories;
  final Function(String) onTapped;
  final Function() toSettingsPage;

  const HomeScreen({
    super.key,
    required this.stories,
    required this.onTapped,
    required this.toSettingsPage,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(isHomePage: true, toSettingsPage: widget.toSettingsPage),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Tambah cerita",
        child: const Icon(Icons.add, size: 28),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.separated(
            itemCount: widget.stories.length,
            itemBuilder: (context, index) {
              final story = (widget.stories)[index];
              return InkWell(
                child: StoryListItem(story: story),
                onTap: () => widget.onTapped(story.id),
              );
            },
            separatorBuilder:
                (context, index) => const Divider(height: 0.2, thickness: 0.5),
          ),
        ],
      ),
    );
  }
}
