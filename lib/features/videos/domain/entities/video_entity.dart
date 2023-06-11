class VideoEntity {
  final String id;
  final String name;
  final String description;
  final double rate;
  final int viewerCount;
  final int secondNumber;
  final String videoUrl;
  final String coverImageUrl;
  final String createdAt;

  VideoEntity({
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
}