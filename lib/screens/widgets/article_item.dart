import 'package:flutter/material.dart';
import 'package:news/screens/webview_screen.dart';

Widget buildArticleItem(article,context) {
  return InkWell(
    onTap: (){
      navigateTo(context, WebViewScreen(url: article['url'],));
    },
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image(
            image: NetworkImage(article['urlToImage'] ??
                'https://www.logaster.com/blog/wp-content/uploads/2020/03/1010.png'),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget myDivider() {
  return const Divider(
    thickness: 1.5,
    color: Colors.grey,
  );
}

void navigateTo(context , widget) => Navigator.push(context, MaterialPageRoute(builder:(context)=>widget ));
