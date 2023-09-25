import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

// todo 路由跳转，不使用索引跳转
// todo 判断是否登录【状态管理，相关内容和是否禁用】
// todo 登录表单【from组件数据验证】

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      body: ListView(
        children: [
          SizedBox(height: 55.0),
          title(),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 60),
              Card(
                margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  maxLines: 1,
                  expands: false,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black26,
                      ),
                      hintText: "Username",
                      hintStyle: TextStyle(color: Colors.black26),
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  // maxLength: 10,
                  maxLines: 1,
                  expands: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black26,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.black26),
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 275.0),
                child: TextButton(onPressed: () {}, child: Text('忘记密码?')),
              ),
              SizedBox(height: 5),
              Buttongroup(),
              SizedBox(height: 100),
              Secondarytext(),
              SizedBox(height: 20),
              Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconOrnament('assets/icon/tx.png'),
                    SizedBox(width: 15),
                    IconOrnament('assets/icon/dd.png'),
                    SizedBox(width: 15),
                    IconOrnament('assets/icon/TIM.png'),
                    SizedBox(width: 15),
                    IconOrnament('assets/icon/wx.png')
                  ])
            ]),
          )
        ],
      ),
    );
  }

  // 标题文字
  Widget title() {
    return Padding(
      padding: EdgeInsets.only(left: 40.0),
      child: Row(
        children: [
          Text('“每天发现新知识”',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0)),
          SizedBox(width: 10.0)
        ],
      ),
    );
  }

  // 辅助文字
  Widget Secondarytext() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('第三方登录',
            style: TextStyle(color: Colors.black45, fontSize: 15.0))
      ],
    );
  }

  Widget IconOrnament(icon) {
    return Image.asset(
      icon,
      fit: BoxFit.cover,
      width: 60,
      height: 60,
    );
  }

  // 按钮组
  Widget Buttongroup() {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black87,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
            ),
            child: const Text("注册"),
            onPressed: () {},
          ),
        ),
        SizedBox(width: 21),
        Container(
          width: 200,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.amber.withOpacity(0.85),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
            ),
            child: const Text("登录"),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
