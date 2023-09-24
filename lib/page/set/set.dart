import 'package:flutter/material.dart';

class settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Settings = setListTile(); //避免重绘
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 250, 250), body: Settings);
  }

// todo 点击事件【路由跳转】
  Widget setListTile() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          margin: EdgeInsets.all(8.0),
          child: Column(children: [
            Image.asset(
              'assets/image/info.jpg',
              fit: BoxFit.fitWidth,
              width: 400,
              height: 130,
            ),
            _buildListTile(Icons.switch_account, '账号信息'),
            _buildListTile(Icons.security, '账号安全'),
            _buildListTile(Icons.wechat, '账号绑定')
          ])),
      Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          margin: EdgeInsets.all(8.0),
          child: Column(children: [
            _buildListTile(Icons.mail, '我的投稿'),
            _buildListTile(Icons.interests, '我的收藏'),
            _buildListTile(Icons.schedule, '历史记录')
          ])),
      Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          margin: EdgeInsets.all(8.0),
          child: Column(children: [
            AboutListTile(
                icon: Icon(Icons.info),
                applicationIcon: FlutterLogo(),
                applicationName: '我的新闻应用',
                applicationVersion: 'v1.0',
                applicationLegalese: 'Copyright© 2023-20xx 楊蘇國'),
          ]))
    ]);
  }

  // 列表项
  ListTile _buildListTile(icon, title) {
    return ListTile(
      tileColor: Colors.white,
      visualDensity: VisualDensity(horizontal: 0.1, vertical: 0.1),
      // contentPadding: EdgeInsets.all(1.25),
      leading: Icon(
        icon,
        size: 33.0,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      title: Text(title),
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 16.4, fontWeight: FontWeight.normal),
    );
  }
}
