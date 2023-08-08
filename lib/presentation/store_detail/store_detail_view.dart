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
      return Container();
    }
    else {
      return Container();
    }
  }
}
