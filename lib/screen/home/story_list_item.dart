import 'package:flutter/material.dart';
import 'package:storyq/data/model/story.dart';

class StoryListItem extends StatelessWidget {
  final Story story;

  const StoryListItem({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(      
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 25,
                  minHeight: 25,
                  maxWidth: 25,
                  minWidth: 25,
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
                child: Text(
                  story.name,
                  style: Theme.of(context).textTheme.titleMedium,
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
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
