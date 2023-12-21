import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                toolbarHeight: 0,
                automaticallyImplyLeading: false,
                pinned: true,
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  background: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage('assets/images/sports.png'),
                            radius: 50,
                          ),
                          const Text('Dhinesh', style: TextStyle(fontSize: 40),),
                          OutlinedButton(onPressed: (){}, child: const Text('Edit Profile'))
                        ],
                      )
                    ],
                  ),
                ),
                bottom: const TabBar(
                  tabs: [
                    Text(
                      'Followers',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Following',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          children: [
            Builder(
              builder: (BuildContext context) {
                return CustomScrollView(
                  key: const PageStorageKey<String>('1'),
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: SliverFixedExtentList(
                        itemExtent: 50,
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return ListTile(
                              title: Text('Follower $index'),
                            );
                          },
                          childCount: 30,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            Builder(
              builder: (BuildContext context) {
                return CustomScrollView(
                  key: const PageStorageKey<String>('2'),
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: SliverFixedExtentList(
                        itemExtent: 50,
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return ListTile(
                              title: Text('Following $index'),
                            );
                          },
                          childCount: 30,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
