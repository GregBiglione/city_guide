import 'package:city_guide/domain/model/detail_store.dart';
import 'package:city_guide/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:city_guide/presentation/ressource/color_manager.dart';
import 'package:city_guide/presentation/store_detail/store_detail_view_model.dart';
import 'package:flutter/material.dart';

import '../../app/di/di.dart';
import '../ressource/string_manager.dart';
import '../ressource/value_manager.dart';

class StoreDetailView extends StatefulWidget {
  const StoreDetailView({Key? key}) : super(key: key);

  @override
  State<StoreDetailView> createState() => _StoreDetailViewState();
}

class _StoreDetailViewState extends State<StoreDetailView> {
  final StoreDetailViewModel _viewModel = instance<StoreDetailViewModel>();

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
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getWidgetScreen(
              context,
              _getContentWidget(),
                  () {
                _viewModel.start();
              }
          ) ?? Container();
        },
      ),
    );
  }

  Widget _getContentWidget() => Scaffold(
    backgroundColor: ColorManager.white,
    appBar: AppBar(
      title: const Text(AppString.storeDetails),
      elevation: AppSize.s0,
      iconTheme: IconThemeData(
        //back button
        color: ColorManager.white,
      ),
      backgroundColor: ColorManager.primary,
      centerTitle: true,
    ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: StreamBuilder<StoreDetail>(
            stream: _viewModel.outputStoreDetail,
            builder: (context, snapshot) {
              return _getItems(snapshot.data);
            },
          ),
        ),
      ),
  );

  //----------------------------------------------------------------------------
  // Items
  //----------------------------------------------------------------------------

  Widget _getItems(StoreDetail? storeDetail) {
    if(storeDetail != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.network(
                storeDetail.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
          ),
          _getSection(AppString.details),
          _getSection(AppString.services),
          _getSection(AppString.about),
        ],
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
