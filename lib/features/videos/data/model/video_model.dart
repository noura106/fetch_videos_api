class VideoModel {
  final String id;
  final String name;
  final String description;
  final String rate;
  final int viewerCount;
  final int secondNumber;
  final String videoUrl;
  final String coverImageUrl;
  final String createdAt;

  VideoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.rate,
    required this.viewerCount,
    required this.secondNumber,
    required this.videoUrl,
    required this.coverImageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'rate': rate,
      'viewer_count': viewerCount,
      'second_number': secondNumber,
      'video_url': videoUrl,
      'cover_image': coverImageUrl,
      'createdAt': createdAt,
    };
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      rate: json['rate'],
      viewerCount: json['viewer_count'],
      secondNumber: json['second_number'],
      videoUrl: json['video_url'],
      coverImageUrl: json['cover_image'],
      createdAt: json['createdAt'],
    );
  }
}
