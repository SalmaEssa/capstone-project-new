import 'package:auto_route/auto_route.dart';
import 'package:axon/UI/home/discover/horizontal_dynamic_section.dart';
import 'package:axon/UI/home/discover/hot_deals_section.dart';
import 'package:axon/UI/home/discover/vertical_dynamic_section.dart';
import 'package:axon/resources/colors.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/UI/home/discover/provider_types_section.dart';
import 'package:axon/shared_widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:axon/main_router.gr.dart';

class DiscoverScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blueAccent,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            title:
                // FittedBox(
                // child:
                Padding(
              padding: const EdgeInsetsDirectional.only(top:10,start:10,bottom: 10),
              child: Row(
                children: [
                  Image.asset(
                    CodeStrings.smallLogo,
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 20),
                    child: Image.asset(CodeStrings.logoName, height: 15),
                  ),
                  Expanded(
                    child: Container(
                      child: FlatButton(
                          onPressed: () {
                            ExtendedNavigator.root
                                .push(Routes.mainSearchScreen);
                          },
                          child: SearchBar()),
                    ),
                  ),
                ],
              ),
            ),
            // ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: AppColors.blueAccent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HotDealsSection(),
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                      child: Container(
                        width: double.infinity,
                        color: AppColors.lightGrayBackground,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HorizontalDynamicSection(),
                            ProviderTypesSection(),
                            VerticalDynamicSection(),
                            Text("data"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
