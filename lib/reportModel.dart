class ReportDetailModel {
  int status;
  bool success;
  int code;
  String message;
  List<Datum> data;

  ReportDetailModel({
    required this.status,
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory ReportDetailModel.fromJson(Map<String, dynamic> json) {
    return ReportDetailModel(
      status: json['status'],
      success: json['success'],
      code: json['code'],
      message: json['message'],
      data: (json['data'] as List).map((item) => Datum.fromJson(item)).toList(),
    );
  }
}

class Datum {
  int id;
  String season;
  int millId;
  int userId;
  String typeOfIndent;
  String plotVillageCode;
  String plotVillageName;
  dynamic plotSerialNo;
  String villageCode;
  int growerCode;
  String landType;
  String rowSpace;
  String plantingMethod;
  String seedSource;
  String seedType;
  String varietyType;
  String leaseOrOwnLand;
  String areaInAcre;
  String areaInHectare;
  DateTime indentingDate;
  DateTime expectingPlantingDate;
  String createdAt;
  DateTime updatedAt;
  String vZone;
  String zLocn;
  String zonalIncharge;
  String blkName;
  String vBlock;
  String blockIncharge;
  String vCircle;
  String crName;
  String fdsIncharge;
  String villageName;
  dynamic growerName;
  dynamic growerFatherName;

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Season': season,
      'Mill ID': millId,
      'User ID': userId,
      'Type of Indent': typeOfIndent,
      // Add other fields as needed
    };
  }

  Datum({
    required this.id,
    required this.season,
    required this.millId,
    required this.userId,
    required this.typeOfIndent,
    required this.plotVillageCode,
    required this.plotVillageName,
    required this.plotSerialNo,
    required this.villageCode,
    required this.growerCode,
    required this.landType,
    required this.rowSpace,
    required this.plantingMethod,
    required this.seedSource,
    required this.seedType,
    required this.varietyType,
    required this.leaseOrOwnLand,
    required this.areaInAcre,
    required this.areaInHectare,
    required this.indentingDate,
    required this.expectingPlantingDate,
    required this.createdAt,
    required this.updatedAt,
    required this.vZone,
    required this.zLocn,
    required this.zonalIncharge,
    required this.blkName,
    required this.vBlock,
    required this.blockIncharge,
    required this.vCircle,
    required this.crName,
    required this.fdsIncharge,
    required this.villageName,
    required this.growerName,
    required this.growerFatherName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      season: json['season'],
      millId: json['mill_id'],
      userId: json['user_id'],
      typeOfIndent: json['type_of_indent'],
      plotVillageCode: json['plot_village_code'],
      plotVillageName: json['plot_village_name'],
      plotSerialNo: json['plot_serial_no'],
      villageCode: json['village_code'],
      growerCode: json['grower_code'],
      landType: json['land_type'],
      rowSpace: json['row_space'],
      plantingMethod: json['planting_method'],
      seedSource: json['seed_source'],
      seedType: json['seed_type'],
      varietyType: json['variety_type'],
      leaseOrOwnLand: json['lease_or_own_land'],
      areaInAcre: json['area_in_acre'],
      areaInHectare: json['area_in_hectare'],
      indentingDate: DateTime.parse(json['indenting_date']),
      expectingPlantingDate: DateTime.parse(json['expecting_planting_date']),
      createdAt: json['created_at'],
      updatedAt: DateTime.parse(json['updated_at']),
      vZone: json['v_zone'],
      zLocn: json['z_locn'],
      zonalIncharge: json['zonal_incharge'],
      blkName: json['blk_name'],
      vBlock: json['v_block'],
      blockIncharge: json['block_incharge'],
      vCircle: json['v_circle'],
      crName: json['cr_name'],
      fdsIncharge: json['fds_incharge'],
      villageName: json['village_name'],
      growerName: json['grower_name'],
      growerFatherName: json['grower_father_name'],
    );
  }
}
