let s:slack_token = get(g:, 'slack_token', '')
let s:slack_channel = "general"

function! slack#SendMessage(Message) abort

    echo system("curl -XPOST 'https://slack.com/api/chat.postMessage?token=" . s:slack_token . "&channel=" . s:slack_channel . "&text=" . a:Message . "&as_user=true'")

endfunction

function! slack#ChangeChannel(channel) abort
    let s:slack_channel = a:channel
    echo "Now Channel is " . s:slack_channel
endfunction

function! slack#CheckNowChannel() abort
    echo "Now Channel is " . s:slack_channel
endfunction

function! slack#rubytest()
ruby << EOF
    puts("hoge")
EOF
endfunction

function! slack#SendMessageRuby(Message) abort
ruby << EOF

    require 'net/http'
    response = Net::HTTP.post_form(URI.parse('https://slack.com/api/chat.postMessage'),{
        'token' => VIM.evaluate('s:slack_token'),
        'channel' => VIM.evaluate('s:slack_channel'),
        'text' => VIM.evaluate('a:Message'),
        'as_user' => 'true'
    })
    puts response.body
EOF
endfunction
