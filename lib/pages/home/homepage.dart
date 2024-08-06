import 'package:caution_companion/pages/home/home_screen.dart';
import 'package:caution_companion/pages/map/map_screen.dart';
import 'package:caution_companion/pages/profile/profile_page.dart';
import 'package:caution_companion/pages/report/reports_page.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  int pageIndex;
  HomePage({super.key, this.pageIndex=0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void onDestinationSelected(int index){
    setState(() {
      widget.pageIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: Colors.transparent,
        onDestinationSelected: onDestinationSelected,
        selectedIndex: widget.pageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: _pageIcon("Home","assets/images/home.svg"),
            selectedIcon: _pageIcon("Home","assets/images/home_selected.svg", isSelected: true),
            label: "Home"
          ),
          NavigationDestination(
            icon: _pageIcon("Map","assets/images/map-alt.svg"),
            selectedIcon: _pageIcon("Map","assets/images/map_selected.svg", isSelected: true),
            label: "Map"
          ),
          NavigationDestination(
            icon: _pageIcon("Reports","assets/images/reports.svg"),
            selectedIcon: _pageIcon("Reports", "assets/images/reports_selected.svg", isSelected: true),
            label: "Reports"
          ),
          NavigationDestination(
            icon: _pageIcon("Profile","assets/images/profile.svg"),
            selectedIcon: _pageIcon("Profile","assets/images/profile_selected.svg", isSelected: true),
            label: "Profile"
          ),
        ],
      ),
      body: [
        const HomeScreen(),
        const MapScreen(),
        ReportPage(),
        const ProfilePage()
      ][widget.pageIndex],
    );
  }

  Widget _pageIcon(String title,String svg,{bool isSelected = false} ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(svg,),
        const SizedBox(height: 8,),
        Text(title, style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w500, fontSize: 12, color:  isSelected ? grey900 : grey500),)
      ],
    );
  }
}