# https://qiita.com/izumin5210/items/c683cb6addc58cae59b6
# set $SLACK_WEBHOOK_URL and $SLACK_USER_NAME

function notify_preexec {
  notif_prev_executed_at=`date +"%Y/%-m/%-d(%a) %k:%M:%S"`
  notif_prev_command=$2
  notif_prev_cmd="${notif_prev_command[(ws: :)1]}"
  notified=false
}

ignore_cmds=(man less lv zless tmux nvidia-smi)
SLACK_NOTIF_THRESHOLD=120

function notify_precmd {
  notif_status=$?
  if [ -n "${SLACK_WEBHOOK_URL+x}" ] && [ -n "${SLACK_USER_NAME+x}" ] && [ "$notified" = false ] && [ $TTYIDLE -gt ${SLACK_NOTIF_THRESHOLD:-120} ] && [ $notif_status -ne 130 ] && [ $notif_status -ne 146 ] && [ ${ignore_cmds[(I)${notif_prev_cmd}]} -eq 0 ]; then
    notif_title=$([ $notif_status -eq 0 ] && echo "Command succeeded :white_check_mark:" || echo "Command failed :x:")
    notif_color=$([ $notif_status -eq 0 ] && echo "good" || echo "danger")
    # notif_icon=$([ $notif_status -eq 0 ] && echo ":angel:" || echo ":smiling_imp:")
    notif_icon=":clock3:"
    payload=`cat << EOS
{
  "username": "command result",
  "icon_emoji": "$notif_icon",
  "text": "<@$SLACK_USER_NAME>",
  "attachments": [
    {
      "color": "$notif_color",
      "title": "$notif_title",
      "mrkdwn_in": ["fields"],
      "fields": [
        {
          "title": "command",
          "value": "\\\`$notif_prev_command\\\`",
          "short": false
        },
        {
          "title": "directory",
          "value": "\\\`$(pwd)\\\`",
          "short": false
        },
        {
          "title": "hostname",
          "value": "$(hostname)",
          "short": true
        },
        {
          "title": "user",
          "value": "$(whoami)",
          "short": true
        },
        {
          "title": "executed at",
          "value": "$notif_prev_executed_at",
          "short": true
        },
        {
          "title": "elapsed time",
          "value": "$TTYIDLE seconds",
          "short": true
        }
      ]
    }
  ]
}
EOS
`
    curl --silent --request POST \
      --header 'Content-type: application/json' \
      --data "$(echo "$payload" | tr '\n' ' ' | tr -s ' ')" \
      $SLACK_WEBHOOK_URL > /dev/null
  fi
  notified=true
}


if [ -z "${SLACK_WEBHOOK_URL+x}" ]; then
  echo "SLACK_WEBHOOK_URL is empty."
fi

if [ -z "${SLACK_USER_NAME+x}" ]; then
  echo "SLACK_USER_NAME is empty."
fi

if [ -n "${SLACK_WEBHOOK_URL+x}" ] && [ -n "${SLACK_USER_NAME+x}" ]; then
    add-zsh-hook preexec notify_preexec
    add-zsh-hook precmd notify_precmd
    echo "Enabled Slack notification."
fi
