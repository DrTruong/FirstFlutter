import 'package:enum_to_string/enum_to_string.dart';

class GetStringEnum {
  String value = '';
  final Enum _enum;

  GetStringEnum(this._enum) {
    value = EnumToString.convertToString(_enum);
  }
}
