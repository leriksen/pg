SET search_path = sample;

CREATE USER personify_read_user WITH PASSWORD '${ADMIN_PASSWORD}';

-- make sure to reset search path to public, so migration can be registered
SET search_path = public;

