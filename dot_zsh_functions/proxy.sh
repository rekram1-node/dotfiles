proxy() {
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

  local cert="$HOME/.mitmproxy/mitmproxy-ca-cert.pem"
  local proxy_url="http://127.0.0.1:58888"

  export NODE_EXTRA_CA_CERTS="$cert"
  export CODEX_CA_CERTIFICATE="$cert"
  export HTTPS_PROXY="$proxy_url"
  export HTTP_PROXY="$proxy_url"
  export ALL_PROXY="$proxy_url"
  export WS_PROXY="$proxy_url"
  export WSS_PROXY="$proxy_url"
  export NO_PROXY="localhost,127.0.0.1"

  "$@"
  local status=$?

  kill "$pid" 2>/dev/null
  wait "$pid" 2>/dev/null
  unset NODE_EXTRA_CA_CERTS CODEX_CA_CERTIFICATE
  unset HTTPS_PROXY HTTP_PROXY ALL_PROXY WS_PROXY WSS_PROXY NO_PROXY

  return "$status"
}
