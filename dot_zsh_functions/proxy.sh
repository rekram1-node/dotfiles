proxy(){
  if [[ -z "$1" ]]; then
    echo "Usage: proxy <command>"
    return 1
  fi

  mitmweb --listen-host 127.0.0.1 --listen-port 58888 --web-open-browser &>/dev/null &
  local pid=$!
  echo -n "Waiting for mitmweb..."
  while ! nc -z 127.0.0.1 58888 2>/dev/null; do
    sleep 0.2
  done
  echo " ready"

  export NODE_EXTRA_CA_CERTS="/Users/$USER/.mitmproxy/mitmproxy-ca-cert.pem"
  export HTTPS_PROXY="http://127.0.0.1:58888"
  export HTTP_PROXY="http://127.0.0.1:58888"
  export NO_PROXY="localhost,127.0.0.1"

  "$@"

  kill "$pid" 2>/dev/null
  wait "$pid" 2>/dev/null
  unset NODE_EXTRA_CA_CERTS HTTPS_PROXY HTTP_PROXY NO_PROXY
}
