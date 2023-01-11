import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shalomhouse/constants/data_keys.dart';

class RecordModel {
  late String recordKey;
  late String userKey;
  late String studentname;
  late String studentnum;
  late List<String> imageDownloadUrls;
  late String recorddate;
  late String title;
  late String category;
  late num price;
  late bool negotiable;
  late String detail;
  late String address;
  late bool isChecked1;
  late bool isChecked2;
  late bool isChecked3;
  late bool isChecked4;
  late bool isChecked5;
  late bool isChecked6;
  late bool isChecked7;
  late bool isChecked8;
  late bool isChecked9;
  late DateTime createdDate;

  RecordModel({
    required this.recordKey,
    required this.userKey,
    required this.studentname,
    required this.studentnum,
    required this.imageDownloadUrls,
    required this.title,
    required this.recorddate,
    required this.category,
    required this.price,
    required this.negotiable,
    required this.detail,
    required this.address,
    required this.isChecked1,
    required this.isChecked2,
    required this.isChecked3,
    required this.isChecked4,
    required this.isChecked5,
    required this.isChecked6,
    required this.isChecked7,
    required this.isChecked8,
    required this.isChecked9,
    required this.createdDate,
  });

  RecordModel.fromJson(Map<String, dynamic> json, this.recordKey,) {
    userKey = json[DOC_USERKEY] ?? "";
    studentname = json[DOC_STUDENTNAME] ?? "";
    studentnum = json[DOC_STUDENTNUM] ?? "";
     imageDownloadUrls = json[DOC_IMAGEDOWNLOADURLS] != null
         ? json[DOC_IMAGEDOWNLOADURLS].cast<String>()
         : [];
    title = json[DOC_TITLE] ?? "";
    recorddate = json[DOC_RECORDDATE] ?? "";
    category = json[DOC_CATEGORY] ?? "none";
    price = json[DOC_PRICE] ?? 0;
    negotiable = json[DOC_NEGOTIABLE] ?? false;
    detail = json[DOC_DETAIL] ?? "";
    address = json[DOC_ADDRESS] ?? "";
    isChecked1 = json[DOC_ISCHECKED1] ?? false;
    isChecked2 = json[DOC_ISCHECKED2] ?? false;
    isChecked3 = json[DOC_ISCHECKED3] ?? false;
    isChecked4 = json[DOC_ISCHECKED4] ?? false;
    isChecked5 = json[DOC_ISCHECKED5] ?? false;
    isChecked6 = json[DOC_ISCHECKED6] ?? false;
    isChecked7 = json[DOC_ISCHECKED7] ?? false;
    isChecked8 = json[DOC_ISCHECKED8] ?? false;
    isChecked9 = json[DOC_ISCHECKED9] ?? false;
    createdDate = json[DOC_CREATEDDATE] == null
        ? DateTime.now().toUtc()
        : (json[DOC_CREATEDDATE] as Timestamp).toDate();
  }

  RecordModel.fromAlgoliaObject(Map<String, dynamic> json, this.recordKey) {
    userKey = json[DOC_USERKEY] ?? "";
    studentname = json[DOC_STUDENTNAME] ?? "";
    studentnum = json[DOC_STUDENTNUM] ?? "";
    imageDownloadUrls = json[DOC_IMAGEDOWNLOADURLS] != null
         ? json[DOC_IMAGEDOWNLOADURLS].cast<String>()
         : [];
    title = json[DOC_TITLE] ?? "";
    recorddate = json[DOC_RECORDDATE] ?? "";
    category = json[DOC_CATEGORY] ?? "none";
    negotiable = json[DOC_NEGOTIABLE] ?? false;
    price = json[DOC_PRICE] ?? 0;
    detail = json[DOC_DETAIL] ?? "";
    address = json[DOC_ADDRESS] ?? "";
    isChecked1 = json[DOC_ISCHECKED1] ?? false;
    isChecked2 = json[DOC_ISCHECKED2] ?? false;
    isChecked3 = json[DOC_ISCHECKED3] ?? false;
    isChecked4 = json[DOC_ISCHECKED4] ?? false;
    isChecked5 = json[DOC_ISCHECKED5] ?? false;
    isChecked6 = json[DOC_ISCHECKED6] ?? false;
    isChecked7 = json[DOC_ISCHECKED7] ?? false;
    isChecked8 = json[DOC_ISCHECKED8] ?? false;
    isChecked9 = json[DOC_ISCHECKED9] ?? false;
    createdDate = DateTime.now().toUtc();
  }

  RecordModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.id);

  RecordModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[DOC_USERKEY] = userKey;
    map[DOC_STUDENTNAME] = studentname;
    map[DOC_STUDENTNUM] = studentnum;
    map[DOC_IMAGEDOWNLOADURLS] = imageDownloadUrls;
    map[DOC_TITLE] = title;
    map[DOC_RECORDDATE] = recorddate;
    map[DOC_CATEGORY] = category;
    map[DOC_PRICE] = price;
    map[DOC_NEGOTIABLE] = negotiable;
    map[DOC_DETAIL] = detail;
    map[DOC_ADDRESS] = address;
    map[DOC_ISCHECKED1] = isChecked1;
    map[DOC_ISCHECKED2] = isChecked2;
    map[DOC_ISCHECKED3] = isChecked3;
    map[DOC_ISCHECKED4] = isChecked4;
    map[DOC_ISCHECKED5] = isChecked5;
    map[DOC_ISCHECKED6] = isChecked6;
    map[DOC_ISCHECKED7] = isChecked7;
    map[DOC_ISCHECKED8] = isChecked8;
    map[DOC_ISCHECKED9] = isChecked9;
    map[DOC_CREATEDDATE] = createdDate;
    return map;
  }

  Map<String, dynamic> toMinJson() {
    var map = <String, dynamic>{};
    map[DOC_IMAGEDOWNLOADURLS] = imageDownloadUrls.sublist(0, 1);
    map[DOC_TITLE] = title;
    map[DOC_PRICE] = price;
    return map;
  }

  static String generateItemKey(String uid) {
    String timeInMilli = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    return '${uid}_$timeInMilli';
  }
}