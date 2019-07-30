import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'fultter动画详解';
    return new MaterialApp(
      title: appTitle,
      home: new MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: new Duration(
            milliseconds: 1000,
          ),
          child: new Container(
            width: 300.0,
            height: 300.0,
            color: Colors.pinkAccent,
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          setState(() {
            _visible = !_visible;
          });
        },
        tooltip: '显示隐藏',
        child: new Icon(Icons.flip),
      ),
    );
  }
}

class DFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('页面切换动画'),
      ),
      body: new GestureDetector(
        child: new Center(
          child: new Hero(
            tag: '第一张图片',
            child: new Image.asset('images/1.jpg'),
          ),
        ),
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(builder: (_) {
            return new DSecondPage();
          }));
        },
      ),
    );
  }
}

class DSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('页面切换动画'),
        ),
        body: new GestureDetector(
          child: new Center(
              child: new Hero(
            tag: '第一张图片',
            child: new Image.asset('images/2.jpg'),
          )),
        ));
  }
}

//void main() {
//  runApp(new MaterialApp(
//    title: '页面切换动画',
//    home: new DFirstPage(),
//  ));
//}
//void main() {
//  runApp(new MaterialApp(
//    title: '跳转页面返回数据',
//    home: new FirstPage(),
//  ));
//}
class Product {
  final String title;
  final String description;

  Product(this.title, this.description);
}
//void main() => runApp(new MaterialApp(
//      title: '传递数据示例',
//      //title: '导航页面示例',
//      home: new ProductList(
//          products:
//              new List.generate(20, (i) => new Product('商品$i', '这是一个商品详情$i'))),
//      //home: new FirstScreen(),
//    )
//);

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('跳转页面返回数据'),
      ),
      body: new Center(
        child: RouteButton(),
      ),
    );
  }
}

class RSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('选择一条数据'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new RaisedButton(
                onPressed: () {
                  Navigator.pop(context, '你好');
                },
                child: new Text('你好'),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new RaisedButton(
                onPressed: () {
                  Navigator.pop(context, '我爱你');
                },
                child: new Text('我爱你'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigatToSecondPage(context);
      },
      child: new Text('选择一个选项'),
    );
  }

  _navigatToSecondPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new RSecondPage()),
    );
    Scaffold.of(context)
        .showSnackBar(new SnackBar(content: new Text('$result')));
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({Key key, @required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('商品列表'),
      ),
      body: new ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return new ListTile(
            title: new Text(products[index].title),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new ProductDetail(product: products[index])),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;

  ProductDetail({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("${product.title}"),
        ),
        body: new Padding(
          padding: new EdgeInsets.all(15.0),
          child: new Text('${product.description}'),
        ));
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('导航页面实例-页面1'),
      ),
      body: new Center(
        child: new RaisedButton(
          child: new Text('页面2'),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new SecondPage()),
            );
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('导航页面实例-页面2'),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('返回页面1'),
        ),
      ),
    );
  }
}
