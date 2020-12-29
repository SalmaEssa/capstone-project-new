import 'package:axon/resources/colors.dart';
import 'package:axon/shared_widgets/sliver_screen/page_header.dart';
import 'package:flutter/material.dart';

class SliverScreen extends StatefulWidget {
  final Widget Function(BuildContext scaffoldContext) builder;
  final Widget editWidget;
  final Widget titleWidget;
  final Widget subtitleWidget;
  final double shrinkOpacityFactor;
  SliverScreen({
    @required this.builder,
    this.editWidget,
    this.titleWidget,
    this.subtitleWidget,
    this.shrinkOpacityFactor,
  });

  @override
  _SliverScreenState createState() => _SliverScreenState();
}

class _SliverScreenState extends State<SliverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueAccent,
      body: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverPersistentHeader(
                          pinned: true,
                          floating: true,
                          delegate: PageHeader(
                              widget.editWidget,
                              widget.titleWidget,
                              widget.subtitleWidget,
                              widget.shrinkOpacityFactor),
                        ),
                      ),
                    ],
            body: Builder(builder: (BuildContext context) {
              return CustomScrollView(
                slivers: [
                  SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context)),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      padding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      child: widget.builder(context),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                          color: AppColors.white),
                    ),
                  ),
                ],
              );
            })),
      ),
    );
  }
}
