#!/bin/bash
function check {
  echo "$1 | $(curl -s -o /dev/null -w '%{http_code}' $1)"
}

check 'http://libie.ru'
check 'http://blog.mdnbar.com'
check 'http://api.tvand.me/tvb/api/system'
check 'http://tvand.me'
check 'http://nf.mdnbar.com'
check 'https://bvsandbox.herokuapp.com'
check 'https://bvsandbox.herokuapp.com/demo/'
