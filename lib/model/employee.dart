class Employee {
  int? id;
  String? name;
  String? role;
  String? startDate;
  String? endDate;

  Employee({
    this.id,
    this.name,
    this.role,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      role: map['role'],
      startDate: map['start_date'],
      endDate: map['end_date'],
    );
  }
}
