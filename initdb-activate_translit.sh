#!/bin/sh
POSTGRES="gosu postgres postgres"
# extension don't can't be created in single use mode!
#$POSTGRES --single -E <<EOSQL
$POSTGRES -E <<EOSQL
CREATE FUNCTION transliterate(text) RETURNS text AS '$libdir/utf8translit', 'transliterate' LANGUAGE C STRICT;
EOSQL
