class DataPaid {
    DataPaid({
        this.id,
        this.total,
        this.hours,
    });

    dynamic id;
    double total;
    double hours;

    factory DataPaid.fromJson(Map<String, dynamic> json) => DataPaid(
        id: json["_id"],
        total: json["total"] == null ? 0.0 : json["total"].toDouble(),
        hours: json["hours"] == null ? 0.0 : json["hours"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "total": total,
        "hours": hours,
    };
}
