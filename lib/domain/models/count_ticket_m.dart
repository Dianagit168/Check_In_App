import 'dart:convert';

class CountTicketModel {
    final List<Used>? used;
    final List<Total>? total;

    CountTicketModel({
        this.used,
        this.total,
    });

    factory CountTicketModel.fromRawJson(String str) => CountTicketModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CountTicketModel.fromJson(Map<String, dynamic> json) => CountTicketModel(
        used: json["used"] == null ? [] : List<Used>.from(json["used"]!.map((x) => Used.fromJson(x))),
        total: json["total"] == null ? [] : List<Total>.from(json["total"]!.map((x) => Total.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "used": used == null ? [] : List<dynamic>.from(used!.map((x) => x.toJson())),
        "total": total == null ? [] : List<dynamic>.from(total!.map((x) => x.toJson())),
    };
}

class Total {
    final dynamic id;
    final int? total;

    Total({
        this.id,
        this.total,
    });

    factory Total.fromRawJson(String str) => Total.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Total.fromJson(Map<String, dynamic> json) => Total(
        id: json["_id"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "total": total,
    };
}

class Used {
    final dynamic id;
    final int? used;

    Used({
        this.id,
        this.used,
    });

    factory Used.fromRawJson(String str) => Used.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Used.fromJson(Map<String, dynamic> json) => Used(
        id: json["_id"],
        used: json["used"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "used": used,
    };
}
