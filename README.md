# リアルタイムチャット-Client側テスト用プログラム
## 最終目標
Rubyサーバを経由したリアルタイムチャットのモバイルアプリ作成 by Swift3

## 方針
#### 1.Webソケット通信(双方向通信が可能かつ通信コストが低いなどの利点から採用)
#### 2.JSON使用(発信者や日付など多数のデータをやりとりしたい)

## (次の)目標
* バグ取り
* roomを出入りしていると稀にindex.rowの値が狂い範囲外配列にアクセスしようとして落ちる
* キーボード出現と共にViewの下限も上がってほしい(現状キーボードで最新メッセージが隠れてしまう)

## 進捗
* アプリ初回起動時にユーザ登録(ユーザ名とユーザIDは永続保存)
* Room機能完成
* 上にスワイプでRoom一覧を更新できる
* アプリ起動時に最新のRoom一覧を取得
* Room作成はリアルタイムで更新される
* Room名と共に現時刻を基準にしたRoom作成時刻表示
* Room一覧は作成日時から順に表示
* Roomは削除もできる
* Chat機能完成
* Roomに入る度にLogも取得できる
* 発言者によってメッセージを左右に振り分けている(Line風)
* キーボードは外部タッチすると自動で閉じる

## メモ
* Webソケット通信(ActionCable)を使用
* 入力欄は伸縮性あり
* 最低限の複数人チャットに成功
* storyboard使わない方針
