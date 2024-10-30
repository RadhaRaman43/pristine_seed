class Selectedalongwithpersonnamemodel{
  String? empId;

  Selectedalongwithpersonnamemodel({required this.empId});

  Map<String, dynamic> toJson() => {
  'along_with_person_name': empId,
  };
}