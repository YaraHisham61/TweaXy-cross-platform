import 'package:flutter/material.dart';
import 'package:tweaxy/components/HomePage/Tweet/tweet.dart';
import 'package:tweaxy/components/HomePage/WebComponents/add_post.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/models/tweet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/services/Tweets.dart';
import 'package:tweaxy/views/loading_screen.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key, required this.tabController});
  final TabController tabController;

  final List<Map<String, String>> temp = const [
    {
      'likesCount': '1',
      'viewsCount': '2',
      'retweetsCount': '3',
      'commentsCount': '4',
      'id': '1',
      'userid': '1',
      'userImage': 'assets/girl.jpg',
      'image': 'assets/nature.jpeg',
      'userName': 'Menna Ahmed',
      'userHandle': 'MennaAhmed71',
      'time': '4h',
      'tweetText':
          'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '
    },
    {
      'likesCount': '1',
      'viewsCount': '2',
      'retweetsCount': '3',
      'commentsCount': '4',
      'id': '2',
      'userid': '2',
      'userImage': 'assets/girl.jpg',
      'image': 'assets/nature.jpeg',
      'userName': 'Menna Ahmed',
      'userHandle': 'MennaAhmed71',
      'time': '4h',
      'tweetText':
          'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '
    },
    {
      'likesCount': '1',
      'viewsCount': '2',
      'retweetsCount': '3',
      'commentsCount': '4',
      'id': '3',
      'userid': '3',
      'userImage': 'assets/girl.jpg',
      'image': 'assets/nature.jpeg',
      'userName': 'Menna Ahmed',
      'userHandle': 'MennaAhmed71',
      'time': '4h',
      'tweetText':
          'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '
    },
    {
      'likesCount': '1',
      'viewsCount': '2',
      'retweetsCount': '3',
      'commentsCount': '4',
      'id': '4',
      'userid': '4',
      'userImage': 'assets/girl.jpg',
      'image': 'assets/nature.jpeg',
      'userName': 'Menna Ahmed',
      'userHandle': 'MennaAhmed71',
      'time': '4h',
      'tweetText':
          'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '
    },
    {
      'likesCount': '1',
      'viewsCount': '2',
      'retweetsCount': '3',
      'commentsCount': '4',
      'id': '5',
      'userid': '5',
      'userImage': 'assets/girl.jpg',
      'image': 'assets/nature.jpeg',
      'userName': 'Menna Ahmed',
      'userHandle': 'MennaAhmed71',
      'time': '4h',
      'tweetText':
          'Nature is the reason behind all lives dwelling on the earth. It is the blessing of invisible power for all living organisms. '
    }
  ];
  List<Tweet> initializeTweets(List<Map<String, dynamic>> temp) {
    print('hhh' + temp.toString());
    return temp
        .map((e) => Tweet(
              id: e['id']!,
              image: e['image'],
              userImage: e['userImage']!,
              userHandle: e['userHandle']!,
              userName: e['userName']!,
              time: e['time']!,
              tweetText: e['tweetText'],
              userId: e['userid'],
              likesCount: 1,
              viewsCount: 1,
              retweetsCount: 1,
              commentsCount: 1,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Tweet> tweets = initializeTweets(temp);
    return FutureBuilder(
      future: Tweets.getTweetsHome(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          print('tt' + Tweets.getTweetsHome().toString());
          return const Scaffold(
            body: Column(
              children: [
                Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                )),
                kIsWeb
                    ? CustomWebToast(message: 'Connection Error')
                    : CustomToast(message: 'Connection Error')
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Column(
              children: [
                Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                )),
                kIsWeb
                    ? CustomWebToast(message: snapshot.error.toString())
                    : CustomToast(message: snapshot.error.toString())
              ],
            ),
          );
        } else {
          print('tt' + Tweets.getTweetsHome().toString());

          print('tw' + snapshot.data!.toString());
          List<Map<String, dynamic>> s = snapshot.data!;
          print(s);
          List<Tweet> tweets = initializeTweets(s);

          print(s);
          return TabBarView(
            controller: tabController,
            children: <Widget>[
              CustomScrollView(
                scrollBehavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                slivers: [
                  SliverToBoxAdapter(
                    child: kIsWeb
                        ? AddPost()
                        : Container(
                            height: 0,
                            width: 0,
                          ),
                  ),
                  SliverList(
                    delegate:
                        SliverChildBuilderDelegate(childCount: tweets.length,
                            (BuildContext context, int index) {
                      return CustomTweet(
                        forProfile: false,
                        tweet: tweets[index],
                      );
                    }),
                  ),
                ],
              ),
              // CustomScrollView(
              //   slivers: [
              //     SliverToBoxAdapter(
              //       child: kIsWeb
              //           ? AddPost()
              //           : Container(
              //               height: 0,
              //               width: 0,
              //             ),
              //     ),
              //     SliverList(
              //         delegate: SliverChildBuilderDelegate(childCount: tweets.length,
              //             (BuildContext context, int index) {
              //       return Icon(Icons.directions_transit, size: 350);
              //     }))
              //   ],
              // )
            ],
          );
        }
      },
    );
  }
}
