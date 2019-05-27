import 'package:json_annotation/json_annotation.dart';

part 'send_code_model.g.dart';

@JsonSerializable(nullable: false)
class SendCodeModel extends Object {

  @JsonKey(name: 'data')
  String data;

  @JsonKey(name: 'errorInfo')
  String errorInfo;

  @JsonKey(name: 'statusCode')
  int statusCode;

  SendCodeModel(this.data,this.errorInfo,this.statusCode,);


  factory SendCodeModel.fromJson(Map<String, dynamic> srcJson) => _$SendCodeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SendCodeModelToJson(this);

}


