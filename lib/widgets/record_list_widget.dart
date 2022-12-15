import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:shalomhouse/constants/common_size.dart';
import 'package:shalomhouse/data/record_model.dart';
import 'package:shalomhouse/router/locations.dart';
import 'package:shalomhouse/states/category_notifier.dart';
import 'package:shalomhouse/utils/logger.dart';
import 'package:intl/intl.dart';



var _Vdivider = VerticalDivider(
  color: Colors.redAccent,
  width: 80,
  indent: 10,
  endIndent: 10,
  thickness: 2,
);


class RecordListWidget extends StatelessWidget {
  final RecordModel record;
  double? imgSize;
  RecordListWidget(this.record, {Key? key, this.imgSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imgSize == null) {
      Size size = MediaQuery.of(context).size;
      imgSize = size.width / 300;
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
       // height: imgSize,
       height: 110,
        child: Column(
          children: [
            Text(
              DateFormat('MM-dd kkmm').format(record.createdDate),
              style:  TextStyle(fontSize: 20)
            ),
            Expanded(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '신발A',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                            decoration:
                            TextDecoration.underline),
                      ),
                      Text(
                        record.address1,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  _Vdivider,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NUZZON',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                            decoration:
                            TextDecoration.underline),
                      ),
                      Text(
                        record.address2,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),


                  SizedBox(
                    width: common_sm_padding,
                  ),

                  // SizedBox(
                  //     height: imgSize,
                  //     width: imgSize,
                  //     child:
                  //     ExtendedImage.network(
                  //       record.imageDownloadUrls[0],
                  //       fit: BoxFit.cover,
                  //       shape: BoxShape.rectangle,
                  //       borderRadius: BorderRadius.circular(12),
                  //     )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}