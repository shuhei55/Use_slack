# Use_slack

* 何かあればぜひ言ってほしいです
* 裏でrubyを動かすことによって作っている
* neovimでしか動かないと思う
* deinで入れるとよいと思う。
* vim がrubyを使えていてさらに、terminalで"sudo gem install vim"をしなければ使えない
* dein で入れたらinit.vimに
  let g:slack_token = "使いたいWorkSpaceの自分のトークン"
* と追加
*トークンはググればでてくると思う
* vimを立ち上げるときのデフォルトのチャンネルはnullpterなので立ち上げるたびSlackChangeChannelで変更してあげる必要がある。
* 使えるようになるコマンド一覧
** SlackSendMessage <メッセージ内容>
*** 引数のメッセージを現在のチャンネルIDのチャンネルに送る
** SlackChangeChannel <チャンネルID>
*** 引数のチャンネルIDのチャンネルに移動する
*** IDなので名前だとだめです。対応するのめんどくさくてやってない
*** IDは下のSlackListChannelで確認してください
** SlackCheckNowChannel 
*** 現在のチャンネルIDを確認する
** SlackRubySendMessage <メッセージ内容>
*** 引数のメッセージを現在のチャンネルに送る
*** SlackSendMessageと同じ
*** 裏でrubyで書き直しただけ
** SlackRubyCheckHistory 
*** 現在のチャンネルの履歴を参照する
*** 自動でvsplitされてそのバッファーに表示される
** SlackListChannel
*** チャンネルとチャンネルID一覧が見れる
** SlackSendThisFile <コメント内容>
*** 現在編集中のファイルを引数のコメントともに現在のチャンネルへ送る
** SlackSendPartOfThisFile <コメント内容> <行数１> <行数２>
*** 現在編集中のファイルの引数の行の間だけ引数のコメントをつけて現在のチャンネルに送信される

