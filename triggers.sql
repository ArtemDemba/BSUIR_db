CREATE OR REPLACE FUNCTION create_notice() RETURNS trigger AS $$
DECLARE
	rec record;
	str text := '';
BEGIN
	IF TG_LEVEL='ROW' THEN 
		CASE TG_OP
			WHEN 'DELETE' THEN rec := OLD; str := OLD::text;
			WHEN 'UPDATE' THEN rec := NEW; str := OLD || ' -> ' || NEW;
			WHEN 'INSERT' THEN rec := NEW; str := NEW::text;
		END CASE;
	END IF;
	RAISE NOTICE '% % % %: %', TG_TABLE_NAME, TG_WHEN, TG_OP, TG_LEVEL, str;
	RETURN rec;	
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER notice_before_op
BEFORE INSERT OR UPDATE OR DELETE ON publishers
FOR EACH STATEMENT EXECUTE PROCEDURE create_notice();

CREATE TRIGGER notice_before_op_row
BEFORE INSERT OR UPDATE OR DELETE ON publishers
FOR EACH ROW EXECUTE PROCEDURE create_notice();

INSERT INTO publishers(org_name, address, country, email, phone) VALUES
('name 2', 'address 2', 'country 2', 'email 2', 'phone 2');

UPDATE publishers
SET org_name='updated org_name'
WHERE publisher_id=5;


CREATE OR REPLACE FUNCTION check_log_for_info() RETURNS trigger AS $$
BEGIN
	IF length(NEW.log_message) < 10 THEN
		RAISE EXCEPTION 'Сообщение недостаточно информативное: длина меньше 10 символов';
		RETURN NULL;
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER checking_trigger
BEFORE INSERT ON logging
FOR EACH ROW EXECUTE PROCEDURE check_log_for_info();

INSERT INTO logging(log_message, user_id) VALUES
('12D34', 5);
