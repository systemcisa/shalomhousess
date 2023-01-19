// ignore: duplicate_ignore
// ignore_for_file: constant_identifier_names

import 'package:beamer/beamer.dart';
import 'package:flutter/widgets.dart';
import 'package:shalomhouse/screens/home_screen.dart';
import 'package:shalomhouse/screens/input/category_input_screen.dart';
import 'package:shalomhouse/screens/input/input_screen.dart';
import 'package:shalomhouse/screens/input/record_screen.dart';
import 'package:shalomhouse/screens/item/order_detail.screen.dart';
import 'package:shalomhouse/screens/item/record_detail.screen.dart';
import 'package:shalomhouse/states/category_notifier.dart';
import 'package:shalomhouse/states/select_image_notifier.dart';
import 'package:shalomhouse/utils/logger.dart';
import 'package:provider/provider.dart';

// ignore: constant_identifier_names
const LOCATION_HOME = 'home';
const LOCATION_INPUT = 'input';
const LOCATION_ORDER = 'order';
const LOCATION_ORDER_ID = 'order_id';
const LOCATION_RECORD = 'record';
const LOCATION_RECORD_ID = 'record_id';
const LOCATION_CATEGORY_INPUT = 'category_input';
const LOCATION_CATEGORY_RECORD = 'category_record';


class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [BeamPage(child: const HomeScreen(), key: const ValueKey(LOCATION_HOME))];
  }

  @override
  List get pathBlueprints => ['/'];
}

class InputLocation extends BeamLocation {
  @override
  Widget builder(BuildContext context, Widget navigator) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: categoryNotifier),
          ChangeNotifierProvider(create: (context) => SelectImageNotifier())
        ],
        child: ChangeNotifierProvider.value(
            value: categoryNotifier, child: super.builder(context, navigator)));
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathBlueprintSegments.contains(LOCATION_INPUT))
        BeamPage(key: const ValueKey(LOCATION_INPUT), child: const InputScreen()),
      if (state.pathBlueprintSegments.contains(LOCATION_RECORD))
        BeamPage(key: const ValueKey(LOCATION_RECORD), child: const RecordScreen()),
      if (state.pathBlueprintSegments.contains(LOCATION_CATEGORY_RECORD))
        BeamPage(
            key: const ValueKey(LOCATION_CATEGORY_RECORD),
            child: const CategoryInputScreen()),
    ];
  }

  @override
  // TODO: implement pathBlueprints
  List get pathBlueprints => [
        '/$LOCATION_INPUT',
        '/$LOCATION_INPUT/$LOCATION_CATEGORY_INPUT',
        '/$LOCATION_RECORD',
        '/$LOCATION_RECORD/$LOCATION_CATEGORY_RECORD',
      ];
}

class ItemLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    logger.d('path - ${state.uriBlueprint}\n${state.uri}');
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathParameters.containsKey(LOCATION_ORDER_ID))
        BeamPage(
            key: const ValueKey(LOCATION_ORDER_ID),
            child: OrderDetailScreen(
                state.pathParameters[LOCATION_ORDER_ID] ?? "")),
      if (state.pathParameters.containsKey(LOCATION_RECORD_ID))
        BeamPage(
            key: const ValueKey(LOCATION_RECORD_ID),
            child: RecordDetailScreen(
                state.pathParameters[LOCATION_RECORD_ID] ?? "")),
    ];
  }

  @override
  List get pathBlueprints => [
        '/$LOCATION_ORDER/:$LOCATION_ORDER_ID',
        '/$LOCATION_RECORD/:$LOCATION_RECORD_ID',
      ];
}
