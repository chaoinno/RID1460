import 'package:RID1460/Pages/home.dart';
import 'package:RID1460/Pages/newcase.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final items = List<String>.generate(10000, (i) => "Item $i");

  int _selectedIndex = 3;


  PageController _pageController;

    @override
  void initState()
  {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose()
  {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Home());
        Navigator.of(context).push(materialPageRoute);
        _pageController.animateToPage(index, duration: null, curve: Curves.easeOut);
      } else if (index == 2) {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Newcase());
        Navigator.of(context).push(materialPageRoute);
        _pageController.animateToPage(index, duration: null, curve: Curves.easeOut);
      }
      //MaterialPageRoute materialPageRoute =
      // MaterialPageRoute(builder: (BuildContext context) => Authen());
      //Navigator.of(context).pop();
      //Navigator.of(context).push(materialPageRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("ข่าวสาร")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {},
                //controller: editingController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                   
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${items[index]}"),
                    tileColor: Colors.white,
                  );
                }),),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/home-icon-silhouette.png"),
              height: 25,
              //width: 25,
            ),
            title: Text('หน้าหลัก'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/interface.png"),
              height: 25,
              width: 25,
            ),
            title: Text('ประวัติการแจ้งเรื่อง'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/writing (1).png"),
              height: 25,
              color: Colors.grey,
              //width: 25,
            ),
            title: Text('แจ้งเรื่องร้องเรียนใหม่'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/tools-and-utensils.png"),
              height: 25,
              color: Colors.orange,
              // width: 25,
            ),
            title: Text('ข่าวสาร'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/more.png"),
              height: 25,
              color: Colors.grey,
              // width: 25,
            ),
            title: Text('เพิ่มเติม'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }
}
