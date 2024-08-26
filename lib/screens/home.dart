import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<IconData> icons = [
  Icons.location_on,
  Icons.directions_car_sharp,
  Icons.phone_iphone,
  Icons.local_grocery_store,
  Icons.directions_bike,
  Icons.local_cafe,
    Icons.phone,
    Icons.more_vert_sharp,

  ];

  final List<String> imagePath = [
    'assets/images/gode.jpg',
    'assets/images/gode2.jpg',
    'assets/images/gode3.jpg',
  ];
  late List<Widget> _pages;
  late int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = List.generate(
      imagePath.length,
        (index) => ImagePlaceholder(
          imagePath: imagePath[index],
        )

    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Business Listing',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            fontFamily: 'Itim',
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBarItem(CupertinoIcons.home, 'Home',0),
            buildNavBarItem(CupertinoIcons.star_circle, 'Favourites',1),
            const SizedBox(
              width: 10,
            ),
            buildNavBarItem(CupertinoIcons.conversation_bubble, 'Messages',3),
            buildNavBarItem(CupertinoIcons.profile_circled, 'Profile',4),
          ],
        ),
      ),
      floatingActionButton: const ClipOval(
        child: Material(
          color: Colors.amberAccent,
          elevation: 10,
          child: InkWell(
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                CupertinoIcons.add_circled,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Search Business",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                      const SizedBox(
                        height: 10
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height /4,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: imagePath.length,
                              onPageChanged: (value){
                                setState(() {
                                  _activePage = value;
                                });
                              },
                              itemBuilder: (context, index) {
                                return _pages[index];

                              },
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List<Widget>.generate(
                                  _pages.length,
                                    (index) =>  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: InkWell(
                                        onTap: (){
                                          _pageController.animateToPage(
                                              index,
                                              duration: const Duration(milliseconds: 300),
                                              curve: Curves.easeIn);

                                        },
                                        child: CircleAvatar(
                                          radius: 4,
                                          backgroundColor: _activePage == index?Colors.white:Colors.grey,
                                        ),
                                      ),
                                    )
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          fontFamily: 'Itim',
                        ),
                      ),

                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                            itemCount: icons.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index){
                              return  Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey
                                  ),
                                  child: Center(
                                child: Icon(
                                icons[index],
                                  size: 40,
                                  color: Colors.white,
                                ),
                                ),
                              ),
                              );

                        }),
                      ),
                   const SizedBox(
                     height: 10,
                   ),
                   const Text(
                       "Classified",
                     style: TextStyle(
                         fontSize: 20.0,
                         fontWeight: FontWeight.bold,
                         letterSpacing: 2.0,
                         fontFamily: 'Itim'
                     ),
                   ),
            ],
            ),
      ),
      
    );
  }
}
  Widget buildNavBarItem(IconData icon, String label, int index){
  return InkWell(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
        ),
        Text(
          label,
          style:  const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
  }

class ImagePlaceholder extends StatelessWidget {
  final String? imagePath;
  const ImagePlaceholder({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
    imagePath!,
      fit: BoxFit.cover,
    );
  }
}




