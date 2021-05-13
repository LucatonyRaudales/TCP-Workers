class ListCheck {
    ListCheck({
        this.days,
    });

    List<Day> days;

    factory ListCheck.fromJson(Map<String, dynamic> json) => ListCheck(
        days: List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "days": List<dynamic>.from(days.map((x) => x.toJson())),
    };
}

class Day {
    Day({
        this.date,
        this.hours,
        this.breakMinutes,
        this.paid,
        this.id,
        this.dayIn,
        this.out,
        this.offset,
        this.salary,
        this.payment,
        this.isCheck
    });

    DateTime date;
    double hours;
    int breakMinutes;
    bool paid;
    String id;
    DateTime dayIn;
    DateTime out;
    int offset;
    int salary;
    double payment;
    bool isCheck;

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        date: DateTime.parse(json["date"]),
        hours: json["hours"].toDouble(),
        breakMinutes: json["break_minutes"],
        paid: json["paid"],
        id: json["_id"],
        dayIn: DateTime.parse(json["in"]),
        out: DateTime.parse(json["out"]),
        offset: json["offset"],
        salary: json["salary"],
        payment: json["payment"].toDouble(),
        isCheck: false
    );

    Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "hours": hours,
        "break_minutes": breakMinutes,
        "paid": paid,
        "_id": id,
        "in": dayIn.toIso8601String(),
        "out": out.toIso8601String(),
        "offset": offset,
        "salary": salary,
        "payment": payment,
    };
}
