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

function! slack#CheckHistory() abort
    if bufnr('slackbuf') == -1
        vsplit slackbuf
        setlocal buftype=nowrite
        setlocal bufhidden=wipe
    else
        %d
    endif
ruby << EOF

    require 'net/http'
    require 'json'
    res = Net::HTTP.post_form(URI.parse('https://slack.com/api/channels.history'),{
        'token' => VIM.evaluate('s:slack_token'),
        'channel' => VIM.evaluate('s:slack_channel')
    })
    json_res = JSON.parse(res.body)
    res_re = json_res["messages"].reverse

    json_res["messages"].each do |res|
        if res["type"] == "message" then
            user_name = res["user"]
            text = res["text"]
            VIM.command("let s:slack_user = '#{user_name}'")
            VIM.command("let s:slack_text = '#{text}'")
            VIM.command("call append('.', '#{user_name}' . ':' . '#{text}')")
        end
    end
EOF
endfunction

function! slack#ListChannel() abort
ruby << EOF
    
    require 'net/http'
    require 'json'
    res = Net::HTTP.post_form(URI.parse('https://slack.com/api/channels.list'),{
        'token' => VIM.evaluate('s:slack_token'),
    })


    json_res = JSON.parse(res.body)
    json_res["channels"].each do |res|
        channel_name = res["name"]
        channel_id = res["id"]
        puts " - #{channel_name}: #{channel_id}"
    end

EOF
endfunction
