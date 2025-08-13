class LoginResponse {
  String? name;
  String? email;
  Null? password;
  String? message;
  String? roleId;
  String? roleName;
  String? condition;
  String? isHo;
  String? clusterId;
  String? companyId;
  String? employeeIdAutoGenrated;
  String? phoneNo;
  String? emailIds;
  String? jwtToken;
  String? requestHostName;
  String? profile;
  String? userType;
  String? customerCode;
  String? userTypeName;
  int? isCrm;
  List<Menu>? menu;

  LoginResponse(
      {this.name,
        this.email,
        this.password,
        this.message,
        this.roleId,
        this.roleName,
        this.condition,
        this.isHo,
        this.clusterId,
        this.companyId,
        this.employeeIdAutoGenrated,
        this.phoneNo,
        this.emailIds,
        this.jwtToken,
        this.requestHostName,
        this.profile,
        this.userType,
        this.customerCode,
        this.userTypeName,
        this.isCrm,
        this.menu
        });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    message = json['message'];
    roleId = json['roleId'];
    roleName = json['role_name'];
    condition = json['condition'];
    isHo = json['is_ho'];
    clusterId = json['cluster_id'];
    companyId = json['company_id'];
    employeeIdAutoGenrated = json['employee_id_auto_genrated'];
    phoneNo = json['phoneNo'];
    emailIds = json['email_ids'];
    jwtToken = json['jwt_token'];
    requestHostName = json['request_host_name'];
    profile = json['profile'];
    userType = json['user_type'];
    customerCode = json['customer_code'];
    userTypeName = json['user_type_name'];
    isCrm = json['is_crm'];
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['message'] = this.message;
    data['email'] = this.email;
    data['password'] = this.password;
    data['roleId'] = this.roleId;
    data['role_name'] = this.roleName;
    data['condition'] = this.condition;
    data['is_ho'] = this.isHo;
    data['cluster_id'] = this.clusterId;
    data['company_id'] = this.companyId;
    data['employee_id_auto_genrated'] = this.employeeIdAutoGenrated;
    data['phoneNo'] = this.phoneNo;
    data['email_ids'] = this.emailIds;
    data['jwt_token'] = this.jwtToken;
    data['request_host_name'] = this.requestHostName;
    data['profile'] = this.profile;
    data['user_type'] = this.userType;
    data['customer_code'] = this.customerCode;
    data['user_type_name'] = this.userTypeName;
    data['is_crm'] = this.isCrm;
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  String? id;
  String? title;
  String? tooltip;
  String? translate;
  String? type;
  String? icon;
  List<Children>? children;

  Menu(
      {this.id,
        this.title,
        this.tooltip,
        this.translate,
        this.type,
        this.icon,
        this.children});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    tooltip = json['tooltip'];
    translate = json['translate'];
    type = json['type'];
    icon = json['icon'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['tooltip'] = this.tooltip;
    data['translate'] = this.translate;
    data['type'] = this.type;
    data['icon'] = this.icon;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? title;
  String? type;
  String? icon;
  String? id;
  String? link;

  Children({this.title, this.type, this.icon, this.id, this.link});

  Children.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    icon = json['icon'];
    id = json['id'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['link'] = this.link;
    return data;
  }
}