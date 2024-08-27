import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/appbar/app_bar.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/home/widgets/news_songs.dart';
import 'package:spotify_project/presentation/home/widgets/play_list.dart';
import 'package:spotify_project/presentation/profile/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final kH = MediaQuery.of(context).size.height;
    final kW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        centerTitle: true,
        title: SvgPicture.asset(AppVectors.logo),
        action: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            icon: const Icon(Icons.person)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _homeTopCard(context, kH, kW),
            _tabBar(kH, kW),
            SizedBox(
              height: kH * 0.3,
              child: TabBarView(controller: _tabController, children: [
                const NewsSongs(),
                Container(),
                Container(),
                Container()
              ]),
            ),
            const PlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard(BuildContext context, double kH, double kW) {
    return Center(
      child: SizedBox(
        height: kH * 0.18,
        child: Stack(children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homTopCart)),
          Padding(
            padding: EdgeInsets.only(right: kW * 0.1),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(AppImages.homeArtist)),
          )
        ]),
      ),
    );
  }

  Widget _tabBar(double kH, double kW) {
    return TabBar(
        labelColor: context.isDarkMode ? const Color(0xffDBDBDB) : Colors.black,
        indicatorColor: AppColors.primary,
        dividerHeight: 0,
        unselectedLabelColor: context.isDarkMode
            ? const Color(0xff616161)
            : const Color(0xffBEBEBE),
        controller: _tabController,
        padding: EdgeInsets.symmetric(vertical: kH * 0.03),
        tabAlignment: TabAlignment.center,
        isScrollable: true,
        tabs: const [
          Text('News',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text('Videos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text('Artists',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text('Podcasts',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ]);
  }
}
