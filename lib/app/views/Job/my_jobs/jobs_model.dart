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
  String id;
  String status;
  String name;
  String type;
  int salary;
  String address;

  Job({
    final this.id,
    final this.address,
    final this.name,
    final this.salary,
    final this.status,
    final this.type
  });

  factory Job.fromJson(Map<String, dynamic> json){
    return Job(
      id: json['_id'],
      status: json['status'],
      name: json['name'],
      type: json['type'],
      salary: json['salary'],
      address: json['address']
    );
  }
}