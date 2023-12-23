import 'package:flutter/material.dart';

class ShareArticle {

  Future<void> bottomSheet(context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
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
                              Image.asset(
                                'assets/images/app_logos/chrome.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                              ),
                              const Text('Chrome'),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/app_logos/whatsApp.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                              ),
                              const Text('WhatsApp'),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/app_logos/twitter.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                              ),
                              const Text('X'),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/app_logos/facebook.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                              ),
                              const Text('Meta')
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/app_logos/gmail.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                              ),
                              const Text('Gmail'),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/app_logos/linkedIn.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                              ),
                              const Text('LinkedIn'),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/app_logos/instagram.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
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
                                onTap: (){},
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