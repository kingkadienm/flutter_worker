import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable(nullable: false)
class AccountModel {
  /**
   * expires : null
   * jrwyToken : eyJhbGciOiJSUzI1NiJ9.eyJpZCI6NiwibW9iaWxlIjoiMTMzMzExMTAwMDAiLCJleHAiOjE1NTMzMzQ5NzV9.H74Sqn_AKErLCdBTkoSPaRGssBUzg-b98AJNOZPVn5R8lIFE0PjdAj664zIHAcmF_KxBokXo84qswv_MXQTxN_5wapDfvKmlvaEm-bbO93weJLL09zezddbsCb1fhrbq5U9T2sBreU2dv0hEo-wc_6OMcb7MoahcstjkpY7FfmQ
   * name :
   * userid : 6
   */
  AccountModel({this.jrwyToken, this.name, this.userid, this.technicianId});

  String jrwyToken;
  String name;
  int userid;
  int technicianId;

  factory AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}