if exists('g:loaded_slack')
    finish
endif

let g:loaded_slack = 1

command! -nargs=1 SlackSnedMessage call slack#SendMessage(<f-args>)

command! -nargs=1 SlackChangeChannel call slack#ChangeChannel(<f-args>)

command! SlackCheckNowChannel call slack#CheckNowChannel()