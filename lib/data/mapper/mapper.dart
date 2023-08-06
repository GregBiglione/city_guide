import 'package:city_guide/app/extension.dart';
import 'package:city_guide/data/response/banner_response.dart';
import 'package:city_guide/data/response/forgot_password_response.dart';
import 'package:city_guide/data/response/store_response.dart';
import 'package:city_guide/domain/model/home_data.dart';
import 'package:city_guide/domain/model/service.dart';

import '../../domain/model/authentication.dart';
import '../../domain/model/banner.dart';
import '../../domain/model/contacts.dart';
import '../../domain/model/customer.dart';
import '../../domain/model/home.dart';
import '../../domain/model/store.dart';
import '../response/home_response.dart';
import '../response/response.dart';
import '../response/service_response.dart';

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

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      this?.id.orZero() ?? ZERO,
      this?.title.orEmpty() ?? EMPTY,
      this?.image.orEmpty() ?? EMPTY,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      this?.id.orZero() ?? ZERO,
      this?.title.orEmpty() ?? EMPTY,
      this?.image.orEmpty() ?? EMPTY,
    );
  }
}

extension BannerResponseMapper on BannerResponse? {
  Banner toDomain() {
    return Banner(
      this?.id.orZero() ?? ZERO,
      this?.link.orEmpty() ?? EMPTY,
      this?.title.orEmpty() ?? EMPTY,
      this?.image.orEmpty() ?? EMPTY,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  Home toDomain() {
    List<Service> mappedServices = (
        this?.data?.services?.map(
            (service) => service.toDomain())
                ?? const Iterable.empty()).cast<Service>().toList();
    List<Store> mappedStores = (
        this?.data?.stores?.map(
                (store) => store.toDomain())
            ?? const Iterable.empty()).cast<Store>().toList();
    List<Banner> mappedBanners = (
        this?.data?.banners?.map(
                (banner) => banner.toDomain())
            ?? const Iterable.empty()).cast<Banner>().toList();
    var data = HomeData(mappedServices, mappedStores, mappedBanners);

    return Home(data);
  }
}