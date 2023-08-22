class EventData {
  final String? id;
  final double? progress;
  final String? stage;
  final double? stageProgress;
  final String? url;
  final double? duration;
  final int? size;

  EventData({
    this.id,
    this.progress,
    this.stage,
    this.stageProgress,
    this.url,
    this.duration,
    this.size,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      id: json['id'],
      progress: json['progress']?.toDouble(),
      stage: json['stage'],
      stageProgress: json['stage_progress']?.toDouble(),
      url: json['url'],
      duration: json['duration']?.toDouble(),
      size: json['size']?.toInt(),
    );
  }
}
