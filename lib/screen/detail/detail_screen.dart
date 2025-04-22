import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:storyq/data/model/story.dart';
import 'package:storyq/screen/common/appbar.dart';

class DetailScreen extends StatefulWidget {
  final String storyId;

  const DetailScreen({super.key, required this.storyId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Story story;

  @override
  void initState() {
    super.initState();
    story = stories.singleWhere((element) => element.id == widget.storyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(isHomePage: false, title: "Stories"),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 40,
                          minHeight: 40,
                          maxWidth: 40,
                          minWidth: 40,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/user.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox.square(dimension: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              story.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox.square(dimension: 5),
                            Text(
                              DateFormat(
                                'dd-MM-yyyy',
                              ).format(DateTime.parse(story.createdAt)),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 0.75 * MediaQuery.of(context).size.width,
                    minHeight: 0.25 * MediaQuery.of(context).size.width,
                    maxWidth: MediaQuery.of(context).size.width,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Hero(
                    tag: story.id,
                    child: Image.network(
                      story.photoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/img_default.png',
                          fit: BoxFit.fitWidth,
                        );
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "${story.name} - ${story.description}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
