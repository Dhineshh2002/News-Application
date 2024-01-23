import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String userName;

  const UserProfile({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme
        .of(context)
        .colorScheme;
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
                  background: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                              AssetImage('assets/images/sports.png'),
                              radius: 50,
                            ),
                            Text(
                              userName,
                              style: TextStyle(
                                fontSize: 40,
                                color: color.onBackground,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(color: color.onBackground),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                  tabs: [
                    Text(
                      'Followers',
                      style: TextStyle(fontSize: 20, color: color.onBackground),
                    ),
                    Text(
                      'Following',
                      style: TextStyle(fontSize: 20, color: color.onBackground),
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
