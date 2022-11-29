import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:hanoimall/constants/common_size.dart';
import 'package:hanoimall/data/record_model.dart';
import 'package:hanoimall/router/locations.dart';
import 'package:hanoimall/states/category_notifier.dart';
import 'package:hanoimall/utils/logger.dart';
import 'package:intl/intl.dart';

class RecordListWidget extends StatelessWidget {
  final RecordModel record;
  double? imgSize;
  RecordListWidget(this.record, {Key? key, this.imgSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imgSize == null) {
      Size size = MediaQuery.of(context).size;
      imgSize = size.width / 6;
    }

    return InkWell(
      onTap: () {
        BeamState beamState = Beamer.of(context).currentConfiguration!;
        String currentPath = beamState.uri.toString();
        String newPath = (currentPath == '/')
            ? '/$LOCATION_RECORD/${record.recordKey}'
            : '$currentPath/${record.recordKey}';
        logger.d('newPath - $newPath');
        context.beamToNamed(newPath);
      },
      child: SizedBox(
        height: imgSize,
        child: Row(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoriesMapEngToKor[record.category] ??
                          "선택",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(
                          decoration:
                          TextDecoration.underline),
                    ),
                    Text(
                      record.title,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      record.detail,
                      maxLines:1,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text('${record.price.toString()},000원',style: Theme.of(context).textTheme.subtitle2),
                    Text(
                      DateFormat('MM-dd kkmm').format(record.createdDate),

                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                )),
            SizedBox(
              width: common_sm_padding,
            ),
            SizedBox(
                height: imgSize,
                width: imgSize,
                child: ExtendedImage.network(
                  record.imageDownloadUrls[0],
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                )),
          ],
        ),
      ),
    );
  }
}