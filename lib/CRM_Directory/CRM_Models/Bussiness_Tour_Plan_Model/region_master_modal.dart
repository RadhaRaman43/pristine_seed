class RegionMasterModal {
  String? condition;
  String? clusterName;
  dynamic? zoneName;
  String? regionName;

  RegionMasterModal(
      {this.condition, this.clusterName, this.zoneName, this.regionName});

  RegionMasterModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    clusterName = json['cluster_name'];
    zoneName = json['zone_name'];
    regionName = json['region_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['cluster_name'] = this.clusterName;
    data['zone_name'] = this.zoneName;
    data['region_name'] = this.regionName;
    return data;
  }
}