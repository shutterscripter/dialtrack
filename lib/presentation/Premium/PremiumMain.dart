import 'package:flutter/material.dart';
import 'package:mithilesh_s_application1/core/utils/image_constant.dart';
import 'package:mithilesh_s_application1/core/utils/size_utils.dart';
import 'package:mithilesh_s_application1/presentation/Premium/PremiumPage01.dart';
import 'package:mithilesh_s_application1/presentation/Premium/PremiumPage02.dart';
import 'package:mithilesh_s_application1/presentation/Premium/PremiumPage03.dart';

class PremiumMain extends StatefulWidget {
  const PremiumMain({Key? key}) : super(key: key);

  @override
  State<PremiumMain> createState() => _PremiumMainState();
}

class _PremiumMainState extends State<PremiumMain>
    with SingleTickerProviderStateMixin {
  late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController?.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      // Update images based on the selected tab index
      // You can modify this logic according to your image requirements
      switch (_tabController?.index) {
        case 0:
          // Selected Premium tab
          ImageConstant.premiumActive;
          break;
        case 1:
          // Selected Premium Plus tab
          ImageConstant.premiumPlusActive;
          break;
        case 2:
          // Selected Callyzer Biz tab
          ImageConstant.callyzerBizActive;
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Upgrade To Premium",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          bottom: TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelPadding: EdgeInsets.only(left: 0, right: 0),
            tabs: [
              Tab(
                child: Column(
                  children: [
                    Image.asset(
                      _tabController?.index == 0
                          ? ImageConstant.premiumActive
                          : ImageConstant.premiumInactive,
                      height: 25.v,
                    ),
                    Text("Premium"),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Image.asset(
                      _tabController?.index == 1
                          ? ImageConstant.premiumPlusActive
                          : ImageConstant.premiumPlusInactive,
                      height: 25.v,
                    ),
                    Text("Premium Plus"),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Image.asset(
                      _tabController?.index == 2
                          ? ImageConstant.callyzerBizActive
                          : ImageConstant.callyzerBizInactive,
                      height: 25.v,
                    ),
                    Text("Premium Ultra"),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            PremiumPage01(),
            PremiumPage02(),
            PremiumPage03(),
          ],
        ),
      ),
    );
  }
}
