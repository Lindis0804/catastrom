import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/enums/loading_status.enum.dart';
import 'package:template/common/utils/env.dart';
import 'package:template/common/utils/size.dart';
import 'package:template/common/widgets/custom_image.widget.dart';
import 'package:template/generated/assets.gen.dart';
import 'package:template/pages/home/bloc/home.bloc.dart';
import 'package:template/pages/home/screen/my_plan.item.dart';
import 'package:template/pages/home/screen/recommended_place.item.dart';

class Home extends StatefulWidget {
  final HomeBloc homeBloc;
  const Home({super.key, required this.homeBloc});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.homeBloc.add(const Inititalize());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            Image(
              image: Assets.images.defaultCover.provider(),
              width: double.infinity,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              //  extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                actions: [
                  CustomImage.network(
                      imageUrl: state.user?.avatar ?? EnvVariable.defaultAvatar,
                      width: 30,
                      height: 30,
                      radius: 15),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              drawer: Drawer(
                child: ListView(),
              ),
              body: Container(
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good morning, ${state.user?.lastName}',
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              Text(
                                'Đại Lộ Thăng Long, Hà Nội',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Tìm kiếm địa điểm',
                                suffixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Đề xuất',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Xem tất cả',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Icon(
                                        Icons.arrow_right_outlined,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                  onTap: () {},
                                )
                              ],
                            ),
                            state.recommendedPlaces != null &&
                                    state.recommendedPlaces!.isNotEmpty
                                ? SizedBox(
                                    height: screenHeight * 0.23,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          state.recommendedPlaces!.length,
                                      itemBuilder: (context, idx) {
                                        return RecommendedPlaceItem(
                                            recommendedPlace:
                                                state.recommendedPlaces![idx]);
                                      },
                                      separatorBuilder: (context, idx) {
                                        return const SizedBox(
                                          width: 10,
                                        );
                                      },
                                    ),
                                  )
                                : const Text('Không có địa điểm được đề xuất'),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Lịch trình của tôi',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: state.myPlans != null &&
                                      state.myPlans!.isNotEmpty
                                  ? ListView.separated(
                                      itemBuilder: (context, idx) {
                                        return MyPlanItem(
                                          plan: state.myPlans![idx],
                                        );
                                      },
                                      separatorBuilder: (context, idx) {
                                        return const SizedBox(
                                          height: 5,
                                        );
                                      },
                                      itemCount: state.myPlans!.length)
                                  : const Text('Không có lịch trình'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(),
        child: BlocListener<HomeBloc, HomeState>(
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => Home(
              homeBloc: context.read<HomeBloc>(),
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, HomeState state) {
  switch (state.homeStatus) {
    case LoadingStatus.initialize:
    default:
  }
}
