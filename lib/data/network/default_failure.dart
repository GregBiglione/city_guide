import 'package:city_guide/data/network/failure.dart';
import 'package:city_guide/data/network/response_code.dart';
import 'package:city_guide/data/network/response_message.dart';

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
}