import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shalomhouse/constants/data_keys.dart';


class RecordModel {
  late String recordKey;
  late List<String> imageDownloadUrls;
  late String recorddate;
  late String title;
  late String category;
  late num price;
  late String detail;
  late String address;

  late DateTime createdDate;

  RecordModel({required this.recordKey,

    required this.imageDownloadUrls,
    required this.title,
    required this.recorddate,
    required this.category,
    required this.price,
    required this.detail,
    required this.address,
    required this.createdDate,
  });

  RecordModel.fromJson(Map<String, dynamic> json, this.recordKey,) {
     imageDownloadUrls = json[DOC_IMAGEDOWNLOADURLS] != null
         ? json[DOC_IMAGEDOWNLOADURLS].cast<String>()
         : [];
    title = json[DOC_TITLE] ?? "";
    recorddate = json[DOC_RECORDDATE] ?? "";
    category = json[DOC_CATEGORY] ?? "none";
    price = json[DOC_PRICE] ?? 0;
    detail = json[DOC_DETAIL] ?? "";
    address = json[DOC_ADDRESS] ?? "";

    createdDate = json[DOC_CREATEDDATE] == null
        ? DateTime.now().toUtc()
        : (json[DOC_CREATEDDATE] as Timestamp).toDate();
  }

  RecordModel.fromAlgoliaObject(Map<String, dynamic> json, this.recordKey) {
     imageDownloadUrls = json[DOC_IMAGEDOWNLOADURLS] != null
         ? json[DOC_IMAGEDOWNLOADURLS].cast<String>()
         : [];
    title = json[DOC_TITLE] ?? "";
    recorddate = json[DOC_RECORDDATE] ?? "";
    category = json[DOC_CATEGORY] ?? "none";
    price = json[DOC_PRICE] ?? 0;
    detail = json[DOC_DETAIL] ?? "";
    address = json[DOC_ADDRESS] ?? "";
    createdDate = DateTime.now().toUtc();
  }

  RecordModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.id);

  RecordModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[DOC_IMAGEDOWNLOADURLS] = imageDownloadUrls;
    map[DOC_TITLE] = title;
    map[DOC_RECORDDATE] = recorddate;
    map[DOC_CATEGORY] = category;
    map[DOC_PRICE] = price;
    map[DOC_DETAIL] = detail;
    map[DOC_ADDRESS] = address;


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