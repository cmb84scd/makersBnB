ALTER TABLE users ADD CONSTRAINT dups UNIQUE(email, username);
