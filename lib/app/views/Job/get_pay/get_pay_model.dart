class DaystoPay {
  DaystoPay({
    this.days,
  });

  List<Day> days;

  factory DaystoPay.fromJson(Map<String, dynamic> json) => DaystoPay(
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
    this.id,
    this.dayIn,
    this.out,
    this.offset,
    this.salary,
    this.payment,
  });

  DateTime date;
  int hours;
  int breakMinutes;
  String id;
  DateTime dayIn;
  DateTime out;
  int offset;
  int salary;
  int payment;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        date: DateTime.parse(json["date"]),
        hours: json["hours"],
        breakMinutes: json["break_minutes"],
        id: json["_id"],
        dayIn: DateTime.parse(json["in"]),
        out: DateTime.parse(json["out"]),
        offset: json["offset"],
        salary: json["salary"],
        payment: json["payment"],
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "hours": hours,
        "break_minutes": breakMinutes,
        "_id": id,
        "in": dayIn.toIso8601String(),
        "out": out.toIso8601String(),
        "offset": offset,
        "salary": salary,
        "payment": payment,
      };
}
