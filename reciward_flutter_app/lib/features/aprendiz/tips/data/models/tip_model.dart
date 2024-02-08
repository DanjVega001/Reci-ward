import 'package:reciward_flutter_app/features/aprendiz/tips/domain/entities/tip_entity.dart';

class TipModel {
  final String? id;
  final String? nombreTips;
  final String? descripcion;

  TipModel({
    required this.id,
    required this.nombreTips,
    required this.descripcion,
  });

  TipEntity toEntity() {
    return TipEntity(
      id: id,
      nombreTips: nombreTips,
      descripcion: descripcion,
    );
  }

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['id'].toString(),
      nombreTips: json['nombre_tips'],
      descripcion: json['descripcion'],
    );
  }
}
