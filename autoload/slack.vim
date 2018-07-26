let s:slack_token = get(g:, 'slack_token', '')
let s:slack_channel = "CBTQFF9D1"

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
            if user_name != nil
                user_name.size.times do |i|
                    if user_name[i] == "'" then
                        user_name[i] = '"'
                    end
                end
            end
            text = res["text"]
            if text != nil
                text.size.times do |i|
                    if text[i] == "'" then
                        text[i] = '"'
                    end
                end
            end
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

function! slack#SendThisFile(slack_comment) abort
ruby << EOF
    require 'net/http'
    require 'json'

    cb = Vim::Buffer.current
    num = cb.count
    slack_file_buf = ""
    num.times do |i|
        slack_file_buf += cb.itself[i+1] + "\n"
    end

    res = Net::HTTP.post_form(URI.parse('https://slack.com/api/files.upload'),{
                    'token' => VIM.evaluate('s:slack_token'),
                    'channels' => VIM.evaluate('s:slack_channel'),
                    'initial_comment' => VIM.evaluate('a:slack_comment'),
                    'content' => slack_file_buf,
                    'title' => VIM.evaluate('expand("%")'),
                    'filetype' => VIM.evaluate('expand("e:%")')
                    })
    json_res = JSON.parse(res.body)

    puts json_res
EOF
endfunction

function! slack#SendPartOfThisFile(slack_comment, l1, l2)
ruby << EOF
    require 'net/http'
    require 'json'

    cb = Vim::Buffer.current
    if VIM.evaluate('a:l1').to_i < VIM.evaluate('a:l2').to_i then
        above = VIM.evaluate('a:l1').to_i
        under = VIM.evaluate('a:l2').to_i
    elsif
        above = VIM.evaluate('a:l2').to_i
        under = VIM.evaluate('a:l1').to_i
    end
        
    num = 1 + under - above
    slack_file_buf = ""
    num.times do |i|
        slack_file_buf += cb.itself[above + i] + "\n"
    end

    res = Net::HTTP.post_form(URI.parse('https://slack.com/api/files.upload'),{
                    'token' => VIM.evaluate('s:slack_token'),
                    'channels' => VIM.evaluate('s:slack_channel'),
                    'initial_comment' => VIM.evaluate('a:slack_comment'),
                    'content' => slack_file_buf,
                    'title' => VIM.evaluate('expand("%")'),
                    'filetype' => VIM.evaluate('expand("e:%")')
                    })
    json_res = JSON.parse(res.body)

    puts json_res

EOF
endfunction
