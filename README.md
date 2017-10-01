## Code for 選挙プロジェクトへようこそ

Code for 選挙プロジェクトは、2017年衆議院選挙候補者のオープンなデータベースを作り、候補者の政策及び過去の実績を中立的に参照できるサイトを制作することを目的としています。

## 色々ある選挙速報サイトとは何が違うのか

- 我々が作るデータは、オープンで二次利用可能とします。
- データのダウンロードも可能とします。
- また、政治家に関する世界標準形式である、[Popolo](http://www.popoloproject.com/) というデータフォーマットでデータを整備します。
- 誰でもデータ作成やツール開発に参加できます。

## 具体的に何をしたいのか

* 郵便番号を入れるだけで、該当選挙区の候補者が表示され、その候補者の実績及び政策がわかるサイトを作る
* 候補者のデータは Popolo 形式で整備する
* 上記データはWikidataにも投入する
     * [Wikidataの情報（参考資料）](https://docs.google.com/spreadsheets/d/1ibTdsVo57EykrWKOOBSkcoJSVD-7jSGNMnN3QzmFvYI/edit#gid=537811440)
     * [2006年松戸市長選挙](https://www.wikidata.org/wiki/Q29422608)
     * [2014年松戸市議会議員選挙](https://www.wikidata.org/wiki/Q29423018)
* データは二次利用可能な形で公開する
* データ作成はなるべく参加型にしたい（事実情報のみを積み上げ、荒らしや政治色は排除する）

詳しくは、以下のページをご確認ください  
[情報まとめページ](https://hackmd.io/s/rkXhmQjjW)


## 作成したデータについて

### 郵便番号-小選挙区検索データ
- 7桁の郵便番号（事業所番号は除く）から、対応する289選挙区への対応を取れるオープンデータを作成しました。
- データ仕様
  - 郵便番号をキーとして格納
  - 該当郵便番号の基礎自治体の行政コード、および小選挙区番号が含まれます
  - 都道府県は行政コードからご利用ください。
```json
{
  "1050000":{"cityCode":"13103","senkyoNum":"1"},
  "1050001":{"cityCode":"13103","senkyoNum":"2"},
  "1050002":{"cityCode":"13103","senkyoNum":"2"},
  //以下略
}

```
- [ダウンロード](https://github.com/codeforjapan/codeforelection/blob/master/data/json/postal2senkyoku.json)
- [データに関するREADME](https://github.com/codeforjapan/codeforelection/blob/master/data/README.md)
- [利用データ/東大西沢先生作成小選挙区データ](http://www.csis.u-tokyo.ac.jp/~nishizawa/senkyoku/)
- [利用データ/郵便番号](http://www.post.japanpost.jp/zipcode/download.html)


## 実際の作業について

実際のデータ収集プログラムは、[こちらの Github リポジトリ](https://github.com/codeforjapan/codeforelection)で開発を開始しています。

## メンバー

一般社団法人Code for Japan 及び有志メンバーによって開発されています。
メンバーについては[情報まとめページ](https://hackmd.io/s/rkXhmQjjW)をご確認ください。

## コントリビューター募集中

このプロジェクトには、誰でも貢献ができます。  
今の政治の状況に対して声をあげるのも大事ですが、実際に手を動かすことで、政治家の活動の見える化に協力しませんか？
各候補者の、過去の国会での発言や政策など、事実情報を淡々と積み上げることで、多くの人が正しい投票を行うサポートができるはずです。

[情報まとめページ](https://hackmd.io/s/rkXhmQjjW) 内にかかれている、Slack チャンネルから議論に参加できます。

### お問い合わせ

info@code4japan.org までご連絡ください
