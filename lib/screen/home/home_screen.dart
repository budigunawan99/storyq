import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/common.dart';
import 'package:storyq/provider/home/story_list_provider.dart';
import 'package:storyq/screen/common/appbar.dart';
import 'package:storyq/screen/common/skeleton_loading.dart';
import 'package:storyq/screen/home/story_list_item.dart';
import 'package:storyq/static/story_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) onTapped;
  final Function() toSettingsPage;
  final Function() toCreateStoryPage;

  const HomeScreen({
    super.key,
    required this.onTapped,
    required this.toSettingsPage,
    required this.toCreateStoryPage,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (context.read<StoryListProvider>().page != null) {
          context.read<StoryListProvider>().fetchStoryList();
        }
      }
    });

    Future.microtask(() {
      context.read<StoryListProvider>().fetchStoryList();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(isHomePage: true, toSettingsPage: widget.toSettingsPage),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.toCreateStoryPage();
        },
        tooltip: AppLocalizations.of(context)!.createStoryMenu,
        child: const Icon(Icons.add, size: 28),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          Consumer<StoryListProvider>(
            builder: (context, value, child) {
              return switch (value.resultState) {
                StoryListLoadingState() => SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SkeletonLoading(count: 2),
                  ),
                ),
                StoryListLoadedState(data: var storyList) =>
                  SliverList.separated(
                    itemCount: storyList.length + (value.page != null ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == storyList.length && value.page != null) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.width,
                          child: SkeletonLoading(count: 1),
                        );
                      }
                      final story = storyList[index];
                      return InkWell(
                        child: StoryListItem(story: story),
                        onTap: () => widget.onTapped(story.id),
                      );
                    },
                    separatorBuilder:
                        (context, index) =>
                            const Divider(height: 0.2, thickness: 0.5),
                  ),
                StoryListErrorState(error: var message) => SliverToBoxAdapter(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/nodata.png', height: 250),
                          const SizedBox.square(dimension: 8),
                          Text(
                            message,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _ => SliverToBoxAdapter(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/empty.png', height: 250),
                          const SizedBox.square(dimension: 8),
                          Text(
                            AppLocalizations.of(context)!.emptyStoryText,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              };
            },
          ),
        ],
      ),
    );
  }
}
