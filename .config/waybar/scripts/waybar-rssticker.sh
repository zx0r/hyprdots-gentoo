#!/bin/sh

feed="$1"
title="$2"
cmd="$3"

rsssum="$(printf "%s" "$feed" | md5sum | cut -d ' ' -f1)"
rssfile="/tmp/rssticker.$rsssum"
rssnrfile="/tmp/rsstickernr.$rsssum"

rssitemnr=-1
[ -f "$rssnrfile" ] && rssitemnr=$(cat "$rssnrfile")

if [ "$cmd" = "open" ]; then
  xdg-open "$(jq --raw-output ".[$rssitemnr].link" "$rssfile")"
  exit 0
fi

# Replace cexec with direct curl
curl -s "$feed" | dasel -r xml -w json | jq "[if (.RDF | length) != 0 then .RDF.item[] | { title, link } else .rss.channel.item[] | { title, link } end]" >"$rssfile"

rssitemnr=$((rssitemnr + 1))
maxrssitemnr=$(jq '. | length' "$rssfile")
[ "$rssitemnr" -ge "$maxrssitemnr" ] && rssitemnr=0

jq -c ".[$rssitemnr] | { text: (\"<span color='#ffff00'>$title</span> <span color='#505050'>\" + .title + \"</span>\"), tooltip: .link, class: \"rss-item\" }" "$rssfile"

printf "%s" "$rssitemnr" >"$rssnrfile"
