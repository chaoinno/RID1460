import 'package:RID1460/Pages/case_history.dart';
import 'package:RID1460/Pages/home.dart';
import 'package:RID1460/Pages/more.dart';
import 'package:RID1460/Pages/newcase.dart';
import 'package:RID1460/Pages/news.dart';
import 'package:flutter/material.dart';

class BottomNavBarParent extends StatefulWidget {
  BottomNavBarParent({Key key}) : super(key: key);
  @override
  _BottomNavBarParentState createState() => _BottomNavBarParentState();
}

class _BottomNavBarParentState extends State<BottomNavBarParent>
    with SingleTickerProviderStateMixin<BottomNavBarParent> {
  @override

  // Field
  int currentPage = 0;
  AnimationController controller;
  bool expanded = true;

  var tabs;
  @override
  void initState() {
    super.initState();

    tabs = [
      Home(),
      CaseHistory(),
      Newcase(),
      News(),
      More(),
    ];
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
      reverseDuration: Duration(milliseconds: 600),
    );
  }

  // Method

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        backgroundColor: colorScheme.surface,
        selectedItemColor: Colors.orange,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          expanded ? controller.forward() : controller.reverse();
          expanded = !expanded;

          // if (currentPage == 1) {
          //   setState(() {
          //     // iconData = Icons.view_list;
          //     currentPage = 0;
          //   });
          // } else {
          //   setState(() {
          //     // iconData = Icons.view_week;
          //     currentPage = 1;
          //   });
          // }
          print(value);
          setState(() {
            currentPage = value;
          });
          
        },
        items: [
          BottomNavigationBarItem(
            title: Text('หน้าหลัก'),
            icon: Image(
              image: AssetImage("images/home-icon-silhouette.png"),
              height: 25,
              color: currentPage == 0 ? Colors.orange : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('ประวัติการแจ้งเรื่อง'),
            icon: Image(
              image: AssetImage("images/interface.png"),
              height: 25,
              color: currentPage == 1 ? Colors.orange : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('แจ้งเรื่องร้องเรียนใหม่'),
            icon: Image(
              image: AssetImage("images/writing (1).png"),
              height: 25,
              color: currentPage == 2 ? Colors.orange : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('ข่าวสาร'),
            icon: Image(
              image: AssetImage("images/tools-and-utensils.png"),
              height: 25,
              color: currentPage == 3 ? Colors.orange : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('เพิ่มเติม'),
            icon: Image(
              image: AssetImage("images/more.png"),
              height: 25,
              color: currentPage == 4 ? Colors.orange : Colors.grey,
            ),
          ),
        ],
      ),

      body: Container(
        child: tabs[currentPage],
      ),
    );
  }
}
