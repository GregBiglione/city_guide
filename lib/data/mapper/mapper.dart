import 'package:city_guide/app/extension.dart';
import 'package:city_guide/data/response/forgot_password_response.dart';

import '../../domain/model/authentication.dart';
import '../../domain/model/contacts.dart';
import '../../domain/model/customer.dart';
import '../response/response.dart';

const EMPTY = "";
const ZERO = 0;

// To convert response to a non nullable object --------------------------------
extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? EMPTY,
      this?.name?.orEmpty() ?? EMPTY,
      this?.numberOfNotification?.orZero() ?? ZERO,
    );
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.phone?.orEmpty() ?? EMPTY,
      this?.link?.orEmpty() ?? EMPTY,
      this?.email?.orEmpty() ?? EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contact.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.supportMessage.orEmpty() ?? EMPTY;
  }
}