import 'package:city_guide/domain/model/home_data.dart';
import 'package:city_guide/domain/model/service.dart';
import 'package:city_guide/domain/model/store.dart';
import 'package:city_guide/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:city_guide/presentation/main/home/home_view_model.dart';
import 'package:city_guide/presentation/ressource/color_manager.dart';
import 'package:city_guide/presentation/ressource/string_manager.dart';
import 'package:city_guide/presentation/ressource/value_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../app/di/di.dart';
import '../../../domain/model/banner.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../ressource/language_manager.dart';
import '../../ressource/route_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
              builder: (context, snapshot) {
                return snapshot.data?.getWidgetScreen(
                  context,
                  _getContentWidget(),
                  () {
                    _viewModel.start();
                  }
                ) ?? _getContentWidget();
              },
          ),
      ),
    );
  }

  Widget _getContentWidget() => StreamBuilder<HomeData>(
    stream: _viewModel.outputHomeData,
    builder: (context, snapshot) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getCarouselBanner(snapshot.data?.banners),
          _getSection(AppString.services.tr()),
          _getService(snapshot.data?.services),
          _getSection(AppString.stores.tr()),
          _getStore(snapshot.data?.stores),
        ],
      );
    },
  );

  //----------------------------------------------------------------------------
  // Banner widget
  //----------------------------------------------------------------------------

  Widget _getCarouselBanner(List<BannerAd>? banners) {
    if(banners != null) {
      return CarouselSlider(
        items: banners.map(
                (banner) => SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: AppSize.s1_5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSize.s12,
                      ),
                      side: BorderSide(
                        color: ColorManager.white,
                        width: AppSize.s1_5,
                      )
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSize.s12,
                      ),
                      child: Image.network(
                        banner.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
        ).toList(),
        options: CarouselOptions(
          height: AppSize.s190,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    }
    else {
      return Container();
    }
  }

  //----------------------------------------------------------------------------
  // Service widget
  //----------------------------------------------------------------------------

  Widget _getService(List<Service>? services) {
    if(services != null) {
      //setArabicTitle(services);
      return Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
        ),
        child: Container(
          height: AppSize.s140,
          margin: const EdgeInsets.symmetric(
            vertical: AppMargin.m12,
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services.map((service) => Card(
              elevation: AppSize.s4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppSize.s12,
                ),
                side: BorderSide(
                  color: ColorManager.white,
                  width: AppSize.s1_5,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSize.s12,
                      ),
                      child: Image.network(
                        service.image,
                        fit: BoxFit.cover,
                        width: AppSize.s100,
                        height: AppSize.s100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppPadding.p8),
                    child: Align(
                      alignment: Alignment.center,
                      child: context.locale == ARABIC_LOCALE
                          ? Text(
                             "${AppString.service.tr()} ${service.id}",
                             textAlign: TextAlign.center,
                            )
                          : Text(
                             service.title,
                             textAlign: TextAlign.center,
                            ).tr(),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      );
    }
    else {
      return Container();
    }
  }

  //----------------------------------------------------------------------------
  // Store widget
  //----------------------------------------------------------------------------

  Widget _getStore(List<Store>? stores) {
    if(stores != null) {
      return Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(
                stores.length, (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.storeDetailRoute);
                    },
                    child: Card(
                      elevation: AppSize.s4,
                      child: Image.network(
                        stores[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
    else {
      return Container();
    }
  }

  //----------------------------------------------------------------------------
  // Section widget
  //----------------------------------------------------------------------------

  Widget _getSection(String title) => Padding(
    padding: const EdgeInsets.only(
      top: AppPadding.p12,
      right: AppPadding.p12,
      bottom: AppPadding.p2,
      left: AppPadding.p12,
    ),
    child: Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    ),
  );
}
