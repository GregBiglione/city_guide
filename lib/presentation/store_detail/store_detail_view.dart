import 'package:city_guide/domain/model/detail_store.dart';
import 'package:city_guide/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:city_guide/presentation/store_detail/store_detail_view_model.dart';
import 'package:flutter/material.dart';

import '../../app/di/di.dart';

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
    return SingleChildScrollView(
      child: Scaffold(
        body: StreamBuilder<FlowState>(
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

  Widget _getContentWidget() => StreamBuilder<StoreDetail>(
    stream: _viewModel.outputStoreDetail,
    builder: (context, snapshot) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      );
    },
  );
}
