class VillageDataModel {
  VillageDataModel({
    required this.status,
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  final int? status;
  final bool? success;
  final int? code;
  final String? message;
  final List<Datum> data;

  factory VillageDataModel.fromJson(Map<String, dynamic> json) {
    return VillageDataModel(
      status: json["status"],
      success: json["success"],
      code: json["code"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "code": code,
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
      };
}

class Datum {
  Datum({
    required this.vCode,
    required this.vName,
    required this.vHname,
    required this.vYear,
  });

  final String? vCode;
  final String? vName;
  final String? vHname;
  final String? vYear;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      vCode: json["V_CODE"],
      vName: json["V_NAME"],
      vHname: json["V_HNAME"],
      vYear: json["V_YEAR"],
    );
  }

  Map<String, dynamic> toJson() => {
        "V_CODE": vCode,
        "V_NAME": vName,
        "V_HNAME": vHname,
        "V_YEAR": vYear,
      };
}
