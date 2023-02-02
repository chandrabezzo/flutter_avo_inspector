class TrackEventJsonRequest {
  TrackEventJsonRequest({
    required this.dateTime,
    required this.detail,
  });

  final String dateTime;
  final String detail;

  factory TrackEventJsonRequest.fromJson(Map<String, dynamic> json) =>
      TrackEventJsonRequest(
        dateTime: json["dateTime"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime,
        "detail": detail,
      };
}
