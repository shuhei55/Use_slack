# Use_slack

何かあればぜひ言ってほしいです<br>
裏でrubyを動かすことによって作っている<br>
neovimでしか動かないと思う<br>
deinで入れるとよいと思う。<br>
vim がrubyを使えていてさらに、terminalで"sudo gem install vim"をしなければ使えない<br>
dein で入れたらinit.vimに<br>

 let g:slack_token = "使いたいWorkSpaceの自分のトークン"

と追加<br>
トークンはググればでてくると思う<br>
vimを立ち上げるときのデフォルトのチャンネルはnullpterなので立ち上げるたびSlackChangeChannelで変更してあげる必要がある。<br>
使えるようになるコマンド一覧<br>
    * SlackSendMessage <メッセージ内容><br>
        * 引数のメッセージを現在のチャンネルIDのチャンネルに送る<br>
    * SlackChangeChannel <チャンネルID><br>
        * 引数のチャンネルIDのチャンネルに移動する<br>
        * IDなので名前だとだめです。対応するのめんどくさくてやってない<br>
        * IDは下のSlackListChannelで確認してください<br>
    * SlackCheckNowChannel<br>
        * 現在のチャンネルIDを確認する<br>
    * SlackRubySendMessage <メッセージ内容><br>
        * 引数のメッセージを現在のチャンネルに送る<br>
        * SlackSendMessageと同じ<br>
        * 裏でrubyで書き直しただけ<br>
    * SlackRubyCheckHistory<br>
        * 現在のチャンネルの履歴を参照する<br>
        * 自動でvsplitされてそのバッファーに表示される<br>
    * SlackListChannel<br>
        * チャンネルとチャンネルID一覧が見れる<br>
    * SlackSendThisFile <コメント内容><br>
        * 現在編集中のファイルを引数のコメントともに現在のチャンネルへ送る<br>
    * SlackSendPartOfThisFile <コメント内容> <行数１> <行数２><br>
        * 現在編集中のファイルの引数の行の間だけ引数のコメントをつけて現在のチャンネルに送信される<br>
