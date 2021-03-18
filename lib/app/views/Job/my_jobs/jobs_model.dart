class JobList{
  final List<Job> jobList;
  JobList({
    final this.jobList
  });
  factory JobList.fromJson(List<dynamic>json){
    List<Job> jobs;
    jobs = json.map((e) => Job.fromJson(e)).toList();
    return new JobList(jobList: jobs);
  }
}

class Job{
  Job({
        this.id,
        this.status,
        this.name,
        this.type,
        this.salary,
        this.address,
    });

    String id;
    String status;
    String name;
    String type;
    int salary;
    Address address;

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        status: json["status"],
        name: json["name"],
        type: json["type"],
        salary: json["salary"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "name": name,
        "type": type,
        "salary": salary,
        "address": address.toJson(),
    };
}

class Address {
    Address({
        this.country,
        this.state,
        this.city,
    });

    String country;
    String state;
    String city;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"] ?? '',
        state: json["state"] ?? '',
        city: json["city"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "state": state,
        "city": city,
    };
}
