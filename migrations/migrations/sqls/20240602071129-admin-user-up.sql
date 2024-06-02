SET search_path = sample;

CREATE USER personify_read_user WITH PASSWORD 'env_password';

-- make sure to reset search path to public, so migration can be registered
SET search_path = public;

