import 'package:hive/hive.dart';

part 'emd_model.g.dart';

@HiveType(typeId: 100)
class EmdModel {
  @HiveField(0)
  final String input_fid;
  @HiveField(1)
  final String emd_cd;
  @HiveField(2)
  final String emd_nm;
  @HiveField(3)
  final int ssg_oid;
  @HiveField(4)
  final String col_adm_se;
  @HiveField(5)
  final int gid;

  EmdModel({
    required this.input_fid,
    required this.emd_cd,
    required this.emd_nm,
    required this.ssg_oid,
    required this.col_adm_se,
    required this.gid,
  });

  EmdModel.fromJson(Map<String, dynamic> json)
      : input_fid = json['INPUT_FID'],
        emd_cd = json['EMD_CD'],
        emd_nm = json['EMD_NM'],
        ssg_oid = json['SGG_OID'],
        col_adm_se = json['COL_ADM_SE'],
        gid = json['GID'];

  dynamic getValue(int idx) {
    switch (idx) {
      case 0:
        return input_fid;
      case 1:
        return emd_cd;
      case 2:
        return emd_nm;
      case 3:
        return ssg_oid;
      case 4:
        return col_adm_se;
      default:
        return gid;
    }
  }

  dynamic getValueFromName(String colName) {
    switch (colName) {
      case 'INPUT_FID':
        return input_fid;
      case 'EMD_CD':
        return emd_cd;
      case 'EMD_NM':
        return emd_nm;
      case 'SGG_OID':
        return ssg_oid;
      case 'COL_ADM_SE':
        return col_adm_se;
      default:
        return gid;
    }
  }
}

