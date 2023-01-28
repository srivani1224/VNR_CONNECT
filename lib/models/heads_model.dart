// ignore_for_file: non_constant_identifier_names

class Head {
  late String Name;
  late String Email_Id;
  late String Department;
  late String Contact_Number;
  late String Student_Faculty;

  Head(
      {required this.Name,
      required this.Department,
      required this.Email_Id,
      required this.Contact_Number,
      required this.Student_Faculty});

  Map<String, dynamic> toJson() => {
        'Name': Name,
        'Department': Department,
        'Email_Id': Email_Id,
        'Contact_Number': Contact_Number,
        'Student_Faculty': Student_Faculty,
      };

  static Head fromJson(Map<String, dynamic> json) => Head(
      Name: json['Name'],
      Department: json['Department'],
      Email_Id: json['Email_Id'],
      Contact_Number: json['Contact_Number'],
      Student_Faculty: json['Student_Faculty']);
}
