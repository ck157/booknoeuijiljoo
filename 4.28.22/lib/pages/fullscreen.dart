import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Lobby.dart';

import 'auth_service.dart';

void main() {
  runApp(fullscreen());
}

class fullscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 원하는 방향으로 화면 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final authService = context.read<AuthService>();

        String? achievement = (int.parse(authService.readpage as String) *
                100 /
                int.parse(authService.totalpage as String))
            .toString();

        if (achievement.length == 1) {
          achievement = achievement.substring(0, 1);
        } else if (achievement.length == 2) {
          achievement = achievement.substring(0, 2);
        } else if (achievement.length == 3) {
          achievement = achievement.substring(0, 3);
        } else {
          achievement = achievement.substring(0, 3);
        }
        //위치 조정 변수 multiple설정
        var multiple = int.parse(achievement.split(".")[0]);
        return Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset('lib/images/Map.jpg'),
                    ),
                    Positioned(
                      top: 200,
                      child: Image.asset(
                        'lib/images/backlight.png',
                      ),
                    ),
                    Positioned(
                      left: 556,
                      top: 200,
                      child: Image.asset(
                        'lib/images/backlight.png',
                      ),
                    ),
                    Positioned(
                      left: 1150 * multiple / 100,
                      bottom: 130,
                      child: Image.asset('lib/images/Main_character.png',
                          height: 55, width: 55),
                    ),
                    Positioned(
                      left: 130,
                      bottom: 90,
                      child: Image.asset('lib/images/Blue_Mon.png',
                          height: 55, width: 55),
                    ),
                    Positioned(
                      left: 300,
                      bottom: 90,
                      child: Image.asset('lib/images/Green_Mon.png',
                          height: 55, width: 55),
                    ),
                    Positioned(
                      right: 700,
                      bottom: 130,
                      child: Image.asset('lib/images/Green_Egg.png',
                          height: 55, width: 55),
                    ),
                    Positioned(
                      right: 400,
                      bottom: 90,
                      child: Image.asset('lib/images/Green_Mon2.png',
                          height: 55, width: 55),
                    ),
                    Positioned(
                      right: 200,
                      bottom: 130,
                      child: Image.asset('lib/images/Red_Mon2.png',
                          height: 55, width: 55),
                    ),
                    Positioned(
                      right: 350,
                      bottom: 130,
                      child: Image.asset('lib/images/Green_Egg.png',
                          height: 55, width: 55),
                    ),
                    Positioned(
                      right: 60,
                      bottom: 110,
                      child: Image.asset('lib/images/goal.png',
                          height: 130, width: 100),
                    ),
                    Positioned(
                      left: 20,
                      top: 30,
                      child: IconButton(
                        icon: Icon(CupertinoIcons.chevron_back,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LobbyPage(),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
