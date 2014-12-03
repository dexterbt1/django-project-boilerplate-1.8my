#!/bin/bash
set -e
# this assumes one domain for everything, for app + static + media uploads
# important note: set your WEBAPP_MEDIA_URL_DOMAIN and WEBAPP_STATIC_URL_DOMAIN to the same value as WEBAPP_MAIN_DOMAIN
# ---



cat <<EOFLIGHTY
\$HTTP["host"] =~ "^$WEBAPP_MAIN_DOMAIN" {
    alias.url = (
        "$WEBAPP_STATIC_URL_PATH" => "$WEBAPP_STATIC_ROOT/",
        "$WEBAPP_MEDIA_URL_PATH" => "$WEBAPP_MEDIA_ROOT/"
    )
    url.rewrite-once = (
        "^/favicon\.ico$" => "$WEBAPP_STATIC_URL_PATH/favicon.ico",
        "^/robots\.txt" => "$WEBAPP_STATIC_URL_PATH/robots.txt"
    )
    setenv.add-response-header = ( 
      "Access-Control-Allow-Origin" => "*" 
    )
    \$HTTP["url"] !~ "^($WEBAPP_STATIC_URL_PATH|$WEBAPP_MEDIA_URL_PATH|/favicon.ico|/robots.txt)" {
        proxy.server = (
            "" => ( 
                ( "host" => "$WEBAPP_GUNICORN_HOST", "port" => $WEBAPP_GUNICORN_PORT1 ), 
                ( "host" => "$WEBAPP_GUNICORN_HOST", "port" => $WEBAPP_GUNICORN_PORT2 ), 
                ( "host" => "$WEBAPP_GUNICORN_HOST", "port" => $WEBAPP_GUNICORN_PORT3 ),
                ( "host" => "$WEBAPP_GUNICORN_HOST", "port" => $WEBAPP_GUNICORN_PORT4 )
            )
        )
    }
}

# no-www policy (redirect www.* to just the domain)
# ---
\$HTTP["host"] =~ "^www.$WEBAPP_MAIN_DOMAIN" {
    url.redirect = (
        "^/(.*)\$" => "http://$WEBAPP_MAIN_DOMAIN/\$1"
    )
}


EOFLIGHTY

