import 'dart:convert';

class TicketModel {
    final String? status;
    final List<GetTicketData>? data;

    TicketModel({
        this.status,
        this.data,
    });

    factory TicketModel.fromRawJson(String str) => TicketModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<GetTicketData>.from(json["data"]!.map((x) => GetTicketData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class GetTicketData {
    final String? id;
    final String? orderId;
    final String? lineItem;
    final int? qty;
    final int? used;
    final bool? isCancle;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final String? title;

    GetTicketData({
        this.id,
        this.orderId,
        this.lineItem,
        this.qty,
        this.used,
        this.isCancle,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.title,
    });

    factory GetTicketData.fromRawJson(String str) => GetTicketData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetTicketData.fromJson(Map<String, dynamic> json) => GetTicketData(
        id: json["_id"],
        orderId: json["order_id"],
        lineItem: json["line_item"],
        qty: json["qty"],
        used: json["used"],
        isCancle: json["is_cancle"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "order_id": orderId,
        "line_item": lineItem,
        "qty": qty,
        "used": used,
        "is_cancle": isCancle,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "title": title
    };
}