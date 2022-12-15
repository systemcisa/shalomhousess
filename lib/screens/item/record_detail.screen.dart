import 'package:beamer/src/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:shalomhouse/constants/common_size.dart';
import 'package:shalomhouse/data/record_model.dart';
import 'package:shalomhouse/repo/record_service.dart';
import 'package:shalomhouse/states/category_notifier.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class RecordDetailScreen extends StatefulWidget {
  final String recordKey;
  const RecordDetailScreen(this.recordKey, {Key? key}) : super(key: key);

  @override
  _RecordDetailScreenState createState() => _RecordDetailScreenState();
}

class _RecordDetailScreenState extends State<RecordDetailScreen> {
  bool _dealComplete = false;
  PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();
  Size? _size;
  num? _statusBarHeight;
  bool isAppbarCollapsed = false;
  Widget _textGap = SizedBox(
    height: common_padding,
  );
  Widget _divider = Divider(
    height: common_padding * 2 + 2,
    thickness: 2,
    color: Colors.grey[200],
  );
  var _Vdivider = VerticalDivider(
    color: Colors.redAccent,
    width: 80,
    indent: 10,
    endIndent: 10,
    thickness: 2,
  );
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_size == null || _statusBarHeight == null) return;
      if (isAppbarCollapsed) {
        if (_scrollController.offset <
            _size!.width - kToolbarHeight - _statusBarHeight!) {
          isAppbarCollapsed = false;
          setState(() {});
        }
      } else {
        if (_scrollController.offset >
            _size!.width - kToolbarHeight - _statusBarHeight!) {
          isAppbarCollapsed = true;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RecordModel>(
        future: RecordService().getRecord(widget.recordKey),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RecordModel recordModel = snapshot.data!;
            return LayoutBuilder(
              builder: (context, constraints) {
                _size = MediaQuery.of(context).size;
                _statusBarHeight = MediaQuery.of(context).padding.top;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Scaffold(
                      bottomNavigationBar: SafeArea(
                        top: false,
                        bottom: true,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(color: Colors.grey[300]!))),
                          child: Padding(
                            padding: const EdgeInsets.all(common_sm_padding),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: () {},
                                ),
                                VerticalDivider(
                                  thickness: 1,
                                  width: common_sm_padding * 2 + 1,
                                  indent: common_sm_padding,
                                  endIndent: common_sm_padding,
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                  ],
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                TextButton(
                                    onPressed: () {
                                      _dealComplete = true;

                                      context.beamBack();

                                    },
                                    child: Text('사입완료'))
                              ],
                            ),
                          ),
                        ),
                      ),
                      body: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                //          _imagesAppBar(recordModel),
                          SliverPadding(
                            padding: EdgeInsets.all(common_padding),
                            sliver: SliverList(
                                delegate: SliverChildListDelegate([
                                  SizedBox(height: 100,),
                                  Text(
                                    //        ' · ${TimeCalculation.getTimeDiff(orderModel.createdDate)}',
                                    ' ${DateFormat('MM-dd KKmm').format(recordModel.createdDate)}',
                                    style:
                                    Theme.of(context).textTheme.bodyText2,

                                  ),
                                  _textGap,
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('신발A', style: TextStyle(color: Colors.redAccent, fontSize: 20),),
                                            Text('${recordModel.address1.toString()}'),
                                          ],
                                        )
                                        ),
                                        _Vdivider,
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('신발B', style: TextStyle(color: Colors.orangeAccent, fontSize: 20)),
                                            Text('${recordModel.address2.toString()}'),
                                          ],
                                        )
                                        ),

                                      ],
                                    ),
                                  ),
                                  _textGap,
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('신발C', style: TextStyle(color: Colors.deepPurple, fontSize: 20)),
                                            Text('${recordModel.address3.toString()}'),
                                          ],
                                        )
                                        ),
                                        _Vdivider,
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('신발D', style: TextStyle(color: Colors.greenAccent, fontSize: 20)),
                                            Text('${recordModel.address4.toString()}'),
                                          ],
                                        )
                                        ),

                                      ],
                                    ),
                                  ),
                                  _textGap,
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('NUZZON', style: TextStyle(color: Colors.blueAccent, fontSize: 20)),
                                            Text('${recordModel.address5.toString()}'),
                                          ],
                                        )
                                        ),
                                        _Vdivider,
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('THEOT', style: TextStyle(color: Colors.redAccent, fontSize: 20)),
                                            Text('${recordModel.address6.toString()}'),
                                          ],
                                        )
                                        ),

                                      ],
                                    ),
                                  ),
                                  _textGap,
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('DPH', style: TextStyle(color: Colors.orangeAccent, fontSize: 20)),
                                            Text('${recordModel.address7.toString()}'),
                                          ],
                                        )
                                        ),
                                        _Vdivider,
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('NPH', style: TextStyle(color: Colors.deepPurple, fontSize: 20)),
                                            Text('${recordModel.address8.toString()}'),
                                          ],
                                        )
                                        ),
                                      ],
                                    ),
                                  ),
                                  _textGap,
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('CPH', style: TextStyle(color: Colors.greenAccent, fontSize: 20)),
                                            Text('${recordModel.address9.toString()}'),
                                          ],
                                        )
                                        ),
                                        _Vdivider,
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('STUDIO W', style: TextStyle(color: Colors.blueAccent, fontSize: 20)),
                                            Text('${recordModel.address10.toString()}'),
                                          ],
                                        )
                                        ),
                                      ],
                                    ),
                                  ),
                                  _textGap,
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('TECHNO', style: TextStyle(color: Colors.redAccent, fontSize: 20)),
                                            Text('${recordModel.address11.toString()}'),
                                          ],
                                        )
                                        ),
                                        _Vdivider,
                                        Expanded(child:
                                        Column(
                                          children: [
                                            Text('APM', style: TextStyle(color: Colors.greenAccent, fontSize: 20)),
                                            Text('${recordModel.address12.toString()}'),
                                          ],
                                        )
                                        ),
                                      ],
                                    ),
                                  ),
                                  _textGap,
                                  Divider(
                                    height: 2,
                                    thickness: 2,
                                    color: Colors.grey[200],
                                  ),

                                  Text(
                                    recordModel.detail,
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                  _textGap,
                                  // Text(
                                  //   '조회 33',
                                  //   style: Theme.of(context).textTheme.caption,
                                  // ),
                                  // _textGap,

                                  // MaterialButton(
                                  //     padding: EdgeInsets.zero,
                                  //     onPressed: () {},
                                  //     child: Align(
                                  //         alignment: Alignment.centerLeft,
                                  //         child: Text(
                                  //           '이 게시글 신고하기',
                                  //         ))),
                                  Divider(
                                    height: 2,
                                    thickness: 2,
                                    color: Colors.grey[200],
                                  ),
                                ])),
                          ),
                          // SliverToBoxAdapter(
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: common_padding),
                          //     child: Row(
                          //       mainAxisAlignment:
                          //       MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text(
                          //           '님의 판매 상품',
                          //           style:
                          //           Theme.of(context).textTheme.bodyText1,
                          //         ),
                          //         SizedBox(
                          //           width: _size!.width / 4,
                          //           child: MaterialButton(
                          //             padding: EdgeInsets.zero,
                          //             onPressed: () {},
                          //             child: Align(
                          //               alignment: Alignment.centerRight,
                          //               child: Text(
                          //                 '더보기',
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .button!
                          //                     .copyWith(color: Colors.grey),
                          //               ),
                          //             ),
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      height: kToolbarHeight + _statusBarHeight!,
                      child: Container(
                        height: kToolbarHeight + _statusBarHeight!,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black12,
                                  Colors.black12,
                                  Colors.black12,
                                  Colors.black12,
                                  Colors.transparent
                                ])),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      height: kToolbarHeight + _statusBarHeight!,
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          shadowColor: Colors.transparent,
                          backgroundColor: isAppbarCollapsed
                              ? Colors.white
                              : Colors.transparent,
                          foregroundColor:
                          isAppbarCollapsed ? Colors.black87 : Colors.white,
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }
          return Container();
        });
  }

 // SliverAppBar _imagesAppBar(RecordModel recordModel) {
 //    return SliverAppBar(
 //      expandedHeight: _size!.width,
 //      pinned: true,
 //      flexibleSpace: FlexibleSpaceBar(
 //        title: SizedBox(
 //          child: SmoothPageIndicator(
 //              controller: _pageController, // PageController
 //              count: recordModel.imageDownloadUrls.length,
 //              effect: WormEffect(
 //                  dotColor: Colors.white24,
 //                  activeDotColor: Colors.white,
 //                  radius: 2,
 //                  dotHeight: 4,
 //                  dotWidth: 4), // yo// ur preferred effect
 //              onDotClicked: (index) {}),
 //        ),
 //        centerTitle: true,
 //        background: PageView.builder(
 //          controller: _pageController,
 //          allowImplicitScrolling: true,
 //          itemBuilder: (context, index) {
 //            return ExtendedImage.network(
 //              recordModel.imageDownloadUrls[index],
 //              fit: BoxFit.cover,
 //              scale: 0.1,
 //            );
 //          },
 //          itemCount: recordModel.imageDownloadUrls.length,
 //        ),
 //      ),
 //    );
 //  }
}