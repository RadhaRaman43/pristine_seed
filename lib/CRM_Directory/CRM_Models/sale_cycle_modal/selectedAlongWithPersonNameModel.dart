class Selectedalongwithpersonnamemodel{
  String? empId;

  Selectedalongwithpersonnamemodel({required this.empId});

  Map<String, dynamic> toJson() => {
  'emp_id': empId,
  };
}