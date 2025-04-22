class Story {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  final double lat;
  final double lon;

  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photoUrl: json['photoUrl'],
      createdAt: json['createdAt'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'photoUrl': photoUrl,
    'createdAt': createdAt,
    'lat': lat,
    'lon': lon,
  };
}

final stories = [
  Story(
    id: "story-FvU4u0Vp2S3PMsFg",
    name: "Dimas",
    description: "Lorem Ipsum",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1641623658595_dummy-pic.png",
    createdAt: "2022-01-08T06:34:18.598Z",
    lat: -10.212,
    lon: -16.002,
  ),

  Story(
    id: "story-FvU4u0Vp2S3PMsFx",
    name: "Seto Hahahaha",
    description: "Lorem Ipsum",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1641623658595_dummy-pic.png",
    createdAt: "2022-01-08T06:34:18.598Z",
    lat: -10.212,
    lon: -16.002,
  ),
];
