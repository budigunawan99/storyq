import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:storyq/data/model/story.dart';

part 'story_list_response.g.dart';
part 'story_list_response.freezed.dart';

@freezed
abstract class StoryListResponse with _$StoryListResponse {
  const factory StoryListResponse({
    required bool error,
    required String message,
    required List<Story> listStory,
  }) = _StoryListResponse;

  factory StoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryListResponseFromJson(json);
}
