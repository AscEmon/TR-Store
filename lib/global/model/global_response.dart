class GlobalResponse {
  GlobalResponse({
    this.message,
    this.errors,
    this.code,
  });

  String? message;
  List<String>? errors;
  int? code;

  factory GlobalResponse.fromJson(Map<String, dynamic> json) => GlobalResponse(
        message: json["message"],
        errors: json["errors"] == null
            ? null
            : List<String>.from(json["errors"].map((x) => x)),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors":
            errors == null ? null : List<dynamic>.from(errors!.map((x) => x)),
        "code": code,
      };
}

