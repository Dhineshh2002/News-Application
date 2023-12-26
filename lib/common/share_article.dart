import 'package:flutter/material.dart';

class ShareArticle {

  Future<void> bottomSheet(context, String? articleTitle) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 370,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    articleTitle ?? '',
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: SizedBox(
                      height: 180,
                      child: GridView(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 90,
                          mainAxisSpacing: 3,
                        ),
                        children: [
                          Column(
                            children: [
                              InkWell(
                                child: Image.asset(
                                  'assets/images/app_logos/chrome.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                                onTap: (){},
                              ),
                              const Text('Chrome'),
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                child: Image.asset(
                                  'assets/images/app_logos/whatsApp.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                                onTap: (){},
                              ),
                              const Text('WhatsApp'),
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                child: Image.asset(
                                  'assets/images/app_logos/twitter.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                                onTap: (){},
                              ),
                              const Text('X'),
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                child: Image.asset(
                                  'assets/images/app_logos/facebook.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                                onTap: (){},
                              ),
                              const Text('Meta')
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                child: Image.asset(
                                  'assets/images/app_logos/gmail.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                                onTap: (){},
                              ),
                              const Text('Gmail'),
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                child: Image.asset(
                                  'assets/images/app_logos/linkedIn.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                                onTap: (){},
                              ),
                              const Text('LinkedIn'),
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                child: Image.asset(
                                  'assets/images/app_logos/instagram.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                                onTap: (){},
                              ),
                              const Text('Instagram'),
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                child: Image.asset(
                                  'assets/images/app_logos/telegram.png',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                                onTap: () {},
                              ),
                              const Text('Telegram'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
